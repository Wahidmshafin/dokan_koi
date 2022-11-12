import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dokan_koi/models/newproduct.dart';
import 'package:dokan_koi/screens/newdetails/newproductsscreen.dart';
import 'package:dokan_koi/components/star.dart';

import '../constants.dart';
import '../models/Store.dart';
import '../size_config.dart';

class Newcard extends StatelessWidget {
  const Newcard({
    Key? key,
    this.width = 240,
    this.aspectRetio = 1.02,
    required this.store,
  }) : super(key: key);

  final double width, aspectRetio;
  final Store store;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: width,
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            DetailsScreen2.routeName,
            arguments: ProductDetailsArguments2(store: store),
          ),
          child: AspectRatio(
            aspectRatio: 1.02,
            child: Container(
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Hero(
                tag: store.id.toString(),
                child: Column(
                  children: [
                    Stack(children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          fit: BoxFit.fitWidth,
                          height: getProportionateScreenHeight(120),
                          width: double.infinity,
                          imageUrl: store.images[0],
                          placeholder: (context, test) => SizedBox(
                              height: getProportionateScreenWidth(90),
                              width: getProportionateScreenWidth(90),
                              child: const CircularProgressIndicator()),
                        ),
                      ),
                      Starrating(rating: store.rating),
                    ]),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          children: [
                            Spacer(),
                            Text(
                              store.title,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              maxLines: 2,
                            ),
                            Text(
                              "${store.address}, ${store.subDistrict}",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
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
                                    padding: EdgeInsets.all(
                                        getProportionateScreenWidth(9)),
                                    height: getProportionateScreenWidth(35),
                                    width: getProportionateScreenWidth(35),
                                    decoration: BoxDecoration(
                                      color: store.isFavourite
                                          ? kPrimaryColor.withOpacity(0.15)
                                          : kSecondaryColor.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                      "assets/icons/Heart Icon_2.svg",
                                      color: store.isFavourite
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
