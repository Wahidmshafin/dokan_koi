import 'package:dokan_koi/screens/shopmodify/components/edit_form.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';


class AddShop extends StatefulWidget {

  @override
  State<AddShop> createState() => _AddShopState();
}

class _AddShopState extends State<AddShop> {

  @override
  Widget build(BuildContext context) {
    print("ekhane ki bar bar ase?");
    return ElevatedButton(
        onPressed: () {
            Navigator.pushNamed(context, ShopForm.routeName);
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(getProportionateScreenWidth(200),
              getProportionateScreenHeight(50)),
          backgroundColor: kPrimaryColor,
          shape: StadiumBorder(),
        ),
        child: Text("Create Shop",
          style: TextStyle(
              fontSize: 20
          ),
        )
    );
  }





}
