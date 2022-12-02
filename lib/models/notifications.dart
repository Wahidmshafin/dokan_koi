import 'package:flutter/material.dart';

class Notifications{

  Notifications({
    required this.title,
    required this.price,
    required this.qty,
    required this.image,
    required this.uid,
    required this.date,
    required this.time,
    required this.shop,
    required this.msg,
    //required this.product,
  });


  final String image;
  final String title;
  final int price;
  final int qty;
  final String date;
  final String uid;
  final String time,shop,msg;

}