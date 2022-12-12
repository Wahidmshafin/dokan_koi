import 'package:dokan_koi/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../models/Store.dart';
import '../../../size_config.dart';
import '../../newdetails/newproductsscreen.dart';

class ProductDescription extends StatelessWidget {
  ProductDescription({
    Key? key,
    required this.product,
    required this.images,
    required this.name,
    required this.type,
    required this.description,
    required this.address,
    required this.rating,
    required this.lat,
    required this.lon,
    required this.title,
    required this.district,
    required this.subDistrict,
    required this.phone,
    this.pressOnSeeMore,
  }) : super(key: key);
  final Product product;
  final GestureTapCallback? pressOnSeeMore;
  final String images,phone,
      name,
      type,
      description,
      address,
      title,
      district,
      subDistrict;

  final double rating, lat, lon;

  @override
  Widget build(BuildContext context) {
    String a;
    if(product.qty.toInt() == 0){a="Out of Stock";}
    else{a="${product.qty} Remaining";}
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(25)),
          child: Row(
            children: [
              Text(product.title,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Spacer(),
              Column(
                children: [
                  Text(
                    "\৳${product.price}",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    a,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.red),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: Container(
            height: 1,
            color: kPrimaryColor,
            width: getProportionateScreenWidth(330),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(7),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            DetailsScreen2.routeName,
            arguments: ProductDetailsArguments2(
              store: Store(
                  id: product.id,
                  description: description,
                  address: address,
                  images: [images],
                  rating: rating,
                  type: type,
                  lat: lat,
                  lon: lon,
                  title: title,
                  district: district,
                  subDistrict: subDistrict, tfo: 0, tpo: 0, phone: phone),
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(left: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(images),
                  backgroundColor: Colors.white,
                  radius: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                    Text(
                      type,
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(7),
        ),
        Center(
          child: Container(
            height: 1,
            color: kPrimaryColor,
            width: getProportionateScreenWidth(330),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(13),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
          child: Text(
            "Product Description:",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: getProportionateScreenHeight(10),
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(20),
          ),
          child: Text(
            product.description,
          ),
        ),
      ],
    );
  }
}
