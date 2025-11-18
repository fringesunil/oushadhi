import 'package:flutter/material.dart';
import 'package:oushadhi/Core/colors.dart';
import 'product_detail_page.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

final List<Product> demoProducts = [
  Product(
    name: 'Ashwagandha',
    description: 'Boosts energy, reduces stress.',
    price: 249.0,
    imageUrl:
        'https://www.ayushherbs.com/cdn/shop/products/ashwagandha-root_900x.jpg',
  ),
  Product(
    name: 'Brahmi',
    description: 'Enhances memory and cognition.',
    price: 175.0,
    imageUrl:
        'https://www.1mg.com/articles/wp-content/uploads/2019/03/Brahmi-main.jpg',
  ),
  Product(
    name: 'Triphala',
    description: 'Supports digestion and immunity.',
    price: 199.0,
    imageUrl: 'https://www.organicfacts.net/wp-content/uploads/triphala1.jpg',
  ),
];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _goToCart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLightGreen,
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        title: const Text('Oushadhi Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => _goToCart(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: demoProducts.length,
          itemBuilder: (context, index) {
            final product = demoProducts[index];
            return Card(
              color: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(product.imageUrl),
                  radius: 28,
                ),
                title: Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text(product.description),
                trailing: Text(
                  '₹${product.price}',
                  style: TextStyle(
                    color: AppColors.primaryGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(product: product),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        title: const Text('Your Cart'),
      ),
      body: const Center(
        child: Text('Your cart is empty.', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
