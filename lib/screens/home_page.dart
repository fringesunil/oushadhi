// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:oushadhi/main.dart';
import 'package:oushadhi/models/products.dart';
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
    _startAutoPlay();
  }

  void _startAutoPlay() {
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      int nextPage = (_currentPage + 1) % banners.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      _startAutoPlay();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1100;
    final isTablet = size.width > 600 && size.width <= 1100;

    if (isDesktop) {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 28), // Vertical gap below main app top bar
            SizedBox(
              height: 400,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) =>
                    setState(() => _currentPage = i % banners.length),
                itemBuilder: (ctx, i) {
                  final banner = banners[i % banners.length];
                  return AnimatedBannerItem(
                    title: banner["title"]!,
                    subtitle: banner["subtitle"]!,
                    imageUrl: banner["image"]!,
                    isDesktop: isDesktop,
                  );
                },
                itemCount: banners.length,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                banners.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == i ? 30 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: _currentPage == i
                        ? AppColors.primaryGreen
                        : Colors.grey[400],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              "Must Try Brands",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: brands.length,
                itemBuilder: (ctx, i) => _brandTile(
                  brands[i]['name']!,
                  brands[i]['img']!,
                  isDesktop,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              "Featured Products",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                childAspectRatio: 0.8,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
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
            const SizedBox(height: 100),
          ],
        ),
      );
    }

    // Else (Tablet, Mobile): Show as before, with SliverAppBar search bar, etc.
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: CustomScrollView(
        slivers: [
          // SliverAppBar for mobile/tablet with search, etc.
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: Colors.white,
            elevation: 2,
            shadowColor: Colors.black26,
            title: const Text(
              "Oushadhi",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: AppColors.primaryGreen,
              ),
            ),
            actions: [
              IconButton(
                icon: Badge(
                  label: Text(widget.cart.length.toString()),
                  isLabelVisible: widget.cart.isNotEmpty,
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 8),
                          ],
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText:
                                "Search Ayurvedic products, oils, herbs...",
                            prefixIcon: Icon(
                              Icons.search,
                              color: AppColors.primaryGreen,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 220,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (i) =>
                          setState(() => _currentPage = i % banners.length),
                      itemBuilder: (ctx, i) {
                        final banner = banners[i % banners.length];
                        return AnimatedBannerItem(
                          title: banner["title"]!,
                          subtitle: banner["subtitle"]!,
                          imageUrl: banner["image"]!,
                          isDesktop: false,
                        );
                      },
                      itemCount: banners.length,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      banners.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == i ? 30 : 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: _currentPage == i
                              ? AppColors.primaryGreen
                              : Colors.grey[400],
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    "Must Try Brands",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: brands.length,
                      itemBuilder: (ctx, i) => _brandTile(
                        brands[i]['name']!,
                        brands[i]['img']!,
                        false,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    "Featured Products",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isTablet ? 4 : 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: ayurvedicProducts.length,
                    itemBuilder: (ctx, i) => ProductCard(
                      product: ayurvedicProducts[i],
                      onAdd: () {
                        final existing = widget.cart
                            .where(
                              (c) => c.product.id == ayurvedicProducts[i].id,
                            )
                            .firstOrNull;
                        if (existing != null) {
                          existing.quantity++;
                        } else {
                          widget.cart.add(
                            CartItem(product: ayurvedicProducts[i]),
                          );
                        }
                        widget.onCartUpdate();
                      },
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _brandTile(String name, String imgUrl, bool isDesktop) => Container(
    width: isDesktop ? 180 : 130,
    margin: const EdgeInsets.only(right: 20),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        CircleAvatar(
          radius: isDesktop ? 40 : 32,
          backgroundImage: NetworkImage(imgUrl),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isDesktop ? 18 : 14,
          ),
        ),
      ],
    ),
  );
}

class AnimatedBannerItem extends StatelessWidget {
  final String title, subtitle, imageUrl;
  final bool isDesktop;

  const AnimatedBannerItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedScale(
              scale: 1.1,
              duration: const Duration(seconds: 10),
              curve: Curves.easeInOut,
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  colors: [Colors.black87, Colors.transparent],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(isDesktop ? 40 : 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isDesktop ? 36 : 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: isDesktop ? 20 : 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primaryGreen,
                    ),
                    child: Text(
                      "Shop Now",
                      style: TextStyle(fontSize: isDesktop ? 18 : 16),
                    ),
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
