# 📱 Flutter Project

Welcome to **Flutter Project**! This repository follows a clean and scalable architecture using **Riverpod**, **Freezed**, and **separation of concerns** principles. Below, you'll find a detailed explanation of the project structure and its usage.

## 📂 Project Structure

```plaintext
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

---

## 📁 Directories and Their Usage

### 🔹 **lib/data/**
This layer is responsible for handling data from various sources (APIs, databases, local storage) and converting it into domain models.

#### `models/` - Data Models (using Freezed)
Data models represent the structured format of data retrieved from APIs or databases.

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class ProductModel with _$ProductModel {
   factory ProductModel({
      required int id,
      required String title,
      required String description,
      required double price,
      required String thumbnail,
   }) = _ProductModel;

   factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
}
```

#### `repositories/` - Repository Interfaces and Implementations
Repositories define an abstraction layer to fetch data from different sources.

```dart
import '../models/product.dart';

abstract class ProductRepository {
   Future<List<ProductModel>> getProducts();
}
```

Implementation of the repository:

```dart
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

```

#### `sources/` - Data Sources (Local and Remote)

```dart
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
```

📂 lib/domain/entities/

Entities represent the core business objects used in the application.

```dart
class ProductEntity {
   final int id;
   final String title;
   final String description;
   final double price;
   final String thumbnail;

   ProductEntity({
      required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.thumbnail,
   });
}
```

📂 lib/domain/usecases/

Use cases represent business logic operations.

```dart
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
```

📂 lib/presentation/providers/

Riverpod providers for dependency injection and state management.

```dart
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
```


---

## 🚀 Getting Started

1. **Clone the repository:**
   ```sh
   git clone https://github.com/gilsonjuniorpro/centric.git
   cd flutter-project
   ```

2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

3. **Run the app:**
   ```sh
   flutter run
   ```



https://github.com/user-attachments/assets/521d0f58-f218-4407-bd3c-e2a37ad5c251


---

## 📜 License
This project is licensed under the MIT License.


