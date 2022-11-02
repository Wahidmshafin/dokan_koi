import 'package:dokan_koi/constants.dart';
import 'package:dokan_koi/models/product.dart';
import 'package:dokan_koi/screens/shopmodify/components/ShopEdit.dart';
import 'package:dokan_koi/screens/shopmodify/components/myorders.dart';
import 'package:dokan_koi/screens/shopmodify/components/myproduct.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dokan_koi/size_config.dart';

import '../../../models/Store.dart';
import '../../Shopfollow/Shop Components/all_products.dart';
import '../../Shopfollow/Shop Components/roundedcontainer.dart';
import '../../Shopfollow/Shop Components/shopproduct.dart';
import '../../home/components/section_title.dart';
import '../../mystore/mystore.dart';


class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.store,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Store store;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TopRoundedContainer(
          color:  Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage:  AssetImage("assets/images/${store.images[0]}"),
                  backgroundColor: Colors.greenAccent.withOpacity(0.2),
                  radius: 40,
                ),
                SizedBox(height: 30,),
                Text(store.title,style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8)
                ),maxLines: 4,),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                       // backgroundColor: Colors.teal,
                        shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: (){Navigator.pushNamed(context, shopedit.routeName);}, child: Text(" Edit Store ",style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.bold,fontSize: 15),),),
                    SizedBox(width: 20,),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: (){Navigator.pushNamed(context, MyOrders.routeName);}, child: Text("My Orders",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),),
                  ],
                ),
                SizedBox(height: 10,),

              ],
            ),
          ),
        ),
        SizedBox(height: 03,),
        Container(
          decoration: BoxDecoration(color: Colors.white,
             // borderRadius: BorderRadius.circular(20)
             ),
          child: TextButton(
            child: Text("Remove Store",style: TextStyle(color: Colors.grey,fontSize: 18,fontWeight: FontWeight.w600),),
            onPressed: () {  },

          ),
        ),
        SizedBox(height: 20,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Products", press: (){
            Navigator.pushNamed(context, MyProducts.routeName);
          }),
        ),
        SizedBox(height: 10,),
        ShopProducts(id:store.id),
      ],
    );
  }
}