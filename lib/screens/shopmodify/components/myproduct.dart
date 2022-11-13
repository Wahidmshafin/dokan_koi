import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/components/default_button.dart';
import 'package:dokan_koi/constants.dart';
import 'package:dokan_koi/screens/home/components/search_field.dart';
import 'package:dokan_koi/screens/mystore/components/store_header.dart';
import 'package:dokan_koi/screens/shopmodify/components/product_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dokan_koi/components/product_card.dart';
import 'package:dokan_koi/models/Product.dart';

import '../../../size_config.dart';
import '../../home/components/section_title.dart';

class MyProducts extends StatefulWidget {
  static String routeName = "/myproduct";

  @override
  State<MyProducts> createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
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
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.97),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(20),),
              SearchField(),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(20),),
                    StreamBuilder(
                        stream: _products.where("id",isEqualTo: auth.currentUser?.uid).snapshots(),
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
            ],
          ),

        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, ProductForm.routeName);
          },
          backgroundColor: kPrimaryColor,
          child: const Icon(Icons.add),

        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: getProportionateScreenHeight(20),
                left: getProportionateScreenWidth(20),
                right: getProportionateScreenWidth(20),
                bottom: getProportionateScreenHeight(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getProportionateScreenHeight(20)),
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                TextField(
                  controller: _quantityController,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                TextField(
                  controller: _priceController,
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Center(
                  child: DefaultButton(
                    press: (){},
                    text: "Product Image",
                  ),
                ),
                Center(
                  child: TextButton(
                    child: Icon(Icons.add_circle,color: kPrimaryColor,size: 50,),
                    //const Text('Create',style: TextStyle(color: kPrimaryColor,fontSize: 17),),
                    onPressed: () async {
                      final String title = _titleController.text;
                      final String description = _descriptionController.text;
                      final int quantity= int.parse(_quantityController.text);
                      final String image= _imageController.text;
                      final int price =
                      int.parse(_priceController.text);

                      if (price != null) {
                        await _products.add({"title": title, "price": price, "qty":quantity, "image":"glap.png", "id": auth.currentUser?.uid, "description":description, "rating":0.00});

                        _titleController.text = '';
                        _priceController.text = '';
                        _imageController.text = '';
                        _quantityController.text = '';
                        _descriptionController.text = '';
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                )
              ],
            ),
          );

        });
  }
}