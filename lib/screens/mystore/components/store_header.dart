import 'package:flutter/material.dart';

import '../../../size_config.dart';
import '../../home/components/icon_btn_with_counter.dart';


class StoreHeader extends StatelessWidget {
  const StoreHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getProportionateScreenWidth(12)),
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        //borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Title(color: Colors.red, child: Text('Dokan Koi?',
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),),
                IconBtnWithCounter(

                  svgSrc: "assets/icons/Bell.svg",
                  numOfitem: 3,
                  press: () {},
                ),
              ],
            ),
            //SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
