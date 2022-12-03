import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../components/notificationcard.dart';
import '../../../constants.dart';
import '../../../models/notifications.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  final _notification = FirebaseFirestore.instance.collection('notification');
  final _shop = FirebaseFirestore.instance.collection('shop');
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? b;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _notification
          .where('user', isEqualTo: auth.currentUser?.uid).orderBy("ord",descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {

          return (streamSnapshot.connectionState == ConnectionState.waiting)
              ? Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                )
              : Center(
                  child: Container(
                  width: getProportionateScreenWidth(350),
                  height: getProportionateScreenHeight(670),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) => SizedBox(
                      width: getProportionateScreenWidth(200),
                      child: NotificationCard(
                        notify: Notifications(
                          title: streamSnapshot.data!.docs[index]['name'],
                          price: streamSnapshot.data!.docs[index]['price'],
                          qty: streamSnapshot.data!.docs[index]['qty'],
                          image: streamSnapshot.data!.docs[index]['images'],
                          uid: streamSnapshot.data!.docs[index]['user'],
                          date: streamSnapshot.data!.docs[index]['date'],
                          time: streamSnapshot.data!.docs[index]['time'],
                          shop: streamSnapshot.data!.docs[index]['shop'],
                          msg: streamSnapshot.data!.docs[index]['msg'],
                        ),
                      ),
                    ),
                  ),
                ));
        }
        return const Center(
            child: CircularProgressIndicator(
          color: kPrimaryColor,
        ));
      },
    );
  }
}
