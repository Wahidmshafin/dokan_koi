import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/constants.dart';
import 'package:dokan_koi/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

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
  final product = FirebaseFirestore.instance.collection("product");
  Future a = FirebaseFirestore.instance
      .collection('shop')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .get()
      .then((value) => value.get('type'));
  String dropdownvalue = "a";

  Position? location;
  double lat = 0, lon = 0;

  void getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }
      location = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      Position pos;
      var lastposition = await Geolocator.getLastKnownPosition();

      Fluttertoast.showToast(
        msg: " Location acquired ",
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 20,
      );
    } else {
      Fluttertoast.showToast(
          msg: "Turn on Location",
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 20);
    }
  }

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
          if (snapshot.connectionState == ConnectionState.waiting) {
            Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            );
          } else {
            if (dropdownvalue == "a") {
              dropdownvalue = snapshot.data!['type'];
            }
            _nameController.text = snapshot.data!['name'];
            _descriptionController.text = snapshot.data!['description'];
            _addressController.text = snapshot.data!['address'];
            _subDistrictController.text = snapshot.data!['subDistrict'];
            _districtController.text = snapshot.data!['district'];
            _phoneController.text = snapshot.data!['phone'];
            lat = snapshot.data!['lat'];
            lon = snapshot.data!['lon'];
            return (snapshot.connectionState == ConnectionState.waiting)
                ? Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  )
                : SingleChildScrollView(
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
                                color: Colors.white),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Store Name",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      width: getProportionateScreenWidth(200),
                                      child: TextField(
                                        textAlign: TextAlign.end,
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
                                Container(
                                  height: 1,
                                  color: kPrimaryColor,
                                  width: getProportionateScreenWidth(330),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Mobile Number",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      width: getProportionateScreenWidth(200),
                                      child: TextField(
                                        textAlign: TextAlign.end,
                                        minLines: 1,
                                        maxLines: 2,
                                        controller: _phoneController,
                                        keyboardType: TextInputType.number,
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
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            width: getProportionateScreenWidth(400),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Address",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      width: getProportionateScreenWidth(200),
                                      child: TextField(
                                        textAlign: TextAlign.end,
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
                                Container(
                                  height: 1,
                                  color: kPrimaryColor,
                                  width: getProportionateScreenWidth(330),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Sub-District",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      width: getProportionateScreenWidth(200),
                                      child: TextField(
                                        textAlign: TextAlign.end,
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
                                Container(
                                  height: 1,
                                  color: kPrimaryColor,
                                  width: getProportionateScreenWidth(330),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "District",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      width: getProportionateScreenWidth(200),
                                      child: TextField(
                                        textAlign: TextAlign.end,
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
                                SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                    onPressed: getCurrentLocation,
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.green[600]),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Get Location",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Text(
                                  "For varification purpose, you must provide\nyour current location which will be set\nas your store location.",
                                  style: TextStyle(
                                    fontSize: getProportionateScreenHeight(16),
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(10)),
                            width: getProportionateScreenWidth(400),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Store Type",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      width: getProportionateScreenWidth(140),
                                      child: DropdownButton(
                                        // Initial Value
                                        borderRadius: BorderRadius.circular(10),
                                        value: dropdownvalue,
                                        // Down Arrow Icon
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),

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
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 1,
                                  color: kPrimaryColor,
                                  width: getProportionateScreenWidth(330),
                                ),
                                Text(
                                  "Description",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
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
                                ),
                                Container(
                                  height: 1,
                                  color: kPrimaryColor,
                                  width: getProportionateScreenWidth(330),
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
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
                                  "lat": location == null
                                      ? lat
                                      : location!.latitude,
                                  "lon": location == null
                                      ? lon
                                      : location!.longitude,
                                  "id": auth.currentUser?.uid,
                                });
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    getProportionateScreenWidth(300),
                                    getProportionateScreenHeight(50)),
                                backgroundColor: kPrimaryColor,
                                shape: StadiumBorder(),
                              ),
                              child: Text(
                                "Update Shop",
                                style: TextStyle(fontSize: 20),
                              )),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  );
          }
          return Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        });
  }
}
