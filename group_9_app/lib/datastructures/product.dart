class Product {
  final String name;
  final String mainImage;
  final List<String> subImages;
  final String abstractPrice;
  final double exactPrice;
  final String description;
  final List<String> category;
  final int rate;
  final List<dynamic> stories;
  final String status;

  Product({
    required this.name,
    required this.mainImage,
    required this.subImages,
    required this.abstractPrice,
    required this.exactPrice,
    required this.description,
    required this.category,
    required this.rate,
    required this.stories,
    required this.status,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      mainImage: json['mainImage'],
      subImages: List<String>.from(json['subImages']),
      abstractPrice: json['abstractPrice'],
      exactPrice: json['exactPrice'].toDouble(),
      description: json['description'],
      category: List<String>.from(json['category']),
      rate: json['rate'],
      stories: (json['stories'] as List<dynamic>? ?? []),
      status: json['status'],
    );
  }
}