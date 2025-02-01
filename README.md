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

📁 Directories and Their Usage

🔹 lib/data/

This layer is responsible for handling data from various sources (APIs, databases, local storage) and converting it into domain models.

models/ - Data Models (using Freezed)

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

