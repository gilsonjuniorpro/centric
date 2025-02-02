import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/category_provider.dart';
import '../providers/product_provider.dart';
import '../widgets/loading_indicator.dart';

class ProductsPage extends ConsumerWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productProvider);
    final categoriesAsync = ref.watch(categoriesProvider);

    final isLoading = productsAsync.isLoading || categoriesAsync.isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: Stack(
        children: [
          Column(
            children: [
              categoriesAsync.when(
                data: (categories) => Wrap(
                  spacing: 8,
                  children: categories.map((cat) => Chip(label: Text(cat))).toList(),
                ),
                loading: () => const SizedBox(), // Keep UI from flickering
                error: (_, __) => const SizedBox(),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(thickness: 1, height: 1),
              ),

              // Products List with Divider
              Expanded(
                child: productsAsync.when(
                  data: (products) => ListView.separated(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ListTile(
                        leading: Image.network(product.thumbnail, width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(product.title),
                        subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(thickness: 1, height: 1),
                  ),
                  loading: () => const SizedBox(), // Prevent UI flicker
                  error: (e, _) => const Center(child: Text('Failed to load products')),
                ),
              ),
            ],
          ),

          // Show loading indicator only when loading
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.8),
                child: const LoadingIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
