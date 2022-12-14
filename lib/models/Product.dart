

class Product {
  final int qty;
  final String id,title, description,uid;
  final String images;
  //final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  Product({
    required this.id,
    required this.uid,
    required this.qty,
    required this.images,
   // required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
  });
}

// Our demo Products
//
// List<Product> demoProducts = [
//   Product(
//     //id: 1,
//     qty: 213,
//     images:
//     [
//       "assets/images/ps4_console_white_1.png",
//       "assets/images/ps4_console_white_2.png",
//       "assets/images/ps4_console_white_3.png",
//       "assets/images/ps4_console_white_4.png",
//     ],
//     // colors: [
//     //   Color(0xFFF6625E),
//     //   Color(0xFF836DB8),
//     //   Color(0xFFDECB9C),
//     //   Colors.white,
//     // ],
//     title: "Wireless Controller for PS4™",
//     price: 64.99,
//     description: description,
//     rating: 4.8,
//     isFavourite: true,
//     isPopular: true,
//   ),
//   Product(
//     id: 2,
//     qty: 215,
//     images: [
//       "assets/images/Image Popular Product 2.png",
//     ],
//     // colors: [
//     //   Color(0xFFF6625E),
//     //   Color(0xFF836DB8),
//     //   Color(0xFFDECB9C),
//     //   Colors.white,
//     // ],
//     title: "Nike Sport White - Man Pant",
//     price: 50.5,
//     description: description,
//     rating: 4.1,
//     isPopular: true,
//   ),
//   Product(
//     id: 3,
//     qty: 342,
//     images: [
//       "assets/images/glap.png",
//     ],
//     // colors: [
//     //   Color(0xFFF6625E),
//     //   Color(0xFF836DB8),
//     //   Color(0xFFDECB9C),
//     //   Colors.white,
//     // ],
//     title: "Gloves XC Omega - Polygon",
//     price: 36.55,
//     description: description,
//     rating: 4.1,
//     isFavourite: true,
//     isPopular: true,
//   ),
//   Product(
//     id: 4,
//     qty: 345,
//     images: [
//       "assets/images/wireless headset.png",
//     ],
//     // colors: [
//     //   Color(0xFFF6625E),
//     //   Color(0xFF836DB8),
//     //   Color(0xFFDECB9C),
//     //   Colors.white,
//     // ],
//     title: "Logitech Head",
//     price: 20.20,
//     description: description,
//     rating: 4.1,
//     isFavourite: true,
//   ),
// ];
//
// const String description =
//     "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
