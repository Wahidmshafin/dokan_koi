import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/constants.dart';
import 'package:flutter/material.dart';

import '../../../components/new_card.dart';
import '../../../models/Store.dart';
import '../../../models/productList.dart';
import '../../../size_config.dart';
class Allnewshops extends StatelessWidget {
  static String routeName = "/Allnewshops";
  final _shop = FirebaseFirestore.instance.collection('shop');

  @override
  Widget build(BuildContext context) {
    final ProductList agrs =
    ModalRoute.of(context)!.settings.arguments as ProductList;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Icon(Icons.storefront,color: kPrimaryColor,),
            ),
            Text("Nearest Shops",style: TextStyle(color: Colors.black),
      ),
          ],
        ),
        elevation: 2,
      ),
      body: StreamBuilder(
        stream: _shop.orderBy("distance").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.hasData)
          {
            print("ok");
            return (streamSnapshot.connectionState == ConnectionState.waiting)? Center(child: CircularProgressIndicator(color: kPrimaryColor,),): Center(
              child: Container(
                width: getProportionateScreenWidth(350),
                height: getProportionateScreenHeight(670),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: streamSnapshot.data!.docs.length,

                  itemBuilder: (context,index)=>SizedBox(
                    width: getProportionateScreenWidth(200),
                    child: Newcard(store: agrs.storeList.elementAt(index)
                    ),
                  ),
                ),
              ),
            );
          }
          return const Center(
              child: CircularProgressIndicator(color: kPrimaryColor,));
        },
      ),
    );
  }
}
