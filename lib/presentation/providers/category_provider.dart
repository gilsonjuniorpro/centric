import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesProvider = FutureProvider.autoDispose<List<String>>((ref) async {
  await Future.delayed(const Duration(seconds: 5)); // Simulating a delay
  return ["Electronics", "Furniture", "Clothing"];
});

