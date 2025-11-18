import 'package:flutter/material.dart';
import 'package:oushadhi/models/products.dart';
import 'package:oushadhi/screens/account_screen.dart';
import 'package:oushadhi/screens/cart.dart';
import 'package:oushadhi/screens/categories_screen.dart';
import 'package:oushadhi/screens/home_page.dart';
import 'core/colors.dart';

void main() {
  runApp(const OushadhiApp());
}

class OushadhiApp extends StatelessWidget {
  const OushadhiApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oushadhi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: AppColors.backgroundWhite,
        primaryColor: AppColors.primaryGreen,
      ),
      home: const MainNavigator(),
    );
  }
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});
  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int currentIndex = 0;
  List<CartItem> cart = [];

  late final List<Widget> screens;

  final sectionTitles = const ['Home', 'Categories', 'Cart', 'Account'];

  @override
  void initState() {
    super.initState();
    screens = [
      HomeScreen(cart: cart, onCartUpdate: () => setState(() {})),
      CategoriesScreen(cart: cart, onCartUpdate: () => setState(() {})),
      CartScreen(cart: cart, onUpdate: () => setState(() {})),
      AccountScreen(),
    ];
  }

  void _onSearchTap(BuildContext context) {
    showSearch(context: context, delegate: ProductSearchDelegate());
  }

  Widget _buildWebTopBar(BuildContext context) {
    return Material(
      elevation: 3,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        height: 68,
        child: Row(
          children: [
            Text(
              "Oushadhi",
              style: TextStyle(
                fontSize: 30,
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 40),
            ...List.generate(4, (i) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      currentIndex = i;
                    });
                  },
                  child: Text(
                    sectionTitles[i],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: currentIndex == i
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: currentIndex == i
                          ? AppColors.primaryGreen
                          : Colors.grey[800],
                    ),
                  ),
                ),
              );
            }),
            const Spacer(),
            // Web Search Bar
            SizedBox(
              width: 420,
              height: 48,
              child: TextField(
                onTap: () => _onSearchTap(context),
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Search products, oils, herbs...",
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.primaryGreen,
                  ),
                  fillColor: AppColors.backgroundWhite,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 28),
            IconButton(
              icon: Badge(
                isLabelVisible: cart.isNotEmpty,
                label: Text(cart.length.toString()),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
              iconSize: 32,
              tooltip: 'Cart',
              onPressed: () {
                setState(() {
                  currentIndex = 2;
                });
              },
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.account_circle_outlined),
              iconSize: 32,
              tooltip: 'Account',
              onPressed: () {
                setState(() {
                  currentIndex = 3;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 1100;
    return Scaffold(
      body: isDesktop
          ? Column(
              children: [
                _buildWebTopBar(context),
                Expanded(
                  child: IndexedStack(index: currentIndex, children: screens),
                ),
              ],
            )
          : screens[currentIndex],
      bottomNavigationBar: isDesktop
          ? null
          : BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (i) => setState(() => currentIndex = i),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.primaryGreen,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: "Categories",
                ),
                BottomNavigationBarItem(
                  icon: Badge(
                    label: Text(cart.length.toString()),
                    isLabelVisible: cart.isNotEmpty,
                    child: const Icon(Icons.shopping_cart),
                  ),
                  label: "Cart",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Account",
                ),
              ],
            ),
    );
  }
}

class CartItem {
  final Product product;
  int quantity;
  CartItem({required this.product, this.quantity = 1});
}

// ProductSearchDelegate for showSearch, can be extended as needed
class ProductSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        query = '';
      },
    ),
  ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, ''),
  );

  @override
  Widget buildResults(BuildContext context) => buildSuggestions(context);

  @override
  Widget buildSuggestions(BuildContext context) {
    // Simple search among ayurvedicProducts name, brand
    final results = ayurvedicProducts.where(
      (p) =>
          p.name.toLowerCase().contains(query.toLowerCase()) ||
          p.brand.toLowerCase().contains(query.toLowerCase()),
    );
    return ListView(
      children: results.isEmpty
          ? [const ListTile(title: Text('No products found.'))]
          : results
                .map(
                  (p) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(p.imageUrl),
                    ),
                    title: Text(p.name),
                    subtitle: Text(p.brand),
                    onTap: () => close(context, p.name),
                  ),
                )
                .toList(),
    );
  }
}
