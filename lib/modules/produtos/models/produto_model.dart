class ProdutoModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final String category;
  final String image;
  bool isLiked;
  bool productCar;

  ProdutoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    this.isLiked = false,
    this.productCar = false,
  });

  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      category: json['category'],
      image: json['image'],
    );
  }
}
