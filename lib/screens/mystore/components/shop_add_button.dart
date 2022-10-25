import 'package:dokan_koi/screens/mystore/components/store_header.dart';
import 'package:dokan_koi/screens/shopmodify/shopmodify.dart';
import 'package:flutter/material.dart';
import 'package:dokan_koi/screens/cart/cart_screen.dart';

import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../home/components/icon_btn_with_counter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AddShop extends StatefulWidget {

  @override
  State<AddShop> createState() => _AddShopState();
}

class _AddShopState extends State<AddShop> {

  final List<String?> errors = [];
  String storeName = "";
  String storeDescription="";
  String storeType='Grocery';
  String storeAddress="";
  String storeSubDistrict="";
  String storeDistrict="";
  String storePhone="";

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
    return ElevatedButton(
        onPressed: () {
          _create();
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(getProportionateScreenWidth(200),
              getProportionateScreenHeight(50)),
          backgroundColor: Colors.orange,
          shape: StadiumBorder(),
        ),
        child: Text("Create Shop",
          style: TextStyle(
              fontSize: 20
          ),
        )
    );
  }


  Future<void> _create() async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Form(
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
                      onPressed: (){

                      },
                      child: Column(
                        children: [
                          Image.asset("assets/images/frontStore.jpg"),
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
                  SizedBox(height: getProportionateScreenHeight(20)),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pushNamed(context, ShopModify.routeName)

                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(getProportionateScreenWidth(200),
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
          );
        }
    );
  }


  TextFormField storeNameFormField() {
    return TextFormField(
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        storeName = value;
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
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
      maxLines: 2,
      minLines: 1,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        storeDescription = value;
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
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
      maxLines: 2,
      minLines: 1,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        storeAddress = value;
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
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
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        storeSubDistrict = value;
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
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
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        storeDistrict = value;
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
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
      keyboardType: TextInputType.phone,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        storePhone = value;
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
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
