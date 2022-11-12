import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/constants.dart';
import 'package:dokan_koi/models/product.dart';
import 'package:dokan_koi/screens/shopmodify/components/shopeditbody.dart';
import 'package:dokan_koi/screens/shopmodify/components/myorders.dart';
import 'package:dokan_koi/screens/shopmodify/components/myproduct.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:dokan_koi/size_config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../components/form_error.dart';
import '../../../models/Store.dart';
import '../../Shopfollow/Shop Components/all_products.dart';
import '../../Shopfollow/Shop Components/roundedcontainer.dart';
import '../../Shopfollow/Shop Components/shopproduct.dart';
import '../../home/components/section_title.dart';
import '../../mystore/mystore.dart';
import '../shopedit.dart';

class Body extends StatefulWidget {
  Body({
    Key? key,
    required this.store,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Store store;
  final GestureTapCallback? pressOnSeeMore;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final shop = FirebaseFirestore.instance.collection('shop');
  final List<String?> errors = [];
  String storeName = "";
  String storeDescription = "";
  String storeType = 'Grocery';
  String storeAddress = "";
  String storeSubDistrict = "";
  String storeDistrict = "";
  String storePhone = "";

  //
  // String? initname;
  // String? initdes;
  // String? initadd;
  // String? initsub;
  // String? initdis;

  String? image;
  var fileImage;
  FirebaseStorage storage = FirebaseStorage.instance;

  Future getImage() async {
    print("hoi na ken");
    var tmpImage;
    try {
      final tmp = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (tmp == null) {
        return;
      }
      try {
        await storage.ref("shop/${auth.currentUser?.uid}").delete();
        await storage
            .ref("shop/${auth.currentUser?.uid}")
            .putFile(File(tmp.path));
        tmpImage =
            await storage.ref("shop/${auth.currentUser?.uid}").getDownloadURL();
        shop.doc(auth.currentUser?.uid).update({"image": tmpImage});
      } on FirebaseException catch (e) {
        print(e.message);
      }

      setState(() {
        image = tmpImage;
        fileImage = File(tmp.path);
        print(image);
        print("File ${fileImage}");
      });
    } catch (e) {
      print(e);
    }
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    //init();
    return ListView(
      children: [
        TopRoundedContainer(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // CircleAvatar(
                    //   backgroundImage: NetworkImage(
                    //     widget.store.images[0],
                    //   ),
                    //   radius: 60,
                    // ),
                    CachedNetworkImage(
                      imageUrl: widget.store.images[0],
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
                              borderRadius: BorderRadius.circular(40),
                              side: BorderSide(color: Colors.white),
                            ),
                            primary: Colors.white,
                            backgroundColor: Color(0xFFF5F6F9),
                          ),
                          onPressed: getImage,
                          child:
                              SvgPicture.asset("assets/icons/Camera Icon.svg"),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.store.title,
                  style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.8)),
                  maxLines: 4,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        // backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, ShopEdit.routeName);
                        // _update();
                      },
                      child: Text(
                        " Edit Store ",
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, MyOrders.routeName);
                      },
                      child: Text(
                        "My Orders",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 03,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.circular(20)
          ),
          child: TextButton(
            child: Text(
              "Remove Store",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            onPressed: () {},
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
              title: "Products",
              press: () {
                Navigator.pushNamed(context, MyProducts.routeName);
              }),
        ),
        SizedBox(
          height: 10,
        ),
        ShopProducts(id: widget.store.id),
      ],
    );
  }
}
