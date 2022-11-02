import 'package:dokan_koi/screens/profile/components/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dokan_koi/models/newproduct.dart';
import 'package:dokan_koi/screens/Shopfollow/Shop Components/roundedcontainer.dart';
import '../../../models/Store.dart';
import '../../home/components/section_title.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:dokan_koi/screens/Shopfollow/Shop Components/shopproduct.dart';
class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.store,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Store store;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopRoundedContainer(
          color:  Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:  AssetImage(store.images[0]),
                      backgroundColor: Colors.white,
                      radius: 30,
                    ),
                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(store.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green),),
                        Text("treadly.app"),
                      ],
                    ),
                    Spacer(),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.teal, //<-- SEE HERE
                        shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: (){}, child: Text("Follow",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),)
                  ],
                ),
                SizedBox(height: 30,),
                Text(store.description,style: TextStyle(fontSize: 15,color: Colors.grey
                ),maxLines: 4,),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      //color: Colors.grey,
                      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20),vertical: getProportionateScreenHeight(3)),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade300),
                      child: Row(
                        children: [
                          Text("Groceries"),
                          SizedBox(width: 5,),
                          Icon(Icons.close),
                        ],
                      ),

                    ),
                    SizedBox(width: 10,),
                    Container(
                      //color: Colors.grey,
                      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20),vertical: getProportionateScreenHeight(5)),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade300),
                      child: Row(
                        children: [
                          Text("Groceries"),
                          SizedBox(width: 5,),
                          Icon(Icons.close),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),


              ],
            ),
          ),
        ),
        SizedBox(height: 20,),
        Container(
          decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              children: [
                Column(
                  children: [
                    Text("Total Followers",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                    Text(store.tfo.toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Text("Total Products",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                    Text(store.tpo.toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
        SizedBox(height: 20,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Products", press: pressOnSeeMore!),
        ),
        SizedBox(height: 10,),
        ShopProducts(),
      ],
    );
  }
}
