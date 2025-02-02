import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../sources/product_remote_source.dart';
import 'product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteSource remoteSource;

  ProductRepositoryImpl(this.remoteSource);

  @override
  Future<List<ProductModel>> getProducts() async {
    return await remoteSource.fetchProducts();
  }
}