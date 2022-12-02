import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/screens/shopmodify/components/print.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class MyOrders extends StatelessWidget {
  static String routeName = "/myorders";
  FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('Orders');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.97),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Text(
                    "My Shop Order List",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  height: getProportionateScreenHeight(630),
                  width: getProportionateScreenWidth(907),
                  child: Column(
                    children: [
                      Table(
                        defaultColumnWidth: FixedColumnWidth(155.7),
                        border: TableBorder.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 2),
                        children: [
                          TableRow(children: [
                            Column(children: [
                              Text("User", style: TextStyle(fontSize: 20.0)),
                            ]),
                            Column(children: [
                              Text("Product", style: TextStyle(fontSize: 20.0)),
                            ]),
                            Column(children: [
                              Text("Quantity",
                                  style: TextStyle(fontSize: 20.0)),
                            ]),
                            Column(children: [
                              Text("Price", style: TextStyle(fontSize: 20.0)),
                            ]),
                            Column(children: [
                              Text("Accept Order",
                                  style: TextStyle(fontSize: 20.0)),
                            ]),
                            Column(children: [
                              Text("Reject Order",
                                  style: TextStyle(fontSize: 20.0)),
                            ]),
                          ]),
                        ],
                      ),
                      StreamBuilder(
                          stream: _products
                              .where("sid", isEqualTo: auth.currentUser?.uid)
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                            if (streamSnapshot.hasData) {
                              return (streamSnapshot.connectionState ==
                                      ConnectionState.waiting)
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: kPrimaryColor,
                                      ),
                                    )
                                  : Container(
                                      height: getProportionateScreenHeight(550),
                                      color: Colors.white,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            streamSnapshot.data!.docs.length,
                                        itemBuilder: (context, index) => Table(
                                          defaultColumnWidth:
                                              FixedColumnWidth(120.0),
                                          border: TableBorder.all(
                                              color: Colors.black,
                                              style: BorderStyle.solid,
                                              width: 2),
                                          children: [
                                            TableRow(children: [
                                              Column(children: [
                                                Text(
                                                    streamSnapshot.data!
                                                        .docs[index]['user'],
                                                    style: TextStyle(
                                                        fontSize: 20.0))
                                              ]),
                                              Column(children: [
                                                Text(
                                                    streamSnapshot.data!
                                                        .docs[index]['title'],
                                                    style: TextStyle(
                                                        fontSize: 20.0))
                                              ]),
                                              Column(children: [
                                                Text(
                                                    streamSnapshot.data!
                                                        .docs[index]['qty']
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 20.0))
                                              ]),
                                              Column(children: [
                                                Text(
                                                    (streamSnapshot.data!
                                                                    .docs[index]
                                                                ['price'] *
                                                            streamSnapshot.data!
                                                                    .docs[index]
                                                                ['qty'])
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 20.0))
                                              ]),
                                              Column(children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      _products
                                                          .doc(streamSnapshot
                                                              .data!
                                                              .docs[index]
                                                              .id)
                                                          .delete();
                                                      Fluttertoast.showToast(
                                                        msg: " Order Accepted ",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        fontSize: 20,
                                                      );
                                                    },
                                                    child: Icon(
                                                      Icons.check_circle,
                                                      color: kPrimaryColor,
                                                    )),
                                              ]),
                                              Column(children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      _products
                                                          .doc(streamSnapshot
                                                              .data!
                                                              .docs[index]
                                                              .id)
                                                          .delete();
                                                      Fluttertoast.showToast(
                                                        msg: "Order Rejected",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        fontSize: 20,
                                                      );
                                                    },
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    )),
                                              ]),
                                            ]),
                                          ],
                                        ),
                                      ),
                                    );
                            }
                            return const Center(
                                child: CircularProgressIndicator(
                              color: kPrimaryColor,
                            ));
                          }),
                    ],
                  ),
                ),
                Center(
                    child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Background color
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Print.routeName);
                  },
                  child: Text("Print"),
                ))
              ],
            ),
          ),
        ));
  }
}
