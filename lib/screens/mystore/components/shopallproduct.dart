import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/components/product_card.dart';
import 'package:dokan_koi/constants.dart';
import 'package:dokan_koi/screens/shopmodify/components/product_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../components/shopproductcard.dart';

class ShopAllProducts extends StatefulWidget {
  static String routeName = "/shopallproduct";

  @override
  State<ShopAllProducts> createState() => _ShopAllProductsState();
}

class _ShopAllProductsState extends State<ShopAllProducts> {
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
            child: CircularProgressIndicator(color: kPrimaryColor,),
          )
              :
          ListView.builder(
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context, index) {
                var id = snapshots.data!.docs[index].id;
                var data = snapshots.data!.docs[index].data()
                as Map<String, dynamic>;

                if (name.isEmpty) {
                  return  Dismissible(
                    key: Key(snapshots.data!.docs[index].id),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) async{
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Remove Product?'),
                          content: const Text('The item will be removed from list of products'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    onDismissed: (direction)
                    {
                      setState(() async{
                        await _products.doc(snapshots.data!.docs[index].id).delete();
                        print("Deleted");
                      });
                    },
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFE6E6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: ShopProductCard(
                        id: snapshots.data!.docs[index].id,
                        title: snapshots.data!.docs[index]['title'],
                        price: snapshots.data!.docs[index]['price'],
                        qty: snapshots.data!.docs[index]['qty'],
                        image: snapshots.data!.docs[index]['images']
                    ),
                  );
                }
                if (data['title']
                    .toString()
                    .toLowerCase()
                    .contains(name.toLowerCase())) {
                  return Dismissible(
                    key: Key(snapshots.data!.docs[index].id),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) async{
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Remove Product?'),
                          content: const Text('The item will be removed from list of products'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    onDismissed: (direction)
                    {
                      setState(() async{
                        await _products.doc(snapshots.data!.docs[index].id).delete();
                        print("Deleted");
                      });
                    },
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFE6E6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: ShopProductCard(
                        id: snapshots.data!.docs[index].id,
                        title: snapshots.data!.docs[index]['title'],
                        price: snapshots.data!.docs[index]['price'],
                        qty: snapshots.data!.docs[index]['qty'],
                        image: snapshots.data!.docs[index]['images']
                    ),
                  );
                }
                return Container();
              });
        },
      ),
    );
  }
}