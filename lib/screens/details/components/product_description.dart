import 'package:dokan_koi/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductDescription extends StatelessWidget {
   ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);
  final Product product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: getProportionateScreenWidth(20),right: getProportionateScreenWidth(25)),
          child: Row(
            children: [
              Text(
                product.title,
                style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black)
              ),
              Spacer(),
              Column(
                children: [
                  Text("\৳${product.price}",style: TextStyle(color: kPrimaryColor,fontSize: 20,fontWeight: FontWeight.bold),),
                  Text("${product.qty} Remaining",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: kPrimaryColor),),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 5,),
        Center(
          child: Container(
            height: 1,
            color: kPrimaryColor,
            width: getProportionateScreenWidth(330),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(13),),
    Padding(
    padding:
    EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
    child:  Text("Description:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),),
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
