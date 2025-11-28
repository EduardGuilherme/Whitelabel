class In8Product {
  final String name;
  final String description;
  final String price;
  final List<String> gallery;

  In8Product({
    required this.name,
    required this.description,
    required this.price,
    required this.gallery,
  });

  factory In8Product.fromJson(Map<String, dynamic> json) {
    return In8Product(
      name: json['name'],
      description: json['description'],
      price: json['price'],
      gallery: List<String>.from(json['gallery']),
    );
  }
}
