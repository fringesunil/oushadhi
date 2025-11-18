import 'package:flutter/material.dart';
import 'package:oushadhi/main.dart';
import '../core/colors.dart';

class CartScreen extends StatefulWidget {
  final List<CartItem> cart;
  final VoidCallback onUpdate;
  const CartScreen({super.key, required this.cart, required this.onUpdate});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double get total => widget.cart.fold(
    0,
    (sum, item) => sum + item.product.price * item.quantity,
  );

  @override
  Widget build(BuildContext context) {
    if (widget.cart.isEmpty) {
      return const Center(
        child: Text("Your cart is empty", style: TextStyle(fontSize: 20)),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: widget.cart.length,
            itemBuilder: (ctx, i) {
              final item = widget.cart[i];
              return Card(
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.product.imageUrl,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(item.product.name),
                  subtitle: Text("Delivery by Tue, 5 Jan"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          if (item.quantity > 1)
                            item.quantity--;
                          else
                            widget.cart.removeAt(i);
                          widget.onUpdate();
                          setState(() {});
                        },
                      ),
                      Text("${item.quantity}"),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () {
                          item.quantity++;
                          widget.onUpdate();
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Column(
            children: [
              _priceRow("Total MRP", "₹${total.toStringAsFixed(0)}"),
              _priceRow("Coupon Savings", "Free"),
              _priceRow("Delivery Fee", "₹50"),
              const Divider(),
              _priceRow(
                "You Pay",
                "₹${(total + 50).toStringAsFixed(0)}",
                isBold: true,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => const AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 80,
                            color: Colors.green,
                          ),
                          Text(
                            "Payment done successfully!",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Text(
                  "Pay ₹${(total + 50).toStringAsFixed(0)} securely",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _priceRow(String label, String value, {bool isBold = false}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(
              value,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      );
}
