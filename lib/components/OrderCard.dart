import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key? key,
    required this.title,
    required this.price,
    required this.qty,
    required this.image,
    required this.uid,
    //required this.product,
  }) : super(key: key);

  // final double width, aspectRetio;
  //final Product product;
  final String image;
  final String title;
  final int price;
  final int qty;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Column(children:[Text('Website', style: TextStyle(fontSize: 20.0))]);
   // Column(children:[Text('Tutorial', style: TextStyle(fontSize: 20.0))]),
   // Column(children:[Text('Review', style: TextStyle(fontSize: 20.0))]),
  }
}

