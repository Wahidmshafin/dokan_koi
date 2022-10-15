import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dokan_koi/models/shops.dart';
import 'package:dokan_koi/screens/Shopfollow/shopscreen.dart';
import 'package:dokan_koi/components/star.dart';
import '../constants.dart';
import '../size_config.dart';

class Newcard extends StatelessWidget {
  const Newcard({
    Key? key,
    this.width = 220,
    this.aspectRetio = 1.02,
    required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            DetailsScreen3.routeName,
            arguments: ProductDetailsArguments3(product: product),
          ),
          child: AspectRatio(
            aspectRatio: 1.02,
            child: Container(
              padding: EdgeInsets.only(top:getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Hero(
                tag: product.id.toString(),
                child: Column(
                  children: [
                    Stack(
                        children: <Widget>[
                          Center(child: Image.asset(product.images[0],height: 100,)),
                          Starrating(rating: product.rating),
                        ]
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight:Radius.circular(15), ),
                      ),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height-678-9.5,
                      child: Column(
                        children: [
                          Spacer(),
                          Text(
                            product.title,
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),
                            maxLines: 2,
                          ),
                          Text(product.address,textAlign: TextAlign.center,maxLines: 1,),
                          Spacer(),
                          // OutlinedButton(
                          //   child: Text('Follow',textAlign: TextAlign.center,),
                          //   style: OutlinedButton.styleFrom(
                          //     foregroundColor: Colors.white, backgroundColor: Colors.teal,
                          //     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          //   ), onPressed: () {  },
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "   890m away",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(14),
                                  //fontWeight: FontWeight.w600,
                                  color: kPrimaryColor,
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(getProportionateScreenWidth(9)),
                                  height: getProportionateScreenWidth(35),
                                  width: getProportionateScreenWidth(35),
                                  decoration: BoxDecoration(
                                    color: product.isFavourite
                                        ? kPrimaryColor.withOpacity(0.15)
                                        : kSecondaryColor.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/icons/Heart Icon_2.svg",
                                    color: product.isFavourite
                                        ? Color(0xFFFF4848)
                                        : Color(0xFFDBDEE4),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
