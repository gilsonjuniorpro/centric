import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../../domain/entities/product_entity.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/sources/product_remote_source.dart';

final productRepositoryProvider = Provider((ref) {
  return ProductRepositoryImpl(ProductRemoteSource());
});

final productProvider = FutureProvider.autoDispose<List<ProductEntity>>((ref) async {
  final repository = ref.read(productRepositoryProvider);
  final useCase = GetProductsUseCase(repository);
  return await useCase();
});
