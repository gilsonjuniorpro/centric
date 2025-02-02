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

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required String id,
    required String name,
    required String email,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
```

#### `repositories/` - Repository Interfaces and Implementations
Repositories define an abstraction layer to fetch data from different sources.

```dart
abstract class UserRepository {
  Future<UserModel> getUserById(String id);
}
```

Implementation of the repository:

```dart
import 'package:your_project/data/sources/api_service.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiService apiService;

  UserRepositoryImpl(this.apiService);

  @override
  Future<UserModel> getUserById(String id) async {
    final response = await apiService.getUser(id);
    return UserModel.fromJson(response);
  }
}
```

#### `sources/` - Data Sources (Local and Remote)

```dart
class ApiService {
  Future<Map<String, dynamic>> getUser(String id) async {
    // Simulating an API call
    await Future.delayed(Duration(seconds: 2));
    return {'id': id, 'name': 'John Doe', 'email': 'john.doe@example.com'};
  }
}
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


