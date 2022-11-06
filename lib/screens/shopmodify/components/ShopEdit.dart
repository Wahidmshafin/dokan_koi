import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
class shopedit extends StatefulWidget {

  @override
  State<shopedit> createState() => _AddShopState();
}

class _AddShopState extends State<shopedit> {


  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator());
  }




}