import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/constants.dart';
import 'package:dokan_koi/screens/mystore/components/shop_add_button.dart';
import 'package:dokan_koi/screens/mystore/components/store_header.dart';
import 'package:dokan_koi/screens/shopmodify/components/edit_form.dart';
import 'package:dokan_koi/screens/shopmodify/shopmodify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dokan_koi/components/default_button.dart';
import 'package:dokan_koi/models/Product.dart';
import 'package:dokan_koi/size_config.dart';
import 'listview.dart';


class Body extends StatelessWidget {

  final _shop = FirebaseFirestore.instance.collection('shop');
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    bool bo=false;
     return StreamBuilder(
       stream: _shop.doc(_auth.currentUser?.uid).snapshots(),
       builder: (context, snapshot) {
         if(snapshot.data?.exists??false) {
           return ShopModify();
         }
         else
           {
             return ShopForm();
           }
       }
     );
  }

}


