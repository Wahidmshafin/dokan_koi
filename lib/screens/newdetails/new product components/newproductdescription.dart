import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/screens/Shopfollow/Shop Components/roundedcontainer.dart';
import 'package:dokan_koi/screens/Shopfollow/Shop Components/shopproduct.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../constants.dart';
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
  Future addToFavourite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("favourite");
    return _collectionRef
        .doc(currentUser!.uid)
        .collection("items")
        .doc(store.id)
        .set({
      "user": store.id,
      "description":store.description,
      "address": store.address,
      "district":store.district,
      "image":store.images[0],
      "name":store.title,
      "id":store.id,
      "subDistrict":store.subDistrict,
      "rating":store.rating,

    }).then((value) => print("Added to favourite"));
  }
  Future removeFromFavourite() async {
    print(store.id);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("favourite");
    return _collectionRef
        .doc(currentUser!.uid)
        .collection("items")
        .doc(store.id).delete();

  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _shop.doc(store.id).collection('ureview').snapshots(includeMetadataChanges: true),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if(streamSnapshot.connectionState == ConnectionState.waiting){
           return Center(child: CircularProgressIndicator(color: kPrimaryColor,),);
          }
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
                  padding: const EdgeInsets.only(left: 40.0, right: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:NetworkImage(
                              store.images[0],
                            ),
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
                              Text("${store.title}.app"),
                            ],
                          ),
                          Spacer(),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance.collection("favourite").doc(FirebaseAuth.instance.currentUser?.uid)
                                .collection("items").where("user",isEqualTo: store.id).snapshots(),
                            builder: (BuildContext context, AsyncSnapshot snapshot){
                              if(snapshot.data==null){
                                return Text("");
                              }
                              return (snapshot.connectionState == ConnectionState.waiting)? Center(child: CircularProgressIndicator(color: kPrimaryColor,),):Padding(
                                padding:  EdgeInsets.all(getProportionateScreenWidth(8)),
                                child: CircleAvatar(
                                  radius: 19.0,
                                  backgroundColor: kPrimaryColor.withOpacity(0.1),
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () => snapshot.data.docs.length==0?addToFavourite():removeFromFavourite(),
                                      icon: snapshot.data.docs.length==0? Icon(
                                        Icons.favorite,
                                        color: kSecondaryColor.withOpacity(0.1),
                                      ):Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },

                          ),
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
                                horizontal: getProportionateScreenWidth(40),
                                vertical: getProportionateScreenHeight(4)),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.shade300),
                            child: Text(store.type,),
                          ),
                          SizedBox(
                            width: 10,
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
