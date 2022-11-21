import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Starrating extends StatelessWidget {
  final double rating;

  Starrating({required this.rating});
  @override
  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),

    Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
    children: [
    Text(
    "$rating",
    style: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    ),
    ),
    const SizedBox(width: 5),
    SvgPicture.asset("assets/icons/Star Icon.svg"),
    ],
    ),
    ),
      ],
    );
  }
}
