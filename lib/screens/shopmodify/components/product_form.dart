import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dokan_koi/components/product_card.dart';
import 'package:dokan_koi/models/Product.dart';

import '../../../size_config.dart';
import '../../home/components/section_title.dart';
import '../../mystore/components/store_header.dart';

class ProductForm extends StatefulWidget {
  static String routeName = "/productform";

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  @override
  final _shop = FirebaseFirestore.instance.collection('shop');
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: _shop.doc(_auth.currentUser?.uid).snapshots(),
          builder: (context, snapshot) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // SizedBox(height: getProportionateScreenHeight(20)),
                    StoreHeader(),
                    SizedBox(height: getProportionateScreenWidth(30)),
                    Column(
                      children: [
                        TextButton(
                            onPressed: (){},
                            child:Container(
                              decoration: BoxDecoration(
                              ),
                                child: Image.asset("assets/images/addphoto.png")
                            ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
