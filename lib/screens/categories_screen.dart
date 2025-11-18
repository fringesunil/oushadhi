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

    // Category icons mapping
    final categoryIcons = {
      'Herbs': Icons.local_florist,
      'Oils': Icons.opacity,
      'Supplements': Icons.medication,
      'Teas': Icons.local_cafe,
      'Skincare': Icons.face,
      'Immunity': Icons.health_and_safety,
    };

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        elevation: 0,
        title: const Text(
          "Categories",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: categories.length,
          itemBuilder: (ctx, i) {
            final category = categories[i];
            final productCount = ayurvedicProducts
                .where((p) => p.category == category)
                .length;

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryProductsScreen(
                      category: category,
                      cart: cart,
                      onCartUpdate: onCartUpdate,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        categoryIcons[category] ?? Icons.category,
                        size: 36,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      category,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$productCount Products',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Category Products Screen
class CategoryProductsScreen extends StatelessWidget {
  final String category;
  final List<CartItem> cart;
  final VoidCallback onCartUpdate;

  const CategoryProductsScreen({
    super.key,
    required this.category,
    required this.cart,
    required this.onCartUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final categoryProducts = ayurvedicProducts
        .where((p) => p.category == category)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        elevation: 0,
        title: Text(
          category,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: categoryProducts.isEmpty
          ? Center(
              child: Text(
                'No products in this category',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: categoryProducts.length,
              itemBuilder: (ctx, i) {
                final product = categoryProducts[i];
                final inCart = cart.any(
                  (item) => item.product.id == product.id,
                );
                final cartItem = cart.firstWhere(
                  (item) => item.product.id == product.id,
                  orElse: () => CartItem(product: product, quantity: 0),
                );

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.primaryGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.grass,
                            size: 40,
                            color: AppColors.primaryGreen,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                product.brand,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    '₹${product.price.toStringAsFixed(0)}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryGreen,
                                    ),
                                  ),
                                  const Spacer(),
                                  if (!inCart)
                                    ElevatedButton(
                                      onPressed: () {
                                        cart.add(
                                          CartItem(
                                            product: product,
                                            quantity: 1,
                                          ),
                                        );
                                        onCartUpdate();
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              '${product.name} added to cart',
                                            ),
                                            duration: const Duration(
                                              seconds: 1,
                                            ),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryGreen,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                      ),
                                      child: const Text('Add'),
                                    )
                                  else
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.primaryGreen,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove),
                                            onPressed: () {
                                              if (cartItem.quantity > 1) {
                                                cartItem.quantity--;
                                              } else {
                                                cart.remove(cartItem);
                                              }
                                              onCartUpdate();
                                            },
                                            iconSize: 20,
                                            color: AppColors.primaryGreen,
                                            constraints: const BoxConstraints(
                                              minWidth: 32,
                                              minHeight: 32,
                                            ),
                                            padding: EdgeInsets.zero,
                                          ),
                                          Text(
                                            '${cartItem.quantity}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: () {
                                              cartItem.quantity++;
                                              onCartUpdate();
                                            },
                                            iconSize: 20,
                                            color: AppColors.primaryGreen,
                                            constraints: const BoxConstraints(
                                              minWidth: 32,
                                              minHeight: 32,
                                            ),
                                            padding: EdgeInsets.zero,
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
