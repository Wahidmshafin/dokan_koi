import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/components/star.dart';
import 'package:dokan_koi/screens/newdetails/newproductsscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../constants.dart';
import '../models/Store.dart';
import '../size_config.dart';

class Newcard extends StatefulWidget {
   Newcard({
    Key? key,
    this.width = double.infinity,
    this.aspectRetio = 1.1,
    required this.store,
  }) : super(key: key);

  final double width, aspectRetio;
  final Store store;


  @override
  State<Newcard> createState() => _NewcardState();
}

class _NewcardState extends State<Newcard> {
  Future addToFavourite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("favourite");
    return _collectionRef
        .doc(currentUser!.uid)
        .collection("items")
        .doc(widget.store.id)
        .set({
      "user": widget.store.id,
      "description":widget.store.description,
      "address": widget.store.address,
      "district":widget.store.district,
      "image":widget.store.images[0],
      "name":widget.store.title,
      "type":widget.store.type,
      "id":widget.store.id,
      "lat":widget.store.lat,
      "lon":widget.store.lon,
      "subDistrict":widget.store.subDistrict,
      "rating":widget.store.rating,

    }).then((value) => print("Added to favourite"));
  }

  Future removeFromFavourite() async {
    print(widget.store.id);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("favourite");
    return _collectionRef
        .doc(currentUser!.uid)
        .collection("items")
        .doc(widget.store.id).delete();

  }

  final locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.best,
    distanceFilter: 0,
  );

    // final locationSettings = AndroidSettings(
    //   forceLocationManager: true,
    //   accuracy: LocationAccuracy.bestForNavigation,
    //   distanceFilter: 1,
    //
    // );

  void getCurrentLocation() async{
    bool serviceEnabled=await Geolocator.isLocationServiceEnabled();
    if(serviceEnabled)
    {
      LocationPermission permission = await Geolocator.checkPermission();
      if(permission==LocationPermission.denied)
      {
        permission=await Geolocator.requestPermission();
        if(permission==LocationPermission.denied)
        {
          return;
        }
      }
    }
  }


  Position? position;

  @override
  Widget build(BuildContext context) {
    //getCurssssrentLocation();
    // StreamSubscription<Position> positionStream =Geolocator.getPositionStream(locationSettings: locationSettings).listen((event) {
    //   setState(() {
    //     position = event;
    //   });
    // });
    return StreamBuilder<Position>(
      stream: Geolocator.getPositionStream(locationSettings: locationSettings),
      builder: (context, snapshot) {
        return Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(10)),
          child: SizedBox(
            width: widget.width,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                DetailsScreen2.routeName,
                arguments: ProductDetailsArguments2(store: widget.store),
              ),
              child: AspectRatio(
                aspectRatio: 1.2,
                child: Container(
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: widget.store.id.toString(),
                    child: Column(
                      children: [
                        Stack(children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              fit: BoxFit.fitWidth,
                              height: getProportionateScreenHeight(110),
                              width: double.infinity,
                              imageUrl: widget.store.images[0],
                              placeholder: (context, test) => const SizedBox(
                                  child: LinearProgressIndicator()),
                            ),
                          ),
                          Starrating(rating: widget.store.rating),
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
                                  widget.store.title,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  maxLines: 2,
                                ),
                                Text(
                                  "${widget.store.address}, ${widget.store.subDistrict}",
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snapshot.data!=null? " ${Geolocator.distanceBetween(snapshot.data!.latitude, snapshot.data!.longitude, widget.store.lat, widget.store.lon).floor()}m away":"...",
                                      style: TextStyle(
                                        fontSize: getProportionateScreenWidth(14),
                                        //fontWeight: FontWeight.w600,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                      StreamBuilder(
                                        stream: FirebaseFirestore.instance.collection("favourite").doc(FirebaseAuth.instance.currentUser?.uid)
                                            .collection("items").where("user",isEqualTo: widget.store.id).snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot snapshot){
                                          if(snapshot.data==null){
                                            return Text("");
                                          }
                                          return Padding(
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
    );
  }
}
