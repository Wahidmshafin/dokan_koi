import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../Special for you/Specialforyouscreen.dart';
import '../../../size_config.dart';
import 'allcatagory.dart';
import 'section_title.dart';

final _shop = FirebaseFirestore.instance.collection('shop');

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Shop Catagories",
            press: () {
              Navigator.pushNamed(context, AllCatagory.routeName);
            },
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                image: "assets/images/Image Banner 2.png",
                category: "Electronics",
                numOfBrands: 24,
                press: () {},
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
              SpecialOfferCard(
                image: "assets/images/grocery.png",
                category: "Grocery",
                numOfBrands: 24,
                press: () {},
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
              SpecialOfferCard(
                image: "assets/images/bookstore.png",
                category: "BookStore",
                numOfBrands: 24,
                press: () {},
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
              SpecialOfferCard(
                image: "assets/images/medicine.png",
                category: "Medicine",
                numOfBrands: 24,
                press: () {},
              ),

              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _shop.where("type", isEqualTo:category).snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
      return Padding(
        padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Specialcreen.routeName,
                arguments: Storetypeargument(type: 'BookStore'));
          },
          child: SizedBox(
            width: getProportionateScreenWidth(242),
            height: getProportionateScreenWidth(100),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Image.asset(
                    image,
                    width: getProportionateScreenWidth(242),
                    height: getProportionateScreenWidth(100),
                    fit: BoxFit.cover,
                    colorBlendMode: BlendMode.saturation,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF343434).withOpacity(0.4),
                          Color(0xFF343434).withOpacity(0.15),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(15.0),
                      vertical: getProportionateScreenWidth(20),
                    ),
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: "$category\n",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: "${streamSnapshot.data!.docs.length} Shops")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    );
  }
}
