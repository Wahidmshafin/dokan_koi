import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import 'components/shopeditbody.dart';

class ShopEdit extends StatelessWidget {
  static String routeName = "/shopedit";
  FirebaseAuth auth = FirebaseAuth.instance;
  final shop = FirebaseFirestore.instance.collection('shop');
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white.withOpacity(0.97),
      appBar: AppBar(
        title: Row(
          children: [
            Text("Edit My Store"
            ,style: TextStyle(color: Colors.black),),
            Spacer(),
            TextButton(onPressed: (){
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text('You will no be able to recover once deleted'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        shop.doc(auth.currentUser?.uid).delete();
                        Navigator.pushNamed(context, HomeScreen.routeName);
                      },
                      child:  const Text('Delete',style: TextStyle(color: Colors.red),),
                    ),
                  ],
                ),
              );
              },
                child: Text("Delete",style: TextStyle(color: Colors.grey,fontSize: 15),))
          ],
        ),
        centerTitle: true,
        //centerTitle: true,

      ),
      body: shopeditbody(),
      //bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.mystore),
    );
  }
}
