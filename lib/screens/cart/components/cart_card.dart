import 'package:flutter/material.dart';
import 'package:dokan_koi/models/Cart.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../details/details_screen.dart';

class CartCard extends StatelessWidget {
  const CartCard({
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
    return Padding(
      padding: EdgeInsets.all( getProportionateScreenWidth(15)),
      child:SizedBox(
        width: double.infinity,
        child: GestureDetector(
          onTap: (){}, 
          // => Navigator.pushNamed(
          //   context,
          //   DetailsScreen.routeName,
          //   arguments: ProductDetailsArguments(id: id),
          // ),
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
                Image.asset("assets/images/$image",height: 100,width: 100,),
                //Spacer(),
                SizedBox(width: getProportionateScreenWidth(20),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(product.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),maxLines: 1,overflow: TextOverflow.fade,softWrap: false,),
                    // Text("Price: \৳${product.price}"),
                    // Text("Qty: ${product.qty.toString()}"),
                    Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),maxLines: 1,overflow: TextOverflow.fade,softWrap: false,),
                    Text("Price: \৳${price}"),
                    Text("Qty: ${qty.toString()}"),
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


