import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../Special for you/Specialforyouscreen.dart';

final _shop = FirebaseFirestore.instance.collection('shop');

class AllCatagory extends StatelessWidget {
  static String routeName = "/AllCatagory";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.97),
        appBar: AppBar(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Icon(
                  Icons.dashboard,
                  color: Colors.green,
                ),
              ),
              Text(
                "Catagories",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          elevation: 2,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                child: Column(
                  children: [
                    Catgorycard(
                      image: "assets/images/Image Banner 2.png",
                      category: "Electronics",
                      press: () {},
                    ),
                    SizedBox(width: getProportionateScreenWidth(20)),
                    Catgorycard(
                      image: "assets/images/grocery.png",
                      category: "Grocery",
                      press: () {},
                    ),
                    SizedBox(width: getProportionateScreenWidth(20)),
                    Catgorycard(
                      image: "assets/images/bookstore.png",
                      category: "BookStore",
                      press: () {},
                    ),
                    SizedBox(width: getProportionateScreenWidth(20)),
                    Catgorycard(
                      image: "assets/images/medicine.png",
                      category: "Medicine",
                      press: () {},
                    ),
                    SizedBox(width: getProportionateScreenWidth(20)),
                    Catgorycard(
                      image: "assets/images/clothes.png",
                      category: "Cloths",
                      press: () {},
                    ),
                    SizedBox(width: getProportionateScreenWidth(20)),
                    Catgorycard(
                      image: "assets/images/salon.png",
                      category: "Salon",
                      press: () {},
                    ),
                    SizedBox(width: getProportionateScreenWidth(20)),
                    Catgorycard(
                      image: "assets/images/hardware.png",
                      category: "Hardware",
                      press: () {},
                    ),
                    SizedBox(width: getProportionateScreenWidth(20)),
                    Catgorycard(
                      image: "assets/images/departmental.png",
                      category: "Departmental",
                      press: () {},
                    ),
                    SizedBox(width: getProportionateScreenWidth(20)),
                    Catgorycard(
                      image: "assets/images/tailor.png",
                      category: "Tailor",
                      press: () {},
                    ),
                    SizedBox(width: getProportionateScreenWidth(20)),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class Catgorycard extends StatelessWidget {
  const Catgorycard({
    Key? key,
    required this.category,
    required this.image,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _shop.where("type", isEqualTo: category).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          return (streamSnapshot.connectionState == ConnectionState.waiting)
              ? Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Specialcreen.routeName,
                          arguments: Storetypeargument(type: category));
                    },
                    child: SizedBox(
                      width: getProportionateScreenWidth(350),
                      height: getProportionateScreenWidth(100),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Image.asset(
                              image,
                              width: getProportionateScreenWidth(350),
                              height: getProportionateScreenWidth(100),
                              fit: BoxFit.cover,
                              colorBlendMode: BlendMode.saturation,
                              opacity: const AlwaysStoppedAnimation(.9),
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
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "$category\n",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(18),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                        text:
                                            "${streamSnapshot.data!.docs.length} Shops")
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
        });
  }
}
