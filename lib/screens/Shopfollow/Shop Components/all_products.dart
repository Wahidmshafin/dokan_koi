import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dokan_koi/components/product_card.dart';

import '../../../size_config.dart';
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
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.97),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(20),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                child: Text("Products",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    color: Colors.black,
                  ),
                ),
              ),
              StreamBuilder(
                  stream: _products.where("id",isEqualTo: args.id).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if(streamSnapshot.hasData)
                      {
                        log("Hello WOrld");
                        return Container(
                          height: getProportionateScreenHeight(650),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: streamSnapshot.data!.docs.length,
                            itemBuilder: (context, index) => ProductCard(
                                id: streamSnapshot.data!.docs[index].id,
                                title: streamSnapshot.data!.docs[index]['title'],
                                price: streamSnapshot.data!.docs[index]['price'],
                                qty: streamSnapshot.data!.docs[index]['qty'],
                                image: streamSnapshot.data!.docs[index]['images'])
                            ),
                        );
                      }

                    return const Center(
                        child: CircularProgressIndicator());
                  }
              ),
            ],
          ),
        ),

      ),
    );
  }
}