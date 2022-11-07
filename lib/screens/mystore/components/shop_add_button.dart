import 'dart:io';

import 'package:dokan_koi/models/Product.dart';
import 'package:dokan_koi/screens/mystore/components/store_header.dart';
import 'package:dokan_koi/screens/shopmodify/components/edit_form.dart';
import 'package:dokan_koi/screens/shopmodify/shopmodify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../home/components/icon_btn_with_counter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';


class AddShop extends StatefulWidget {

  @override
  State<AddShop> createState() => _AddShopState();
}

class _AddShopState extends State<AddShop> {

  @override
  Widget build(BuildContext context) {
    print("ekhane ki bar bar ase?");
    return ElevatedButton(
        onPressed: () {
            Navigator.pushNamed(context, ShopForm.routeName);
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(getProportionateScreenWidth(200),
              getProportionateScreenHeight(50)),
          backgroundColor: kPrimaryColor,
          shape: StadiumBorder(),
        ),
        child: Text("Create Shop",
          style: TextStyle(
              fontSize: 20
          ),
        )
    );
  }





}
