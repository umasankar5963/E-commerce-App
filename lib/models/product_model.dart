class Product {
  final String title;
  final String description;
  final double price;
  final double rating;
  final String imageUrl;

  Product({
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      rating: double.parse(json['rating'].toStringAsFixed(1)),
      imageUrl: json['thumbnail'],
    );
  }
}
