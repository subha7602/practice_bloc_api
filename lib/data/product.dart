class Product {
   String title;
  String description;
   int price; // Add price as dynamic

  Product(this.description, this.title, this.price); // Adjust constructor

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price, // Add price to JSON
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['title'],
      json['description'],
      json['price'], // Get price from JSON
    );
  }
}

