import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../size_config.dart';

class ProfilePic extends StatefulWidget {
  ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  String? image;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore cloud = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future getImage() async {
    print("hoi na ken");
    var tmpImage;
    try {
      final tmp = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (tmp == null) {
        return;
      }

      try {
        if (image != null) {
          await storage.ref("profile/${auth.currentUser?.uid}").delete();
        }

        await storage
            .ref("profile/${auth.currentUser?.uid}")
            .putFile(File(tmp.path));
        tmpImage = await storage
            .ref("profile/${auth.currentUser?.uid}")
            .getDownloadURL();
        cloud
            .collection("profile")
            .doc(auth.currentUser?.uid)
            .update({"image": tmpImage});
      } on FirebaseException catch (e) {
        print(e.message);
      }

      setState(() {
        image = tmpImage;
        print(image);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Eta ki abe ase?");
    return StreamBuilder(
        stream:
            cloud.collection("profile").doc(auth.currentUser?.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data?.data()!["image"] != null) {
            print("ekhane ken ase");
            image = snapshot.data?.data()!["image"];
          }
          return SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                image == null
                    ? const CircleAvatar(
                        backgroundImage: AssetImage("assets/images/user.png"),
                      )
                    : CachedNetworkImage(
                        imageUrl: image!,
                        imageBuilder: (context, provider) => CircleAvatar(
                          backgroundImage: provider,
                          radius: 60,
                        ),
                        placeholder: (context, test) => SizedBox(
                            height: getProportionateScreenWidth(90),
                            width: getProportionateScreenWidth(90),
                            child: const CircularProgressIndicator()),
                      ),
                Positioned(
                  right: -16,
                  bottom: 0,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: Colors.white),
                        ),
                        primary: Colors.white,
                        backgroundColor: Color(0xFFF5F6F9),
                      ),
                      onPressed: getImage,
                      child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
