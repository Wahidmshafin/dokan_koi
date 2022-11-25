import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/components/star.dart';
import 'package:dokan_koi/screens/newdetails/newproductsscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/Store.dart';
import '../size_config.dart';

class Favcard extends StatelessWidget {
  const Favcard({
    Key? key,
    this.width = 240,
    this.aspectRetio = 1.02,
    required this.store,
  }) : super(key: key);

  final double width, aspectRetio;
  final Store store;

  Future addToFavourite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    String s=store.images[0];
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: width,
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            DetailsScreen2.routeName,
            arguments: ProductDetailsArguments2(store: store),
          ),
          child: AspectRatio(
            aspectRatio: 1.2,
            child: Container(
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Hero(
                tag: store.id.toString(),
                child: Column(
                  children: [
                    Stack(children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          fit: BoxFit.fitWidth,
                          height: getProportionateScreenHeight(120),
                          width: double.infinity,
                          imageUrl: store.images[0],
                          placeholder: (context, test) => const SizedBox(
                              child: LinearProgressIndicator()),
                        ),
                      ),
                      Starrating(rating: store.rating),
                    ]),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          children: [
                            Spacer(),
                            Text(
                              store.title,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              maxLines: 2,
                            ),
                            Text(
                              "${store.address}, ${store.subDistrict}",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "   890m away",
                                  style: TextStyle(
                                    fontSize: getProportionateScreenWidth(14),
                                    //fontWeight: FontWeight.w600,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance.collection("favourite").doc(FirebaseAuth.instance.currentUser?.uid)
                                      .collection("items").where("user",isEqualTo: store.id).snapshots(),
                                  builder: (BuildContext context, AsyncSnapshot snapshot){
                                    if(snapshot.data==null){
                                      return Text("");
                                    }
                                    return (snapshot.connectionState == ConnectionState.waiting)? Center(child: CircularProgressIndicator(color: kPrimaryColor,),): Padding(
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
