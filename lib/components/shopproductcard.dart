import 'package:cached_network_image/cached_network_image.dart';
import 'package:dokan_koi/screens/details/details_screen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../screens/mystore/product edit.dart';
import '../size_config.dart';

class ShopProductCard extends StatelessWidget {
  const ShopProductCard({
    Key? key,
    required this.title,
    required this.price,
    required this.qty,
    required this.image,
    required this.id,
    //required this.product,
  }) : super(key: key);

  // final double width, aspectRetio;
  //final Product product;
  final String image;
  final String title;
  final int price;
  final int qty;
  final String id;

  @override
  Widget build(BuildContext context) {
    String a;
    if(qty.toInt() == 0){a="Out of Stock";}
    else{a="$qty";}
    return Padding(
      padding: EdgeInsets.all( getProportionateScreenWidth(15)),
      child:SizedBox(
        width: double.infinity,
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            ProductEdit.routeName,
            arguments: ProductDetailsArguments(id: id),
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
                // Image.asset(product.images[0],height: 100,width: 100,),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: CachedNetworkImage(
                    fit: BoxFit.fitWidth,
                    height: getProportionateScreenHeight(100),
                    width: getProportionateScreenWidth(100),
                    imageUrl: image,
                    placeholder: (context, test) => const SizedBox(
                        child: CircularProgressIndicator(color: kPrimaryColor,)),
                  ),
                ),
                //Spacer(),
                SizedBox(width: getProportionateScreenWidth(20),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),maxLines: 1,overflow: TextOverflow.fade,softWrap: false,),
                    Text("Price: \৳${price}"),
                    Row(
                      children: [
                        Text("Qty:"),
                        Text(" $a",style: TextStyle(color: qty.toInt() != 0
                            ? Colors.black.withOpacity(0.6)
                            : Colors.red,),),
                      ],
                    )
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

