# Centric - Flutter Clean Architecture Example

Welcome to Flutter Project! This repository follows a clean and scalable architecture using Riverpod, Freezed, and separation of concerns principles. Below, you'll find a detailed explanation of the project structure and its usage.

📂 Project Structure
```
lib/
  ├── 📂 data/
  │   ├── 📁 models/        # 🏗️ Model classes (using Freezed)
  │   ├── 📁 repositories/  # 🔄 Repository interfaces and implementations
  │   ├── 📁 sources/       # 🌐 Local and remote data sources
  │
  ├── 📂 domain/
  │   ├── 📁 entities/      # 🏢 Business entities
  │   ├── 📁 usecases/      # ⚡ Use cases (business logic)
  │
  ├── 📂 presentation/
  │   ├── 📁 pages/         # 📱 App screens
  │   ├── 📁 widgets/       # 🔳 Reusable UI components
  │   ├── 📁 providers/     # 🔄 Riverpod providers (state management)
  │
  ├── 📂 core/             # ⚙️ Common classes and utilities
  ├── 📄 app.dart          # 🚀 Application entry point
```

## Directory Breakdown

### `lib/data/`

This directory houses all data-related logic.

* **`models/`**: Contains data models used for serialization/deserialization. These classes are
  typically generated using Freezed for immutability and reduced boilerplate.

  ```dart
  // lib/data/models/product_model.dart
  import 'package:freezed_annotation/freezed_annotation.dart';

  part 'product_model.freezed.dart';
  part 'product_model.g.dart';

  @freezed
  class ProductModel with _$ProductModel {
    factory ProductModel({
      required int id,
      required String name,
      required double price,
    }) = _ProductModel;

    factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
  }
  ```

* **`repositories/`**: Defines interfaces and implementations for repositories. Repositories
  abstract data access from various sources (local, remote) and provide a single point of access for
  use cases.

  ```dart
  // lib/data/repositories/product_repository.dart
  abstract class ProductRepository {
    Future<List<ProductModel>> getProducts();
  }

  class ProductRepositoryImpl implements ProductRepository {
    // ...
  }
  ```

* **`sources/`**: Contains data sources that interact directly with APIs or local databases.

    * **`local/`**: Local data sources (e.g., using sqflite).
      ```dart
      // lib/data/sources/local/product_local_data_source.dart

      class ProductLocalDataSource {
        // final Database _database;
        //
        // ProductLocalDataSource(this._database);

        Future<List<ProductModel>> getProducts() async {
          //final List<Map<String, dynamic>> maps = await _database.query('products');
          //return List.generate(maps.length, (i) {
          //  return ProductModel.fromJson(maps[i]);
          //});
          return [];
        }
      }
      ```
    * **`remote/`**: Remote data sources (e.g., using http).
      ```dart
      // lib/data/sources/remote/product_remote_data_source.dart
      import 'package:http/http.dart' as http;
      import 'dart:convert';

      import 'package:your_app/data/models/product_model.dart';


      class ProductRemoteDataSource {
        final http.Client _client;

        ProductRemoteDataSource(this._client);

        Future<List<ProductModel>> getProducts() async {
          final response = await _client.get(Uri.parse('[https://dummyjson.com/products](https://dummyjson.com/products)'));

          if (response.statusCode == 200) {
            final jsonData = jsonDecode(response.body);
            final productList = jsonData['products'] as List;
            return productList.map((json) => ProductModel.fromJson(json)).toList();
          } else {
            throw Exception('Falha ao carregar produtos');
          }
        }
      }
      ```

### `lib/domain/`

This directory contains the core business logic and entities.

* **`entities/`**: Defines business entities, which are plain Dart objects representing the core
  domain concepts. They are independent of any implementation details.

  ```dart
  // lib/domain/entities/product.dart
  class Product {
    final int id;
    final String name;
    final double price;

    Product({required this.id, required this.name, required this.price});
  }
  ```

* **`usecases/`**: Contains use cases, which encapsulate specific business operations. They interact
  with repositories to fetch and manipulate data, and then return entities.

  ```dart
  // lib/domain/usecases/get_products_usecase.dart
  import 'package:your_app/domain/entities/product.dart';
  import 'package:your_app/data/repositories/product_repository.dart';
  import 'package:your_app/data/models/product_model.dart';


  class GetProductsUseCase {
    final ProductRepository _repository;

    GetProductsUseCase(this._repository);

    Future<List<Product>> execute() async{
      final productModels = await _repository.getProducts();
      return productModels.map((productModel) =>
          Product(id: productModel.id, name: productModel.name, price: productModel.price)
      ).toList();
    }
  }
  ```

### `lib/presentation/`

This directory contains the UI layer and state management logic.

* **`pages/`**: Contains individual screens or pages of the application.

* **`widgets/`**: Contains reusable UI components (widgets).

* **`providers/`**: Defines Riverpod providers for managing application state.

  ```dart
  // lib/presentation/providers/product_provider.dart
  import 'package:flutter_riverpod/flutter_riverpod.dart';
  import 'package:your_app/domain/entities/product.dart';
  import 'package:your_app/domain/usecases/get_products_usecase.dart';

  final getProductsUseCaseProvider = Provider((ref) => GetProductsUseCase(ref.watch(productRepositoryProvider)));

  final productsProvider = FutureProvider<List<Product>>((ref) async {
    final useCase = ref.watch(getProductsUseCaseProvider);
    return useCase.execute();
  });
  ```

### `lib/core/`

Contains common classes and functions used throughout the application.

### `lib/app.dart`

The application entry point, where the root widget is defined.

## Getting Started

1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Generate the freezed classes `flutter pub run build_runner generate`

This example provides a basic structure for building a Flutter application with clean architecture.
You can expand upon this foundation to create more complex features and functionalities. Remember to
adapt the code to your specific project requirements.
