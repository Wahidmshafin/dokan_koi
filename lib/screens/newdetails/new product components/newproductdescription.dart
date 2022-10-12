import 'package:dokan_koi/screens/profile/components/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dokan_koi/models/newproduct.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
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
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              Text(
                product.title,
                style: Theme.of(context).textTheme.headline5,
              ),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                child: Row(
                  children: [
                    Text(
                      "Price: ",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "\৳${product.price}",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Column(
                children: [
                  Container(
                    color: kPrimaryColor,
                    height: 2,
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      CircleAvatar(
                        foregroundImage: AssetImage("assets/images/ps4_console_white_1.png"),
                        minRadius: 30,
                        backgroundColor: Colors.tealAccent,
                      ),
                      SizedBox(width: 10,),
                      Text(product.shopname,
                      style:  TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                        fontWeight: FontWeight.w500,
                        color: kPrimaryColor,
                      ),
                      ),
                      SizedBox(width: 70,),
                      OutlinedButton(
                        child: Text('Follow'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: kPrimaryColor,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        ), onPressed: () {  },
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Container(
                    color: kPrimaryColor,
                    height: 2,
                  ),
                  SizedBox(height: 30,),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            product.description,
            maxLines: 3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  "See More Detail",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
