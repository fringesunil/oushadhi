// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:oushadhi/models/products.dart';
import '../main.dart';
import '../widgets/product_card.dart';
import '../core/colors.dart';

class HomeScreen extends StatefulWidget {
  final List<CartItem> cart;
  final VoidCallback onCartUpdate;

  const HomeScreen({super.key, required this.cart, required this.onCartUpdate});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const List<Map<String, String>> banners = [
    {
      "title": "Monsoon Wellness",
      "subtitle": "Boost Immunity Naturally",
      "image":
          "https://thumbs.dreamstime.com/b/ayurvedic-background-natural-healing-herbs-elements-ai-generated-ayurveda-k-wallpaper-banner-ayurvedic-herbal-313395798.jpg",
    },
    {
      "title": "Glow with Ayurveda",
      "subtitle": "100% Pure & Natural",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJ3JPci3MGqfo9A4EDOCKjcPvn5TRQ7PoSmQ&s",
    },
    {
      "title": "Summer Sale",
      "subtitle": "Up to 40% Off on Best Sellers",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXEf41c65tm0ZiQ0wOPOtYERDdughExZt65w&s",
    },
  ];

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
  void initState() {
    super.initState();
    // Auto-slide every 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Oushadhi",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: AppColors.primaryGreen,
          ),
        ),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_outlined, size: 28),
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      "3",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Notifications clicked")),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
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

            // Auto-Sliding Banner with Zoom Effect
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentPage = index % banners.length);
                  // Auto-play next
                  Future.delayed(const Duration(seconds: 4), () {
                    if (mounted) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOut,
                      );
                    }
                  });
                },
                itemBuilder: (context, index) {
                  final banner = banners[index % banners.length];
                  return AnimatedBannerItem(
                    title: banner["title"]!,
                    subtitle: banner["subtitle"]!,
                    imageUrl: banner["image"]!,
                  );
                },
              ),
            ),

            // Page Indicator Dots
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(banners.length, (i) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == i ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == i
                        ? AppColors.primaryGreen
                        : Colors.grey[400],
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),

            // Must Try Brands
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

            // Featured Products
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
                  final existing = widget.cart
                      .where((c) => c.product.id == ayurvedicProducts[i].id)
                      .firstOrNull;
                  if (existing != null) {
                    existing.quantity++;
                  } else {
                    widget.cart.add(CartItem(product: ayurvedicProducts[i]));
                  }
                  widget.onCartUpdate();
                },
              ),
            ),
            const SizedBox(height: 80),
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

// Beautiful Animated Banner Item with Zoom Effect
class AnimatedBannerItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const AnimatedBannerItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image with Zoom Animation
            AnimatedScale(
              scale: 1.08,
              duration: const Duration(seconds: 8),
              curve: Curves.easeInOut,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  return progress == null
                      ? child
                      : const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                },
              ),
            ),
            // Dark Overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black87, Colors.transparent],
                ),
              ),
            ),
            // Text Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primaryGreen,
                    ),
                    child: const Text("Shop Now"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
