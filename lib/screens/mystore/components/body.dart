import 'package:dokan_koi/screens/mystore/components/store_header.dart';
import 'package:flutter/material.dart';
import 'package:dokan_koi/components/default_button.dart';
import 'package:dokan_koi/models/Product.dart';
import 'package:dokan_koi/size_config.dart';
import 'listview.dart';


class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
           // SizedBox(height: getProportionateScreenHeight(20)),
            StoreHeader(),
            //SizedBox(height: getProportionateScreenWidth(10)),
            storedescription(),
          ],
        ),
      ),
    );
  }
}
