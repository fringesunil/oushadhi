import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../models/products.dart';
import '../main.dart';

class CategoriesScreen extends StatelessWidget {
  final List<CartItem> cart;
  final VoidCallback onCartUpdate;

  const CategoriesScreen({
    super.key,
    required this.cart,
    required this.onCartUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final categories = ayurvedicProducts
        .map((p) => p.category)
        .toSet()
        .toList();
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        title: const Text("Categories"),
      ),
      body: ListView.separated(
        itemCount: categories.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (ctx, i) => ListTile(
          title: Text(
            categories[i],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            // You can implement category filtering logic here
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Filter by ${categories[i]} coming soon!'),
              ),
            );
          },
        ),
      ),
    );
  }
}
