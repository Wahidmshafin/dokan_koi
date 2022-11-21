import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/components/product_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../details/details_screen.dart';

class AllProducts extends StatefulWidget {
  static String routeName = "/allproduct";

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('product');
  String name = "";
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.97),
      appBar: AppBar(
        elevation: 2,
        title: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: kPrimaryColor,
            ),
            hintText: 'Search...',
          ),
          onChanged: (val) {
            setState(() {
              name = val;
            });
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _products.where("id",isEqualTo: args.id).snapshots(),
        builder: (context, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    var id = snapshots.data!.docs[index].id;
                    var data = snapshots.data!.docs[index].data()
                        as Map<String, dynamic>;

                    if (name.isEmpty) {
                      return ProductCard(
                          id: snapshots.data!.docs[index].id,
                          title: snapshots.data!.docs[index]['title'],
                          price: snapshots.data!.docs[index]['price'],
                          qty: snapshots.data!.docs[index]['qty'],
                          image: snapshots.data!.docs[index]['images']);
                    }
                    if (data['title']
                        .toString()
                        .toLowerCase()
                        .contains(name.toLowerCase())) {
                      return ProductCard(
                          id: snapshots.data!.docs[index].id,
                          title: snapshots.data!.docs[index]['title'],
                          price: snapshots.data!.docs[index]['price'],
                          qty: snapshots.data!.docs[index]['qty'],
                          image: snapshots.data!.docs[index]['images']);
                    }
                    return Container();
                  });
        },
      ),
    );
  }
}
