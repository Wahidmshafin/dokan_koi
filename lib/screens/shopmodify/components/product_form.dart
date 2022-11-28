import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/components/default_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../components/form_error.dart';
import '../../../size_config.dart';
import '../../mystore/components/store_header.dart';

class ProductForm extends StatefulWidget {
  static String routeName = "/productform";

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  @override
  final _shop = FirebaseFirestore.instance.collection('shop');
  final _product = FirebaseFirestore.instance.collection('product');
  final _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  final List<String?> errors = [];
  String? image;
  var fileImage;
  var tmp;
  FirebaseStorage storage = FirebaseStorage.instance;


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


  Future getImage() async {
    print("hoi na ken");
    try {
      tmp = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (tmp == null) {
        return;
      }

      setState(() {
        fileImage = File(tmp.path);
        print("File ${tmp.name}");
      });
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    Uuid uid = const Uuid();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(height: getProportionateScreenHeight(20)),
              StoreHeader(),
              SizedBox(height: getProportionateScreenWidth(20)),
              Column(
                children: [
                  TextButton(
                    onPressed: getImage,
                    child: fileImage==null?DottedBorder(
                      color: Colors.grey,
                      strokeWidth: 1,
                      dashPattern: [5, 4],
                      radius: Radius.circular(20),
                      child: Image.asset(
                        "assets/images/addphoto.png",
                        width: getProportionateScreenWidth(200),
                      )
                    ):Image.file(fileImage,width: 200,),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  inputField(
                      label: "Product Name",
                      controller: _nameController,
                      inputType: TextInputType.text),
                  inputField(
                      label: "Category Product",
                      controller: _categoryController,
                      inputType: TextInputType.text),
                  Row(
                    children: [
                      SizedBox(
                        child: inputField(
                            label: "Price",
                            controller: _priceController,
                            inputType: TextInputType.number),
                        width: getProportionateScreenWidth(180),
                      ),
                      SizedBox(
                        child: inputField(
                            label: "Quantity",
                            controller: _quantityController,
                            inputType: TextInputType.number),
                        width: getProportionateScreenWidth(180),
                      ),
                    ],
                  ),
                  inputField(
                      label: "Details",
                      controller: _detailsController,
                      inputType: TextInputType.multiline),
                  SizedBox(height: getProportionateScreenHeight(30),),
                  FormError(errors: errors),
                  SizedBox(height: getProportionateScreenHeight(30),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: DefaultButton(
                      text: "Add Product",
                      press: () async {
                        final String title = _nameController.text;
                        final String description = _detailsController.text;
                        final int quantity = int.parse(_quantityController.text);
                        final int price = int.parse(_priceController.text);

                        try{
                          await storage
                              .ref("product/${tmp.name}")
                              .putFile(File(tmp.path));
                          image = await storage.ref("product/${tmp.name}").getDownloadURL();
                          await _product.add({
                            "title": title,
                            "price": price,
                            "qty": quantity,
                            "image": "glap.png",
                            "images":image,
                            "id": _auth.currentUser?.uid,
                            "uid":uid.v1(),
                            "description": description,
                            "rating": 0.00
                          });
                          Navigator.pop(context);
                        }catch(e){
                          if(errors.isNotEmpty){
                            errors.clear();
                          }
                          addError(error: "Please Fill up info properly");
                        }
                      },
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(30),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column inputField(
      {required String label,
      required TextEditingController controller,
      required TextInputType inputType}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              label,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        TextField(
          textAlign: TextAlign.start,
          keyboardType: inputType,
          minLines: 1,
          maxLines: 2,
          cursorColor: Colors.black,
          style: const TextStyle(
            fontSize: 22,
          ),
          controller: controller,
          decoration: const InputDecoration(
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 30),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
        ),
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            child: Divider(
              color: Colors.grey,
              height: 8,
              thickness: 1,
            ))
      ],
    );
  }
}
