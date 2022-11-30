import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/constants.dart';
import 'package:dokan_koi/size_config.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../details/details_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static String routeName = "/search";

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Position? position;

  final shop = FirebaseFirestore.instance;

  void getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      print("The position is:  ${position!.longitude}");
    }
  }

  String name = "";

  @override
  Widget build(BuildContext context) {
    getCurrentLocation();

    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          title: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: kPrimaryColor,
                ),
                hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('product')
              .orderBy('id')
              .snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  )
                : ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      var id = snapshots.data!.docs[index].id;
                      var data = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;

                      if (name.isEmpty) {
                        return StreamBuilder<DocumentSnapshot>(
                            stream: shop
                                .collection("shop")
                                .doc(data['id'])
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SizedBox(
                                  height: getProportionateScreenHeight(100),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                );
                              }
                              var result =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              return ListTile(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    DetailsScreen.routeName,
                                    arguments: ProductDetailsArguments(id: id),
                                  );
                                },
                                title: Text(
                                  data['title'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      result["name"],
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Spacer(),
                                    Text(
                                      position == null
                                          ? "..."
                                          : "${Geolocator.distanceBetween(position!.latitude, position!.longitude, result['lat'].toDouble(), result["lon"].toDouble()).floor()}m away",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(data['images']),
                                ),
                              );
                            });
                      }
                      if (data['title']
                          .toString()
                          .toLowerCase()
                          .contains(name.toLowerCase())) {
                        return StreamBuilder<DocumentSnapshot>(
                            stream: shop
                                .collection("shop")
                                .doc(data['id'])
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SizedBox(
                                  height: getProportionateScreenHeight(100),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                );
                              }
                              var result =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              return ListTile(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    DetailsScreen.routeName,
                                    arguments: ProductDetailsArguments(id: id),
                                  );
                                },
                                title: Text(
                                  data['title'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      result["name"],
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Spacer(),
                                    Text(
                                      position == null
                                          ? "..."
                                          : "${Geolocator.distanceBetween(position!.latitude, position!.longitude, result['lat'].toDouble(), result["lon"].toDouble()).floor()}m away",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(data['images']),
                                ),
                              );
                            });
                      }
                      return Container();
                    });
          },
        ));
  }
}
