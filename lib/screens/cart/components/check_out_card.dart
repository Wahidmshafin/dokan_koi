import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/components/default_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../Cart Splash/splash.dart';

class CheckoutCard extends StatelessWidget {

  int total;
  CheckoutCard({
    Key? key,
    required this.total
  }) : super(key: key);
  FirebaseAuth  auth = FirebaseAuth.instance;
  final CollectionReference _products =
  FirebaseFirestore.instance.collection('cart');
  final CollectionReference _orders =
  FirebaseFirestore.instance.collection('Orders');
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
                Text("Add voucher code"),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kTextColor,
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: "\$$total",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text:"Check Out",
                    press: () {
                      // _products.where("uid",isEqualTo: auth.currentUser?.uid).snapshots().forEach((element) {
                      //     element.docs.asMap().forEach((key, value) {
                      //       print("eta ken print hoi");
                      //       _orders.add(value.data());
                      //       _products.doc(value.id).delete();
                      //     });
                      // });
                      _products.where("uid",isEqualTo: auth.currentUser?.uid).get().then((value) => {
                        value.docs.forEach((element) {
                          print("eta ken hoi?");
                          _orders.add(element.data());
                          _products.doc(element.id).delete();
                        })
                      });
                      Navigator.pushNamed(context, ordsuc.routeName);

                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}