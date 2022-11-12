import 'dart:io';

import 'package:dokan_koi/models/Product.dart';
import 'package:dokan_koi/screens/mystore/components/store_header.dart';
import 'package:dokan_koi/screens/shopmodify/shopmodify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../home/components/icon_btn_with_counter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';




class ShopForm extends StatefulWidget {

  static String routeName = "/shopmodify";
  
  @override
  State<ShopForm> createState() => _ShopFormState();
}

class _ShopFormState extends State<ShopForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? storeName;
  String? storeDescription;
  String storeType='Grocery';
  String? storeAddress;
  String? storeSubDistrict;
  String? storeDistrict;
  String? storePhone;
  bool terms=false;
  FirebaseAuth auth = FirebaseAuth.instance;
  final shop= FirebaseFirestore.instance.collection('shop');


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
        if(image!=null){
          await storage.ref("shop/${auth.currentUser?.uid}").delete();
        }

        await storage.ref("shop/${auth.currentUser?.uid}").putFile(File(tmp.path));
        tmpImage=await storage.ref("shop/${auth.currentUser?.uid}").getDownloadURL();
        //shop.doc(auth.currentUser?.uid).update({"image":tmpImage});
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

  Future<bool> createShop() async{
    final FormState? state=_formKey.currentState;
    if(state!.validate() && fileImage!=null)
      {
        try {
          print(auth.currentUser?.uid);
          await shop.doc(auth.currentUser?.uid).set({
            "name": storeName,
            "description": storeDescription,
            "phone": storePhone,
            "address": storeAddress,
            "district": storeDistrict,
            "subDistrict": storeSubDistrict,
            "type":storeType,
            "rating":1.00,
            "images":"tshirt.png",
            "id":auth.currentUser?.uid,
            "images":"glap.png",
            "image":image,
          });
        }catch(e)
        {
          addError(error: "Please Fill up all info");
        }
        return true;
      }
    else
      {
        addError(error: "Please Select an Image");
        return false;
      }
  }




  @override
  Widget build(BuildContext context) {
      return Form(
        key: _formKey,
      child: Container(
        // height: getProportionateScreenHeight(600),
        padding: EdgeInsets.only(
            top: 30,
            left: 20,
            right: 20,
            bottom: 20
        ),
        child: ListView(
          children: [
            SizedBox(height: getProportionateScreenHeight(10)),
            TextButton(
              onPressed: getImage,
              child: Column(
                children: [
                  fileImage==null?
                  Image.asset("assets/images/frontStore.jpg"):Image.file(
                    fileImage,
                    height: getProportionateScreenHeight(200),
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  Text("Upload Store Picture",
                    style: TextStyle(
                        color: Colors.black38
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            storeNameFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            storeDescriptionFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            storeTypeFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            storeAddressFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            storeSubDistrictFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            storeDistrictFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            storePhoneFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(40)),
            ElevatedButton(
                onPressed: () async {
                  if(await createShop()){
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(getProportionateScreenWidth(240),
                      getProportionateScreenHeight(50)),
                  backgroundColor: Colors.orange,
                  shape: StadiumBorder(),
                ),
                child: Text("Create Shop",
                  style: TextStyle(
                      fontSize: 20
                  ),
                )
            ),
          ],
        ),
      ),
    );;
  }

  TextFormField storeNameFormField() {
    return TextFormField(
      scrollPadding:EdgeInsets.only(bottom:  MediaQuery.of(context).viewInsets.bottom+10),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Enter Store Name");
        }
        storeName = value;
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Enter Store Name");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Store Name",
        hintText: "Enter your Store name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.storefront),
      ),
    );
  }

  TextFormField storeDescriptionFormField() {
    return TextFormField(
      scrollPadding:EdgeInsets.only(bottom:  MediaQuery.of(context).viewInsets.bottom),
      maxLines: 2,
      minLines: 1,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Enter Description");
        }
        storeDescription = value;
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Enter Description");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Store Description",
        hintText: "This Store is about...",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.info),
      ),
    );
  }


  DropdownButtonFormField<String> storeTypeFormField() {
    return DropdownButtonFormField<String>(
      alignment: Alignment.topLeft,
      hint: Text("Store Type"),
      isExpanded: true,
      value: storeType,
      borderRadius: BorderRadius.circular(20),
      onChanged: (value) {
        setState(() {
          storeType = value!;
        });
      },
      elevation: 4,
      menuMaxHeight: getProportionateScreenHeight(300),
      items: <String>['Grocery', 'Electronics', 'BookStore', 'Medicine', 'Cloths', 'Salon', 'Hardware', 'Departmental', 'Tailor']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      icon: Icon(Icons.arrow_drop_down),
      decoration: InputDecoration(labelText: "Store Type", floatingLabelBehavior: FloatingLabelBehavior.always),
    );
  }


  TextFormField storeAddressFormField() {
    return TextFormField(
      scrollPadding:EdgeInsets.only(bottom:  MediaQuery.of(context).viewInsets.bottom),
      maxLines: 2,
      minLines: 1,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Enter Address properly");
        }
        storeAddress = value;
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Enter Address properly");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter Store address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.map_outlined),
      ),
    );
  }


  TextFormField storeSubDistrictFormField() {
    return TextFormField(
      scrollPadding:EdgeInsets.only(bottom:  MediaQuery.of(context).viewInsets.bottom),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Enter Sub District properly");
        }
        storeSubDistrict = value;
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Enter Sub District properly");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Sub-district",
        hintText: "Enter Sub-district name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.location_city),
      ),
    );
  }



  TextFormField storeDistrictFormField() {
    return TextFormField(
      scrollPadding:EdgeInsets.only(bottom:  MediaQuery.of(context).viewInsets.bottom),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Enter District Properly");
        }
        storeDistrict = value;
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Enter District Properly");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "District",
        hintText: "Enter District name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.location_city),
      ),
    );
  }


  TextFormField storePhoneFormField() {
    return TextFormField(
      scrollPadding:EdgeInsets.only(bottom:  MediaQuery.of(context).viewInsets.bottom),
      keyboardType: TextInputType.phone,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Enter Phone number Properly");
        }
        storePhone = value;
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Enter Phone number Properly");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter Store's Phone Number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.phone),
      ),
    );
  }

}
