import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductRemoteSource {
  final String apiUrl = 'https://dummyjson.com/products';

  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['products'] as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}