import '../entities/product_entity.dart';
import '../../data/repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<List<ProductEntity>> call() async {
    final products = await repository.getProducts();
    return products.map((model) => ProductEntity(
      id: model.id,
      title: model.title,
      description: model.description,
      price: model.price,
      thumbnail: model.thumbnail,
    )).toList();
  }
}