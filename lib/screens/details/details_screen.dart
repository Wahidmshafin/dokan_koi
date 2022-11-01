import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/Product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";
  final _products = FirebaseFirestore.instance.collection('product');
  @override
  Widget build(BuildContext context) {
    final agrs =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: _products.doc(agrs.id).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          var data = snapshot.data!.data();
          return Scaffold(
            backgroundColor: Color(0xFFF5F6F9),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(AppBar().preferredSize.height),
              child: CustomAppBar(rating: data!['rating']),
            ),
            body: Body(product: Product(id: 1,
                qty: data['qty'],
                images: [data['image']],
                // colors: [
                //   Color(0xFFF6625E),
                //   Color(0xFF836DB8),
                //   Color(0xFFDECB9C),
                //   Colors.white,
                // ],
                title: data['title'],
                price: data['price'].toDouble(),
                description: data['description'])),
          );
        }
        return const Center(
            child: CircularProgressIndicator());
      }
    );
  }
}

class ProductDetailsArguments {
  final String id;

  ProductDetailsArguments({required this.id});
}
