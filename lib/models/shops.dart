import 'package:flutter/material.dart';

class Product {
  final int id,tfo,tpo;
  final String title, location,time,address,description;
  final List<String> images;
  final double rating;
  final bool isFavourite, isPopular;

  Product({
    required this.description,
    required this.id,
    required this.address,
    required this.images,
    required this.time,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.location,
    required this.tfo,
    required this.tpo,
  });
}

// Our demo Products

List<Product> demoProducts = [
  Product(
    description: "shbfjksahfdjkdashfjkh ufshgisahdio; uidfhkiashiodsj uifsahyoisah uisdhfisahf uisahdfiosa sadihfioas sihfioash asyfhoiash sdyioas ufioasugouiohfiosadhoisfdh uisdhfoiusaud uhfsdu iuhsdus ,yui isahfisfkjskkjfk",
    address: "146a Thakurpara Road, Comilla  fhkashdkjfshadklhglsshfs",
    id: 1,
    tfo: 213,
    tpo: 321,
    images: [
      "assets/images/ps4_console_white_1.png",
    ],
    time: "09:00-19:30",
    title: "Shafin Shop",
    location: "location",
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  Product(    description: "shbfjksahfdjkdashfjkh ufshgisahdio; uidfhkiashiodsj uifsahyoisah uisdhfisahf uisahdfiosa sadihfioas sihfioash asyfhoiash sdyioas ufioasugouiohfiosadhoisfdh uisdhfoiusaud uhfsdu iuhsdus ,yui isahfisfkjskkjfk",
    address: "146a Thakurpara Road, Comilla",
    id: 2,
    tfo: 213,
    tpo: 321,
    images: [
      "assets/images/Image Popular Product 2.png",
    ],
    time: "09:00-19:30",
    title: "Joty Shop",
    location: "location",
    rating: 4.1,
    isPopular: true,
  ),
  Product(
    address: "146a Thakurpara Road, Comilla dfsdahfkjdhs",
    id: 3,
    tfo: 213,
    tpo: 321,
    description: "shbfjksahfdjkdashfjkh ufshgisahdio; uidfhkiashiodsj uifsahyoisah uisdhfisahf uisahdfiosa sadihfioas sihfioash asyfhoiash sdyioas ufioasugouiohfiosadhoisfdh uisdhfoiusaud uhfsdu iuhsdus ,yui isahfisfkjskkjfk",
    time: "09:00-19:30",
    images: [
      "assets/images/glap.png",
    ],
    title: "Sadi Shop",
    location: "location",
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    address: "146a Thakurpara Road, Comilla",
    id: 4,
    tfo: 213,
    tpo: 321,
    description: "shbfjksahfdjkdashfjkh ufshgisahdio; uidfhkiashiodsj uifsahyoisah uisdhfisahf uisahdfiosa sadihfioas sihfioash asyfhoiash sdyioas ufioasugouiohfiosadhoisfdh uisdhfoiusaud uhfsdu iuhsdus ,yui isahfisfkjskkjfk",
    time: "09:00-19:30",
    images: [
      "assets/images/wireless headset.png",
    ],
    title: "LogitHeadech ",
    location: "location",
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
];
