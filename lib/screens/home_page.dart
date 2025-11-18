import 'package:flutter/material.dart';
import 'package:oushadhi/main.dart';
import 'package:oushadhi/models/products.dart';

import '../widgets/product_card.dart';
import '../core/colors.dart';

class HomeScreen extends StatelessWidget {
  final List<CartItem> cart;
  final VoidCallback onCartUpdate;

  const HomeScreen({super.key, required this.cart, required this.onCartUpdate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Oushadhi",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryGreen,
            ),
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(
              hintText: "Search products",
              prefixIcon: Icon(Icons.search),
              suffixIcon: Icon(Icons.camera_alt_outlined),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Banner
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: NetworkImage(
                  "https://www.shutterstock.com/image-vector/ayurveda-concept-illustration-ayurvedic-healing-600nw-2196249447.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      colors: [Colors.black87, Colors.transparent],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Hello to Oushadhi",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Summer Sale!",
                        style: TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(onPressed: null, child: Text("Shop Now")),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          const Text(
            "Must Try Brands",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 140,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _brandTile("Himalaya"),
                _brandTile("Dabur"),
                _brandTile("Patanjali"),
                _brandTile("Biotique"),
                _brandTile("Kapiva"),
              ],
            ),
          ),
          const SizedBox(height: 30),

          const Text(
            "Featured Products",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: ayurvedicProducts.length,
            itemBuilder: (ctx, i) => ProductCard(
              product: ayurvedicProducts[i],
              onAdd: () {
                final existing = cart
                    .where((c) => c.product.id == ayurvedicProducts[i].id)
                    .firstOrNull;
                if (existing != null) {
                  existing.quantity++;
                } else {
                  cart.add(CartItem(product: ayurvedicProducts[i]));
                }
                onCartUpdate();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _brandTile(String name) => Container(
    width: 120,
    margin: const EdgeInsets.only(right: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(radius: 30),
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}
