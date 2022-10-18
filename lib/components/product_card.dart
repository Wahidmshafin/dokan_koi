import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dokan_koi/models/Product.dart';
import 'package:dokan_koi/screens/details/details_screen.dart';

import '../constants.dart';
import '../size_config.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,

    required this.product,
  }) : super(key: key);

 // final double width, aspectRetio;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all( getProportionateScreenWidth(15)),
      child:SizedBox(
          width: double.infinity,
          child: GestureDetector(
          onTap: () => Navigator.pushNamed(
      context,
      DetailsScreen.routeName,
      arguments: ProductDetailsArguments(product: product),
    ),
    child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Image.asset(product.images[0],height: 100,width: 100,),
            //Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(product.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),maxLines: 1,overflow: TextOverflow.fade,softWrap: false,),
                Text("Price: \৳${product.price}"),
                Text("Qty: ${product.qty.toString()}"),
              ],
            ),
          ],
        ),

      ),
    ),
      ),
    );
  }
}

