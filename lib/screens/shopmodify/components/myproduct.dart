import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/components/product_card.dart';
import 'package:dokan_koi/constants.dart';
import 'package:dokan_koi/screens/shopmodify/components/product_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProducts extends StatefulWidget {
  static String routeName = "/myproduct";

  @override
  State<MyProducts> createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference _products =
  FirebaseFirestore.instance.collection('product');
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.97),
      appBar: AppBar(
        elevation: 2,
        title: TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              prefixIcon: Icon(Icons.search,color: kPrimaryColor,),
              hintText: 'Search...',
              suffixIcon: IconButton(
          icon: const Icon(Icons.add_circle,color: kPrimaryColor,size: 35,),
          onPressed: () {
            Navigator.pushNamed(context, ProductForm.routeName);
          },
        ),
          ),
          onChanged: (val) {
            setState(() {
              name = val;
            });
          },
        ),
      ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _products.where("id",isEqualTo: auth.currentUser?.uid).snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? Center(
              child: CircularProgressIndicator(),
            )
                :
            ListView.builder(
                itemCount: snapshots.data!.docs.length,
                itemBuilder: (context, index) {
                  var id = snapshots.data!.docs[index].id;
                  var data = snapshots.data!.docs[index].data()
                  as Map<String, dynamic>;

                  if (name.isEmpty) {
                    return  ProductCard(
                              id: snapshots.data!.docs[index].id,
                              title: snapshots.data!.docs[index]['title'],
                              price: snapshots.data!.docs[index]['price'],
                              qty: snapshots.data!.docs[index]['qty'],
                              image: snapshots.data!.docs[index]['images']
                    );
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
                        image: snapshots.data!.docs[index]['images']
                    );
                  }
                  return Container();
                });
          },
        ),
    );
  }
}