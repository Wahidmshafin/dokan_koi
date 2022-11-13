import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/constants.dart';
import 'package:dotted_border/dotted_border.dart';
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
  final TextEditingController _nameController = TextEditingController();

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
                    SizedBox(height: getProportionateScreenWidth(20)),
                    Column(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: DottedBorder(
                            color: Colors.grey,
                            strokeWidth: 1,
                            dashPattern: [5, 4],
                            radius: Radius.circular(20),
                            child: Image.asset(
                              "assets/images/addphoto.png",
                              width: getProportionateScreenWidth(200),
                            ),
                          ),
                        ),
                        inputField()
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Column inputField() {
    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 30),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Product Name",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        TextField(
          textAlign: TextAlign.start,
          minLines: 1,
          maxLines: 2,
          cursorColor: Colors.black,
          style: const TextStyle(
            fontSize: 22,
          ),
          controller: _nameController,
          decoration: const InputDecoration(
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 30),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
        ),
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            child: Divider(
              color: Colors.grey,
              height: 8,
              thickness: 1,
            ))
      ],
    );
  }
}
