import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/components/default_button.dart';
import 'package:dokan_koi/constants.dart';
import 'package:dokan_koi/models/Product.dart';
import 'package:dokan_koi/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'product_description.dart';
import 'product_images.dart';
import 'top_rounded_container.dart';

class Body extends StatelessWidget {
  final Product product;
  FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('cart');
  final CollectionReference _shop =
      FirebaseFirestore.instance.collection('shop');

  Body({Key? key, required this.product}) : super(key: key);
  var a;
  

  @override
  Widget build(BuildContext context) {
   
    return StreamBuilder(
      stream: _shop.doc(product.id).snapshots(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        return ListView(
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
                    pressOnSeeMore: () {},
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              "${data!["image"]}"),
                          backgroundColor: Colors.white,
                          radius: 30,
                        ),

                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              " ",
                              // data['title'],
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
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
                      press: () {
                        _products.add({
                          "title": product.title,
                          "price": product.price.toInt(),
                          "qty": 1,
                          "images": product.images,
                          "sid": product.id,
                          "uid": auth.currentUser?.uid,
                          "user": auth.currentUser?.email,
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
      }
    );
  }
}
