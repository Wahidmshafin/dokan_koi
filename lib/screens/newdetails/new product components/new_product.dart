import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/components/new_card.dart';
import 'package:dokan_koi/models/Store.dart';
import 'package:dokan_koi/screens/newdetails/new%20product%20components/allnewshops.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../constants.dart';
import '../../../models/productList.dart';
import '../../../size_config.dart';
import '../../home/components/section_title.dart';

class NewProducts extends StatelessWidget {
  final _shop = FirebaseFirestore.instance.collection('shop');

  List<Store> storeList = [];

  Position? position;

  void getCurrentLocation() async{
    position=await Geolocator.getLastKnownPosition();
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
        position=await Geolocator.getCurrentPosition();
    }
  }

  @override
  Widget build(BuildContext context) {
    getCurrentLocation();
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
              title: "Nearest Shops",
              press: () {
                Navigator.pushNamed(context, Allnewshops.routeName,arguments: ProductList(storeList: storeList.toSet().toList()));
              }),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        StreamBuilder(
          stream: _shop.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              for(int index = 0;index<streamSnapshot.data!.docs.length;index++){
                int? distance;
                print("What is this ${position}");
                if(position!=null)
                  {
                    distance=Geolocator.distanceBetween(position!.latitude, position!.longitude, streamSnapshot.data!.docs[index]['lat']
                        .toDouble(), streamSnapshot.data!.docs[index]['lon']
                        .toDouble()).floor();
                  }
                storeList.add(
                    Store(
                      id: streamSnapshot.data!.docs[index]['id'],
                      description: streamSnapshot.data!.docs[index]
                      ['description'],
                      address: streamSnapshot.data!.docs[index]
                      ['address'],
                      images: [
                        streamSnapshot.data!.docs[index]['image']
                      ],
                      rating: streamSnapshot.data!.docs[index]['rating']
                          .toDouble(),
                      title: streamSnapshot.data!.docs[index]['name'],
                      district: streamSnapshot.data!.docs[index]
                      ['district'],
                      lat: streamSnapshot.data!.docs[index]['lat']
                          .toDouble(),
                      lon: streamSnapshot.data!.docs[index]['lon']
                          .toDouble(),
                      subDistrict: streamSnapshot.data!.docs[index]
                      ['subDistrict'],
                      type: streamSnapshot.data!.docs[index]['type'],
                      tpo: streamSnapshot.data!.docs[index]['tpo'],
                      tfo: streamSnapshot.data!.docs[index]['tfo'],
                      distance: distance, phone: streamSnapshot.data!.docs[index]['phone'],
                    )
                );
              }
              if(position!=null)
                {
                  storeList.sort((a,b)=>a.distance!.compareTo(b.distance!));
                  for(int i=0;i<storeList.length;i++)
                    {
                      print("The values are ${storeList.elementAt(i).distance}");
                    }
                }
              return (streamSnapshot.connectionState == ConnectionState.waiting)
                  ? Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        width: double.infinity,
                        height: getProportionateScreenHeight(270),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: storeList.length<4?storeList.length:4,
                          itemBuilder: (context, index) => SizedBox(
                            width: getProportionateScreenWidth(300),
                            child: Newcard(
                                store:storeList.toSet().toList().elementAt(index),
                            ),
                          ),
                        ),
                      ),
                    );
            }
            return const Center(
                child: CircularProgressIndicator(
              color: kPrimaryColor,
            ));
          },
        )
      ],
    );
  }
}

// Newcard(store: );
