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

  Future getImage() async{
    print("hoi na ken");
    var tmpImage;
    try{
      final tmp=await ImagePicker().pickImage(source: ImageSource.gallery);
      if(tmp==null)
      {
        return;
      }
      try{
        await storage.ref("shop/${auth.currentUser?.uid}").delete();
        await storage.ref("shop/${auth.currentUser?.uid}").putFile(File(tmp.path));
        tmpImage=await storage.ref("shop/${auth.currentUser?.uid}").getDownloadURL();
        shop.doc(auth.currentUser?.uid).update({"image":tmpImage});
      }
      on FirebaseException catch(e){
        print(e.message);
      }

      setState(() {
        image=tmpImage;
        fileImage=File(tmp.path);
        print(image);
        print("File ${fileImage}");
      });


    }
    catch(e){
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

  // void init() async {
  //   initname = await shop
  //       .doc(auth.currentUser?.uid)
  //       .get()
  //       .then((value) => value.get('name'));
  //   initdes = await shop
  //       .doc(auth.currentUser?.uid)
  //       .get()
  //       .then((value) => value.get('description'));
  //   initadd = await shop
  //       .doc(auth.currentUser?.uid)
  //       .get()
  //       .then((value) => value.get('address'));
  //   initsub = await shop
  //       .doc(auth.currentUser?.uid)
  //       .get()
  //       .then((value) => value.get('subDistrict'));
  //   initdis = await shop
  //       .doc(auth.currentUser?.uid)
  //       .get()
  //       .then((value) => value.get('district'));
  //   // initphn=await shop.doc(auth.currentUser?.uid).get().then((value) => value.get('phone'));
  // }

  // Future<void> createShop() async {
  //   try {
  //     print(auth.currentUser?.uid);
  //     await shop.doc(auth.currentUser?.uid).update({
  //       "name": storeName,
  //       "description": storeDescription,
  //       "phone": storePhone,
  //       "address": storeAddress,
  //       "district": storeDistrict,
  //       "subDistrict": storeSubDistrict,
  //       "type": storeType,
  //       "rating": 1.00,
  //       "images": "tshirt.png",
  //       "id": auth.currentUser?.uid,
  //     });
  //
  //     print("pressed");
  //   } catch (e) {
  //     addError(error: "Please Fill up all info");
  //   }
  // }

  // Future<void> _update() async {
  //   await showModalBottomSheet(
  //       isScrollControlled: true,
  //       context: context,
  //       builder: (BuildContext ctx) {
  //         return Form(
  //           child: Container(
  //             // height: getProportionateScreenHeight(600),
  //             padding:
  //                 EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
  //             child: ListView(
  //               children: [
  //                 SizedBox(height: getProportionateScreenHeight(10)),
  //                 TextButton(
  //                   onPressed: () {},
  //                   child: Column(
  //                     children: [
  //                       Image.asset("assets/images/frontStore.jpg"),
  //                       Text(
  //                         "Upload Store Picture",
  //                         style: TextStyle(color: Colors.black38),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 SizedBox(height: getProportionateScreenHeight(30)),
  //                 storeNameFormField(),
  //                 SizedBox(height: getProportionateScreenHeight(30)),
  //                 storeDescriptionFormField(),
  //                 SizedBox(height: getProportionateScreenHeight(30)),
  //                 storeTypeFormField(),
  //                 SizedBox(height: getProportionateScreenHeight(30)),
  //                 storeAddressFormField(),
  //                 SizedBox(height: getProportionateScreenHeight(30)),
  //                 storeSubDistrictFormField(),
  //                 SizedBox(height: getProportionateScreenHeight(30)),
  //                 storeDistrictFormField(),
  //                 SizedBox(height: getProportionateScreenHeight(30)),
  //                 storePhoneFormField(),
  //                 SizedBox(height: getProportionateScreenHeight(30)),
  //                 FormError(errors: errors),
  //                 SizedBox(height: getProportionateScreenHeight(20)),
  //                 ElevatedButton(
  //                     onPressed: () {
  //                       createShop();
  //                       Navigator.of(context).pop();
  //                     },
  //                     style: ElevatedButton.styleFrom(
  //                       minimumSize: Size(getProportionateScreenWidth(200),
  //                           getProportionateScreenHeight(50)),
  //                       backgroundColor: kPrimaryColor,
  //                       shape: StadiumBorder(),
  //                     ),
  //                     child: Text(
  //                       "Update Shop",
  //                       style: TextStyle(fontSize: 20),
  //                     )),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

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
                    CachedNetworkImage(imageUrl: widget.store.images[0],
                      imageBuilder: (context, provider)=>CircleAvatar(
                        backgroundImage: provider,
                        radius: 60,
                      ),
                      placeholder: (context, test)=>SizedBox(
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
                          child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
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

  // TextFormField storeNameFormField() {
  //   return TextFormField(
  //     initialValue: initname ?? "",
  //     //  print(name);
  //     onChanged: (value) {
  //       if (value.isNotEmpty) {
  //         removeError(error: kNamelNullError);
  //       }
  //       storeName = value;
  //       return;
  //     },
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         addError(error: kNamelNullError);
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       labelText: "Store Name",
  //       hintText: "Enter your Store name",
  //       // If  you are using latest version of flutter then lable text and hint text shown like this
  //       // if you r using flutter less then 1.20.* then maybe this is not working properly
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       suffixIcon: Icon(Icons.storefront),
  //     ),
  //   );
  // }
  //
  // TextFormField storeDescriptionFormField() {
  //   return TextFormField(
  //     initialValue: initdes ?? "",
  //     maxLines: 2,
  //     minLines: 1,
  //     onChanged: (value) {
  //       if (value.isNotEmpty) {
  //         removeError(error: kNamelNullError);
  //       }
  //       storeDescription = value;
  //       return;
  //     },
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         addError(error: kNamelNullError);
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       labelText: "Store Description",
  //       hintText: "This Store is about...",
  //       // If  you are using latest version of flutter then lable text and hint text shown like this
  //       // if you r using flutter less then 1.20.* then maybe this is not working properly
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       suffixIcon: Icon(Icons.info),
  //     ),
  //   );
  // }
  //
  // DropdownButtonFormField<String> storeTypeFormField() {
  //   return DropdownButtonFormField<String>(
  //     alignment: Alignment.topLeft,
  //     hint: Text("Store Type"),
  //     isExpanded: true,
  //     value: storeType,
  //     borderRadius: BorderRadius.circular(20),
  //     onChanged: (value) {
  //       setState(() {
  //         storeType = value!;
  //       });
  //     },
  //     elevation: 4,
  //     menuMaxHeight: getProportionateScreenHeight(300),
  //     items: <String>[
  //       'Grocery',
  //       'Electronics',
  //       'BookStore',
  //       'Medicine',
  //       'Cloths',
  //       'Salon',
  //       'Hardware',
  //       'Departmental',
  //       'Tailor'
  //     ].map<DropdownMenuItem<String>>((String value) {
  //       return DropdownMenuItem<String>(
  //         value: value,
  //         child: Text(value),
  //       );
  //     }).toList(),
  //     icon: Icon(Icons.arrow_drop_down),
  //     decoration: InputDecoration(
  //         labelText: "Store Type",
  //         floatingLabelBehavior: FloatingLabelBehavior.always),
  //   );
  // }
  //
  // TextFormField storeAddressFormField() {
  //   return TextFormField(
  //     initialValue: initadd ?? "",
  //     maxLines: 2,
  //     minLines: 1,
  //     onChanged: (value) {
  //       if (value.isNotEmpty) {
  //         removeError(error: kNamelNullError);
  //       }
  //       storeAddress = value;
  //       return;
  //     },
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         addError(error: kNamelNullError);
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       labelText: "Address",
  //       hintText: "Enter Store address",
  //       // If  you are using latest version of flutter then lable text and hint text shown like this
  //       // if you r using flutter less then 1.20.* then maybe this is not working properly
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       suffixIcon: Icon(Icons.map_outlined),
  //     ),
  //   );
  // }
  //
  // TextFormField storeSubDistrictFormField() {
  //   return TextFormField(
  //     initialValue: initsub ?? "",
  //     onChanged: (value) {
  //       if (value.isNotEmpty) {
  //         removeError(error: kNamelNullError);
  //       }
  //       storeSubDistrict = value;
  //       return;
  //     },
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         addError(error: kNamelNullError);
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       labelText: "Sub-district",
  //       hintText: "Enter Sub-district name",
  //       // If  you are using latest version of flutter then lable text and hint text shown like this
  //       // if you r using flutter less then 1.20.* then maybe this is not working properly
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       suffixIcon: Icon(Icons.location_city),
  //     ),
  //   );
  // }
  //
  // TextFormField storeDistrictFormField() {
  //   return TextFormField(
  //     initialValue: initdis ?? "",
  //     onChanged: (value) {
  //       if (value.isNotEmpty) {
  //         removeError(error: kNamelNullError);
  //       }
  //       storeDistrict = value;
  //       return;
  //     },
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         addError(error: kNamelNullError);
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       labelText: "District",
  //       hintText: "Enter District name",
  //       // If  you are using latest version of flutter then lable text and hint text shown like this
  //       // if you r using flutter less then 1.20.* then maybe this is not working properly
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       suffixIcon: Icon(Icons.location_city),
  //     ),
  //   );
  // }
  //
  // TextFormField storePhoneFormField() {
  //   return TextFormField(
  //     keyboardType: TextInputType.phone,
  //     onChanged: (value) {
  //       if (value.isNotEmpty) {
  //         removeError(error: kNamelNullError);
  //       }
  //       storePhone = value;
  //       return;
  //     },
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         addError(error: kNamelNullError);
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       labelText: "Phone Number",
  //       hintText: "Enter Store's Phone Number",
  //       // If  you are using latest version of flutter then lable text and hint text shown like this
  //       // if you r using flutter less then 1.20.* then maybe this is not working properly
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       suffixIcon: Icon(Icons.phone),
  //     ),
  //   );
  }

