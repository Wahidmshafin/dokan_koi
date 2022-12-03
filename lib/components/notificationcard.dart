import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/notifications.dart';
import '../size_config.dart';

class NotificationCard extends StatefulWidget {
  // final double width, aspectRetio;
  //final Product product;
  Notifications notify;
  final _shop = FirebaseFirestore.instance.collection('shop');

  NotificationCard({super.key, required this.notify});

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    String a;
    if (widget.notify.qty.toInt() == 0) {
      a = "Out of Stock";
    } else {
      a = "${widget.notify.qty}";
    }
    return StreamBuilder(
        stream:
            widget._shop.where('id', isEqualTo: widget.notify.shop).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          return (streamSnapshot.connectionState == ConnectionState.waiting)
              ? Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                )
              : Padding(
                  padding:
                      EdgeInsets.only(bottom: getProportionateScreenWidth(5)),
                  child: SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.only(top: 15),
                        width: double.infinity,
                        //height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Column(
                            //   children: [
                            //
                            //     //Spacer(),
                            //     Text(widget.notify.time),
                            //     Text(widget.notify.date),
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.fitWidth,
                                          height:
                                              getProportionateScreenHeight(70),
                                          width:
                                              getProportionateScreenWidth(70),
                                          imageUrl: streamSnapshot.data!.docs[0]
                                              ['image'],
                                          placeholder: (context, test) =>
                                              const SizedBox(
                                                  child:
                                                      CircularProgressIndicator(
                                            color: kPrimaryColor,
                                          )),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        streamSnapshot.data!.docs[0]['name'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //Spacer(),
                                SizedBox(
                                  width: getProportionateScreenWidth(20),
                                ),
                                Flexible(
                                    child: Column(
                                      children: [
                                        Text(
                                  "${widget.notify.msg}",
                                  style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 16,
                                  ),
                                ),
                                        //Spacer(),
                                        Text(widget.notify.time+","+widget.notify.date),
                                        //Text(", "),
                                       // Text(widget.notify.date),
                                      ],
                                    )),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //
                            //   ],
                            // ),

                            Row(
                              children: [
                                Spacer(),
                                ExpandableNotifier(
                                  // <-- Provides ExpandableController to its children
                                  child: Column(
                                    children: [
                                      Expandable(
                                        // <-- Driven by ExpandableController from ExpandableNotifier
                                        collapsed: ExpandableButton(
                                          // <-- Expands when tapped on the cover photo
                                          child: Text(
                                            "Order Details>    ",
                                            textAlign: TextAlign.left,
                                            style:
                                                TextStyle(color: kPrimaryColor),
                                          ),
                                        ),
                                        expanded: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            textDirection: TextDirection.ltr,
                                            children: [
                                          //    Center(child: Text("Order Details")),
                                          Row(
                                            children: [
                                              Text(
                                                "Product Name : ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(widget.notify.title),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Price : ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                  "\৳${widget.notify.price}"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Quantity : ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(widget.notify.qty
                                                  .toString()),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Subtotal : ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                "${widget.notify.qty * widget.notify.price}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          ExpandableButton(
                                            // <-- Collapses when tapped on
                                            child: Text(
                                              "See Less>",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: kPrimaryColor),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        });
  }
}
