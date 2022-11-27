import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/constants.dart';
import 'package:dokan_koi/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/profile_pic.dart';

class MyAccount extends StatelessWidget {
  static String routeName = "/myacount";
  FirebaseAuth auth = FirebaseAuth.instance;
  bool a = false;
  final profile = FirebaseFirestore.instance.collection('profile');
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Icon(CupertinoIcons.profile_circled,color: kPrimaryColor,),
            ),
            Text("My Account",style: TextStyle(color: Colors.black),),
            Spacer(),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: profile.doc(auth.currentUser?.uid).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
          {
            Center(child: CircularProgressIndicator(color: kPrimaryColor,),);
          }
          else {
            _fnameController.text = snapshot.data!['fname'];
            _lnameController.text = snapshot.data!['lname'];
            _addressController.text = snapshot.data!['address'];
            _phoneController.text = snapshot.data!['phone'];
            return (snapshot.connectionState == ConnectionState.waiting)
                ? Center(
              child: CircularProgressIndicator(color: kPrimaryColor,),)
                : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: getProportionateScreenHeight(10),),
                    Center(child: ProfilePic()),
                    SizedBox(height: getProportionateScreenHeight(30),),
                    TextField(
                      controller: _fnameController,
                      readOnly: a,
                      decoration: InputDecoration(
                        iconColor: kPrimaryColor,
                        focusColor: kPrimaryColor,
                        labelText: "First Name",
                        labelStyle: TextStyle(
                            color: kPrimaryColor, fontSize: 20),
                        suffixIcon: Icon(Icons.edit, color: kPrimaryColor,),
                        suffixIconColor: kPrimaryColor,
                      ),

                    ),
                    SizedBox(height: getProportionateScreenHeight(30),),
                    TextField(
                      controller: _lnameController,
                      readOnly: a,
                      decoration: InputDecoration(
                        labelText: "Last Name",
                        labelStyle: TextStyle(
                            color: kPrimaryColor, fontSize: 20),
                        suffixIcon: Icon(Icons.edit, color: kPrimaryColor,),
                        suffixIconColor: kPrimaryColor,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(30),),
                    TextField(
                      controller: _addressController,
                      readOnly: a,
                      decoration: InputDecoration(
                        labelText: "Address",
                        labelStyle: TextStyle(
                            color: kPrimaryColor, fontSize: 20),
                        suffixIcon: Icon(Icons.edit, color: kPrimaryColor,),
                        suffixIconColor: Colors.yellowAccent,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(30),),
                    TextField(
                      controller: _phoneController,
                      readOnly: a,

                      decoration: InputDecoration(
                        labelText: "Phone",
                        labelStyle: TextStyle(
                            color: kPrimaryColor, fontSize: 20),
                        suffixIcon: Icon(Icons.edit, color: kPrimaryColor,),
                        suffixIconColor: kPrimaryColor,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(30),),
                    ElevatedButton(onPressed: () {
                      profile.doc(auth.currentUser?.uid).update({
                        "fname": _fnameController.text,
                        "lname": _lnameController.text,
                        "address": _addressController.text,
                        "phone": _phoneController.text
                      });
                      Navigator.pop(context);
                    },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(getProportionateScreenWidth(300),
                            getProportionateScreenHeight(50)),
                        backgroundColor: kPrimaryColor,
                        shape: StadiumBorder(),
                      ),

                      child: Text("Save Changes",
                        style: TextStyle(fontSize: getProportionateScreenHeight(
                            20)),),)

                  ],
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator(color: kPrimaryColor,),);
        }
      ),
    );
  }
}
