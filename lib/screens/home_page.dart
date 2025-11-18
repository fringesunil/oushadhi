import 'package:flutter/material.dart';
import 'package:oushadhi/main.dart';
import 'package:oushadhi/models/products.dart';

import '../widgets/product_card.dart';
import '../core/colors.dart';

class HomeScreen extends StatelessWidget {
  final List<CartItem> cart;
  final VoidCallback onCartUpdate;

  const HomeScreen({super.key, required this.cart, required this.onCartUpdate});

  static const List<Map<String, String>> brands = [
    {
      'name': 'Himalaya',
      'img':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzQwcB_OqLp4WmOCUxmPuoawnRiI6AaDxMtA&s',
    },
    {
      'name': 'Dabur',
      'img':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXKcqsKvgup4RLTAglxeWfch47Q8J4jq48HQ&s',
    },
    {
      'name': 'Patanjali',
      'img':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTVzncIC8M85GxOD0dQcwA8zuP05VeKe5DeA&s',
    },
    {
      'name': 'Biotique',
      'img':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2nrWNDI3W2kA35J5CagYqeBqRV-GNZocz0g&s',
    },
    {
      'name': 'Kapiva',
      'img':
          'https://cdn11.bigcommerce.com/s-5h8rqg02f8/images/stencil/original/products/1094/9679/Market__16128.1719835474.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: AppColors.primaryGreen,
        // centerTitle: true,
        title: const Text(
          "Oushadhi",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
        ),
        elevation: 0,
      ),
      backgroundColor: AppColors.bg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText: "Search products",
                prefixIcon: Icon(Icons.search),
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
                      gradient: const LinearGradient(
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

                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: null,
                          child: Text("Shop Now"),
                        ),
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
                children: brands
                    .map((brand) => _brandTile(brand['name']!, brand['img']!))
                    .toList(),
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
      ),
    );
  }

  static Widget _brandTile(String name, String imgUrl) => Container(
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
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.network(
            imgUrl,
            height: 54,
            width: 54,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}
