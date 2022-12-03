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
                  icon: Icon(Icons.warning_amber,size: 40,),
                  iconColor: Colors.red,
                  title: const Text('Are you sure ?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  content: const Text('You will not be able to recover this shop once deleted',textAlign: TextAlign.center,),
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
                      child: const Text('Delete',style: TextStyle(color: Colors.red),),
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
