

class Store {
  final int tfo,tpo;
  final String title, district,address,description, subDistrict, id,type;
  final List<String> images;
  final double rating, lat, lon;
  final bool isFavourite, isPopular;

  Store({
    required this.description,
    required this.address,
    required this.images,
    required this.rating,
    required this.lat,
    required this.lon,
    this.isFavourite = true,
    this.isPopular = false,
    required this.title,
    required this.district,
    required this.subDistrict,
    this.tfo=0,
    this.tpo=0,
    required this.id,
     this.type="N/A",
  });
}
