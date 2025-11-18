import 'package:flutter/material.dart';
import 'package:oushadhi/main.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../core/colors.dart';

class CartScreen extends StatefulWidget {
  final List<CartItem> cart;
  final VoidCallback onUpdate;
  const CartScreen({super.key, required this.cart, required this.onUpdate});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Razorpay _razorpay;

  double get total => widget.cart.fold(
    0,
    (sum, item) => sum + item.product.price * item.quantity,
  );

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Successful: ${response.paymentId}")),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Failed: ${response.message}")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("External Wallet: ${response.walletName}")),
    );
  }

  void _openCheckout(double amount) {
    var options = {
      'key': 'rzp_test_eKhFJmDgLky7dl',
      'amount': (amount * 100).toInt(),
      'name': 'Oushadhi',
      'description': 'Payment for cart items',
      'prefill': {'contact': '1234567890', 'email': 'user@example.com'},
      'external': {
        'wallets': ['paytm'],
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cart.isEmpty) {
      return Container(
        color: AppColors.backgroundWhite,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.shopping_bag_outlined,
                size: 70,
                color: AppColors.greyText.withOpacity(0.6),
              ),
              const SizedBox(height: 12),
              const Text(
                "Your cart is empty",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              Text(
                "Add Ayurvedic products from Oushadhi",
                style: TextStyle(fontSize: 13, color: AppColors.greyText),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      color: AppColors.backgroundWhite,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              itemCount: widget.cart.length,
              itemBuilder: (ctx, i) {
                final item = widget.cart[i];
                final itemTotal = item.product.price * item.quantity;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              item.product.imageUrl,
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.product.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryGreen
                                            .withOpacity(0.08),
                                        borderRadius: BorderRadius.circular(
                                          999,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.local_shipping_outlined,
                                            size: 14,
                                            color: AppColors.primaryGreen,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "Delivery in 3-5 days",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: AppColors.primaryGreen,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Text(
                                      "₹${item.product.price.toStringAsFixed(0)}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      "x ${item.quantity}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.greyText,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "₹${itemTotal.toStringAsFixed(0)}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: AppColors.primaryGreen,
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
                  ),
                ).buildQuantityBar(
                  context,
                  quantity: item.quantity,
                  onDecrement: () {
                    if (item.quantity > 1) {
                      item.quantity--;
                    } else {
                      widget.cart.removeAt(i);
                    }
                    widget.onUpdate();
                    setState(() {});
                  },
                  onIncrement: () {
                    item.quantity++;
                    widget.onUpdate();
                    setState(() {});
                  },
                  onRemove: () {
                    widget.cart.removeAt(i);
                    widget.onUpdate();
                    setState(() {});
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 18,
                  offset: const Offset(0, -6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _priceRow("Total MRP", "₹${total.toStringAsFixed(0)}"),
                _priceRow("Coupon Savings", "Free"),
                _priceRow("Delivery Fee", "₹50"),
                const SizedBox(height: 6),
                const Divider(),
                _priceRow(
                  "You Pay",
                  "₹${(total + 50).toStringAsFixed(0)}",
                  isBold: true,
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                      elevation: 3,
                    ),
                    onPressed: () {
                      double finalamount = total + 50;
                      _openCheckout(finalamount);
                    },
                    child: Text(
                      "Pay ₹${(total + 50).toStringAsFixed(0)} securely",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceRow(String label, String value, {bool isBold = false}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: isBold ? Colors.black : AppColors.textDark,
                fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      );
}

/// Extension to attach a quantity bar under each cart item card nicely
extension _CartItemQuantityBar on Widget {
  Widget buildQuantityBar(
    BuildContext context, {
    required int quantity,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
    required VoidCallback onRemove,
  }) {
    return Column(
      children: [
        this,
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 10),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: AppColors.lightGreen,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      iconSize: 20,
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: onDecrement,
                    ),
                    Text(
                      "$quantity",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                      iconSize: 20,
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: onIncrement,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: onRemove,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.greyText,
                ),
                icon: const Icon(Icons.delete_outline, size: 18),
                label: const Text("Remove", style: TextStyle(fontSize: 13)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
