import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title, location,time;
  final List<String> images;
  final double rating;
  final bool isFavourite, isPopular;

  Product({
    required this.id,
    required this.images,
    required this.time,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.location,
  });
}

// Our demo Products

List<Product> demoProducts = [
  Product(
    id: 1,
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
  Product(
    id: 2,
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
    id: 3,
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
    id: 4,
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
