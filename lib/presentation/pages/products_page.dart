import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/category_provider.dart';
import '../providers/product_provider.dart';
import '../widgets/loading_indicator.dart';

class ProductsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productProvider);
    final categoriesAsync = ref.watch(categoriesProvider);

    // Force loading if any provider is still fetching data
    final isLoading = productsAsync.isLoading || categoriesAsync.isLoading;

    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: Stack(
        children: [
          Column(
            children: [
              // Categories
              categoriesAsync.when(
                data: (categories) => Wrap(
                  spacing: 8,
                  children: categories.map((cat) => Chip(label: Text(cat))).toList(),
                ),
                loading: () => SizedBox(), // Keep UI from flickering
                error: (_, __) => SizedBox(),
              ),

              // Products
              Expanded(
                child: productsAsync.when(
                  data: (products) => ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ListTile(
                        leading: Image.network(product.thumbnail, width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(product.title),
                        subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                      );
                    },
                  ),
                  loading: () => SizedBox(), // Prevent UI flicker
                  error: (e, _) => Center(child: Text('Failed to load products')),
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
