import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class Body extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              width: double.infinity,
              height: getProportionateScreenHeight(750),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/support.png',
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      iconColor: kPrimaryColor,
                      focusColor: kPrimaryColor,
                      labelText: "E-mail",
                      labelStyle: TextStyle(color: kPrimaryColor, fontSize: 20),
                      suffixIcon: Icon(
                        Icons.edit,
                        color: kPrimaryColor,
                      ),
                      suffixIconColor: kPrimaryColor,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      iconColor: kPrimaryColor,
                      focusColor: kPrimaryColor,
                      labelText: "Phone",
                      labelStyle: TextStyle(color: kPrimaryColor, fontSize: 20),
                      suffixIcon: Icon(
                        Icons.edit,
                        color: kPrimaryColor,
                      ),
                      suffixIconColor: kPrimaryColor,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  TextField(
                    controller: _descriptionController,
                    minLines: 5,
                    maxLines: 5,
                    decoration: InputDecoration(
                      iconColor: kPrimaryColor,
                      focusColor: kPrimaryColor,
                      labelText: "Problem Description",
                      labelStyle: TextStyle(color: kPrimaryColor, fontSize: 20),
                      suffixIcon: Icon(
                        Icons.edit,
                        color: kPrimaryColor,
                      ),
                      suffixIconColor: kPrimaryColor,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _descriptionController.text = " ";
                      _emailController.text = " ";
                      _phoneController.text = " ";

                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(getProportionateScreenWidth(300),
                          getProportionateScreenHeight(50)),
                      backgroundColor: kPrimaryColor,
                      shape: StadiumBorder(),
                    ),
                    child: Text(
                      "Submit",
                      style:
                          TextStyle(fontSize: getProportionateScreenHeight(20)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
