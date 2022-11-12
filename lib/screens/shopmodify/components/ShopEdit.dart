import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/constants.dart';
import 'package:dokan_koi/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class shopedit extends StatefulWidget {

  @override
  State<shopedit> createState() => _AddShopState();
}

class _AddShopState extends State<shopedit> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _subDistrictController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final shop = FirebaseFirestore.instance.collection('shop');
  Future a = FirebaseFirestore.instance.collection('shop').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) => value.get('type'));
  String dropdownvalue = 'BookStore';

  // List of items in our dropdown menu
  var items = [
    'Grocery',
    'Electronics',
    'BookStore',
    'Medicine',
    'Cloths',
    'Salon',
    'Hardware',
    'Departmental',
    'Tailor'
  ];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: shop.doc(auth.currentUser?.uid).snapshots(),
    builder: (context, snapshot) {

        _nameController.text = snapshot.data!['name'];
        _descriptionController.text =snapshot.data!['description'];
        _addressController.text =snapshot.data!['address'];
        _subDistrictController.text =snapshot.data!['subDistrict'];
        _districtController.text =snapshot.data!['district'];
        _phoneController.text =snapshot.data!['phone'];
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: getProportionateScreenWidth(400),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Store Name",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),),
                       // Spacer(),
                        Flexible(
                          child: TextField(
                            textAlign: TextAlign.left,
                            minLines: 1,
                            maxLines: 2,
                            controller: _nameController,
                            decoration: const InputDecoration(
                              //labelText: 'Name',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(color: kPrimaryColor,
                      thickness: 0.7,
                    ),
                    Row(
                      children: [
                        Text("Mobile Number",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),),
                        Flexible(
                          child: TextField(
                            minLines: 1,
                            maxLines: 2,
                            controller: _phoneController,
                            decoration: const InputDecoration(
                              //labelText: 'Name',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: getProportionateScreenWidth(400),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Address",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),),
                        Flexible(
                          child: TextField(
                            minLines: 1,
                            maxLines: 2,
                            controller: _addressController,
                            decoration: const InputDecoration(
                              //labelText: 'Name',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(color: kPrimaryColor,
                      thickness: 0.9,),
                    Row(
                      children: [
                        Text("Sub-District",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),),
                        Flexible(

                          child: TextField(
                            minLines: 1,
                            maxLines: 2,
                            controller: _subDistrictController,
                            decoration: const InputDecoration(
                              //labelText: 'Name',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(color: kPrimaryColor, thickness: 0.5,),
                    Row(
                      children: [
                        Text("District",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),),
                        Flexible(
                          child: TextField(
                            minLines: 1,
                            maxLines: 2,
                            controller: _districtController,
                            decoration: const InputDecoration(
                              //labelText: 'Name',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: getProportionateScreenWidth(400),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Store Type",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),),
                        Spacer(),
                        DropdownButton(
                          // Initial Value
                          borderRadius: BorderRadius.circular(10),
                          value: dropdownvalue,
                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                    Divider(color: kPrimaryColor, thickness: 0.5,),
                    Text("Description",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),),
                TextField(
                  minLines: 1,
                  maxLines: 5,
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    //labelText: 'Name',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ), Divider(color: kPrimaryColor, thickness: 0.5,),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: () {
                    shop.doc(auth.currentUser?.uid).update({
                      "name": _nameController.text,
                      "description": _descriptionController.text,
                      "phone": _phoneController.text,
                      "address": _addressController.text,
                      "district": _districtController.text,
                      "subDistrict": _subDistrictController.text,
                      "type": dropdownvalue,
                      "rating": 1.00,
                      "images": "tshirt.png",
                      "id": auth.currentUser?.uid,
                    });
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(getProportionateScreenWidth(400),
                        getProportionateScreenHeight(50)),
                    backgroundColor: kPrimaryColor,
                    shape: StadiumBorder(),
                  ),
                  child: Text(
                    "Update Shop",
                    style: TextStyle(fontSize: 20),
                  )),
              SizedBox(height: 50,),
            ],
          ),
        ),
      );
    }
    );
  }
}