import 'package:flutter/material.dart';

class Store {
  final int tfo,tpo,id;
  final String title, district,address,description, subDistrict;
  final List<String> images;
  final double rating;
  final bool isFavourite, isPopular;

  Store({
    required this.description,
    required this.address,
    required this.images,
    required this.rating,
    this.isFavourite = true,
    this.isPopular = false,
    required this.title,
    required this.district,
    required this.subDistrict,
    this.tfo=0,
    this.tpo=0,
    this.id=0,
  });
}
