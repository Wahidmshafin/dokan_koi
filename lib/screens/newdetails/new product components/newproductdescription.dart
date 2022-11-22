import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/screens/Shopfollow/Shop Components/roundedcontainer.dart';
import 'package:dokan_koi/screens/Shopfollow/Shop Components/shopproduct.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../models/Store.dart';
import '../../../size_config.dart';
import '../../home/components/section_title.dart';

class ProductDescription extends StatelessWidget {
  ProductDescription({
    Key? key,
    required this.store,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Store store;
  final GestureTapCallback? pressOnSeeMore;
  final _shop = FirebaseFirestore.instance.collection('shop');
  var total = 0.0;
  var initrating=0.0;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _shop.doc(store.id).collection('ureview').snapshots(includeMetadataChanges: true),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          total = 0;
          var initrating=0.0;
          var cnt = streamSnapshot.data!.docs.length;
          if (streamSnapshot.hasData) {
            for (var element in streamSnapshot.data!.docs) {
              var va = element.data() as Map<String, dynamic>;
              if(element.id==auth.currentUser?.uid){
                initrating=va["rating"] as double;
              }

              var urat = va["rating"] as double;
              total += urat;
            }
          }
          return Column(
            children: [
              TopRoundedContainer(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(store.images[0]),
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
                                store.title,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                              Text("treadly.app"),
                            ],
                          ),
                          Spacer(),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.teal, //<-- SEE HERE
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Follow",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        store.description,
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                        maxLines: 4,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            //color: Colors.grey,
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(20),
                                vertical: getProportionateScreenHeight(3)),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.shade300),
                            child: Row(
                              children: [
                                Text("Groceries"),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.close),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            //color: Colors.grey,
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(20),
                                vertical: getProportionateScreenHeight(5)),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.shade300),
                            child: Row(
                              children: [
                                Text("Groceries"),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.close),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "Total Followers",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            store.tfo.toString(),
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text(
                            "Total Products",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            store.tpo.toString(),
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
             // Text("Rating",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,),),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Rating:",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,),),
                    RatingBar.builder(
                      initialRating: initrating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      //allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        _shop
                            .doc(store.id)
                            .collection('ureview')
                            .doc(auth.currentUser?.uid)
                            .set({"rating": rating});
                        var c = (total/cnt);

                        _shop.doc(store.id).update({"rating":c});
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: SectionTitle(title: "Products", press: pressOnSeeMore!),
              ),
              SizedBox(
                height: 10,
              ),
              ShopProducts(id: store.id),
            ],
          );
        });
  }
}
