import 'package:flutter/material.dart';
import 'package:dokan_koi/components/default_button.dart';
import 'package:dokan_koi/models/shops.dart';
import 'package:dokan_koi/size_config.dart';
import 'shopdescription.dart';
import '../Shop Components/roundedcontainer.dart';
import 'shopimage.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product,
                pressOnSeeMore: () {},
              ),
              Column(
                children: [
                  //ColorDots(product: product),
                  TopRoundedContainer(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * 0.15,
                        right: SizeConfig.screenWidth * 0.15,
                        bottom: getProportionateScreenWidth(1000),
                        top: getProportionateScreenWidth(15),
                      ),
                      child: DefaultButton(
                        text: "Follow",
                        press: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
