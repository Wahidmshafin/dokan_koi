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

  CheckoutCard({Key? key, required this.total,}) : super(key: key);
  FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('cart');
  final CollectionReference _orders =
      FirebaseFirestore.instance.collection('Orders'); 
  final CollectionReference _product =
      FirebaseFirestore.instance.collection('product');

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
                    child: SizedBox(
                      width: double.infinity,
                      height: getProportionateScreenHeight(56),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          primary: Colors.white,
                          backgroundColor: total == 0?Colors.grey:kPrimaryColor,
                        ),
                        onPressed: () {
                          if (total == 0) {
                            return;
                          }
                         // _product.doc(docid).update({"qty":7});
                          _products
                              .where("uid", isEqualTo: auth.currentUser?.uid)
                              .get()
                              .then((value) async {
                            for (var element in value.docs) {
                              int a = await _products.doc(element.id).get().then((value) => value.get('qty'));
                              int b = await _product.doc(element.id).get().then((value) => value.get('qty'));
                              int c = b-a;
                              _orders.add(element.data());
                              _product.doc(element.id).update({"qty":c});
                              _products.doc(element.id).delete();
                            }
                          });
                          Navigator.pushNamed(context, ordsuc.routeName);
                        },
                        child: Text(
                          "Check Out",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
