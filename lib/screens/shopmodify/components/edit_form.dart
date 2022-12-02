import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../components/form_error.dart';
import '../../../size_config.dart';




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


  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _subDistrictController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool terms=false;
  FirebaseAuth auth = FirebaseAuth.instance;
  final shop= FirebaseFirestore.instance.collection('shop');
  Position? location;

  void getCurrentLocation() async{
    bool serviceEnabled=await Geolocator.isLocationServiceEnabled();
    if(serviceEnabled)
      {
        LocationPermission permission = await Geolocator.checkPermission();
        if(permission==LocationPermission.denied)
          {
            permission=await Geolocator.requestPermission();
            if(permission==LocationPermission.denied)
              {
                return;
              }
          }
        location=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        Position pos;
        var lastposition = await Geolocator.getLastKnownPosition();

        if(errors.contains("Turn on Location")) {
          removeError(error: "Turn on Location");
        }
        Fluttertoast.showToast(
          msg: " Location acquired ",
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 20,
        );
      }
    else
      {
        addError(error: "Turn on Location");
      }
  }


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
      Fluttertoast.showToast(msg: "Please wait until image is uploaded." ,toastLength: Toast.LENGTH_SHORT);
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
    if(state!.validate() && fileImage!=null && location!=null )
      {
        try {
          print(auth.currentUser?.uid);
          await shop.doc(auth.currentUser?.uid).set({
            "name": _nameController.text,
            "description": _descriptionController.text,
            "phone": _phoneController.text,
            "address": _addressController.text,
            "district": _districtController.text,
            "subDistrict": _subDistrictController.text,
            "type":storeType,
            "rating":1.00,
            "images":"tshirt.png",
            "id":auth.currentUser?.uid,
            "image":image,
            "lat" : location?.latitude,
            "lon": location?.longitude,
            "tpo":0,
            "tfo":0,
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
            SizedBox(
              width: 60,
              child: TextButton(
                  onPressed: getCurrentLocation,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green[600]),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_on,
                        size: 20,
                        color: Colors.white,
                      ),
                      Text("Get Location",style: TextStyle(color: Colors.white, fontSize: 20),),
                    ],
                  ),
              ),
            ),
            Text("For varification purpose, you must provide\nyour current location which will be set\nas your store location.",
              style: TextStyle(
                fontSize: getProportionateScreenHeight(20),
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
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
                  backgroundColor: kPrimaryColor,
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
      controller: _nameController,
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
      controller: _descriptionController,
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
      controller: _addressController,
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
      controller: _subDistrictController,
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
      controller: _districtController,
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
      controller: _phoneController,
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
