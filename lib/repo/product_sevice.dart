import 'package:dio/dio.dart';

import '../data/product.dart';

class ProductService {
  final Dio _dio = Dio();

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _dio.get('https://dummyjson.com/products');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
        if (data.containsKey('products')) {
          final List<dynamic> products = data['products'];
          return products.map((json) => Product.fromJson(json)).toList();
        } else {
          throw Exception('Failed to fetch products');
        }
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

}

