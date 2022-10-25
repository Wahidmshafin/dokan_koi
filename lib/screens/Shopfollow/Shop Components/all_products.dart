import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dokan_koi/components/product_card.dart';
import 'package:dokan_koi/models/Product.dart';

import '../../../size_config.dart';
import '../../home/components/section_title.dart';

class AllProducts extends StatefulWidget {
  static String routeName = "/allproduct";

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final CollectionReference _products =
  FirebaseFirestore.instance.collection('product');
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  stream: _products.snapshots(),
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
                                title: streamSnapshot.data!.docs[index]['title'],
                                price: streamSnapshot.data!.docs[index]['price'],
                                qty: streamSnapshot.data!.docs[index]['qty'],
                                image: streamSnapshot.data!.docs[index]['image'])
                            ),
                        );
                      }

                    return const Center(
                        child: CircularProgressIndicator());
                  }
              ),


              // ...List.generate(
              //   demoProducts.length,
              //       (index) {
              //       return ProductCard(product: demoProducts[index]);
              //     // return SizedBox.shrink(); // here by default width and height is 0
              //   },
              // ),


            ],
          ),
        ),

      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
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
                  controller: _imageController,
                  decoration: const InputDecoration(labelText: 'Image'),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String title = _titleController.text;
                    final int quantity= int.parse(_quantityController.text);
                    final String image= _imageController.text;
                    final int price =
                    int.parse(_priceController.text);
                    if (price != null) {
                      await _products.add({"title": title, "price": price, "qty":quantity, "image":image});

                      _titleController.text = '';
                      _priceController.text = '';
                      _imageController.text = '';
                      _quantityController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );

        });
  }
}