import 'package:flutter/material.dart';
import 'package:oushadhi/models/products.dart';
import 'package:oushadhi/screens/account_screen.dart';
import 'package:oushadhi/screens/cart.dart';
import 'package:oushadhi/screens/categories_screen.dart';
import 'package:oushadhi/screens/home_page.dart';
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
        scaffoldBackgroundColor: AppColors.bg,
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

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      body: isDesktop
          ? Row(
              children: [
                NavigationRail(
                  selectedIndex: currentIndex,
                  onDestinationSelected: (i) => setState(() => currentIndex = i),
                  labelType: NavigationRailLabelType.selected,
                  backgroundColor: Colors.white,
                  destinations: const [
                    NavigationRailDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: Text("Home")),
                    NavigationRailDestination(icon: Icon(Icons.category_outlined), selectedIcon: Icon(Icons.category), label: Text("Categories")),
                    NavigationRailDestination(icon: Icon(Icons.shopping_cart_outlined), selectedIcon: Icon(Icons.shopping_cart), label: Text("Cart")),
                    NavigationRailDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: Text("Account")),
                  ],
                ),
                Expanded(child: screens[currentIndex]),
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
                const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                const BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
                BottomNavigationBarItem(
                  icon: Badge(
                    label: Text(cart.length.toString()),
                    isLabelVisible: cart.isNotEmpty,
                    child: const Icon(Icons.shopping_cart),
                  ),
                  label: "Cart",
                ),
                const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
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