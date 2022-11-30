import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/components/default_button.dart';
import 'package:dokan_koi/constants.dart';
import 'package:dokan_koi/models/Product.dart';
import 'package:dokan_koi/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'product_description.dart';
import 'product_images.dart';
import 'top_rounded_container.dart';

class Body extends StatelessWidget {
  final Product product;
  final String docid;
  FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('cart');
  final CollectionReference _shop =
      FirebaseFirestore.instance.collection('shop');

  Body({Key? key, required this.product ,required this.docid}) : super(key: key);
  var a;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _shop.doc(product.id).snapshots(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                )
              : ListView(
                  padding: EdgeInsets.only(top: 10),
                  children: [
                    ProductImages(product: product),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductDescription(
                            product: product,
                            images: "${data!["image"]}",
                            name: "${data!["name"]}",
                            type: "${data!["type"]}",
                            description: "${data!["description"]}",
                            address: "${data!["address"]}",
                            rating: data!["rating"].toDouble(),
                            lat: data!["lat"].toDouble(),
                            lon: data!["lon"].toDouble(),
                            title: "${data!["name"]}",
                            district: "${data!["district"]}",
                            subDistrict: "${data!["subDistrict"]}",
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(30),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(180),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.15,
                              right: SizeConfig.screenWidth * 0.15,
                              bottom: getProportionateScreenWidth(40),
                              top: getProportionateScreenWidth(15),
                            ),
                            child: DefaultButton(
                              text: "Add To Cart",
                              press: () async {
                                await _products
                                    .where('uid',
                                        isEqualTo: auth.currentUser!.uid)
                                    .where('uuid', isEqualTo: product.uid)
                                    .get()
                                    .then((value) {
                                  if (value.size == 0) {
                                    _products.doc(docid).set({
                                      "title": product.title,
                                      "price": product.price.toInt(),
                                      "qty": 1,
                                      "totalqty":product.qty.toInt(),
                                      "images": product.images,
                                      "uuid": product.uid,
                                      "docid":docid,
                                      "sid": product.id,
                                      "uid": auth.currentUser?.uid,
                                      "user": auth.currentUser?.email,
                                    });
                                  } else {
                                    var v = value.docs.first.data()
                                        as Map<String, dynamic>;
                                    _products
                                        .doc(value.docs.first.id)
                                        .update({"qty": v['qty'] + 1});
                                    print(docid);
                                    print("object");
                                  }
                                });

                                print(product.id);
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        });
  }
}
