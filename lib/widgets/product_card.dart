import 'package:flutter/material.dart';
import 'package:oushadhi/main.dart';
import '../models/products.dart';
import '../screens/product_detail_screen.dart';
import '../core/colors.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final List<CartItem> cart;
  final VoidCallback onCartUpdate;
  const ProductCard({
    super.key,
    required this.product,
    required this.cart,
    required this.onCartUpdate,
  });
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int _getQuantityInCart() {
    final found = widget.cart.where((c) => c.product.id == widget.product.id);
    return found.isNotEmpty ? found.first.quantity : 0;
  }

  void _increment() {
    final idx = widget.cart.indexWhere(
      (c) => c.product.id == widget.product.id,
    );
    if (idx >= 0) {
      widget.cart[idx].quantity++;
    } else {
      widget.cart.add(CartItem(product: widget.product));
    }
    widget.onCartUpdate();
    setState(() {});
  }

  void _decrement() {
    final idx = widget.cart.indexWhere(
      (c) => c.product.id == widget.product.id,
    );
    if (idx >= 0) {
      if (widget.cart[idx].quantity > 1) {
        widget.cart[idx].quantity--;
      } else {
        widget.cart.removeAt(idx);
      }
      widget.onCartUpdate();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1100;
    final isTablet = size.width > 600 && size.width <= 1100;
    final qty = _getQuantityInCart();
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              ProductDetailScreen(product: widget.product, onAdd: () {}),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------- Product Image Section -----------
            Hero(
              tag: widget.product.imageUrl,
              child: Container(
                height: isDesktop
                    ? size.height * 0.16
                    : isTablet
                    ? size.height * 0.16
                    : size.height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.network(
                      widget.product.imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

            // ----------- Product Details -----------
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product name
                  Text(
                    widget.product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 2),

                  // Brand
                  Text(
                    widget.product.brand,
                    style: TextStyle(color: AppColors.greyText, fontSize: 12),
                  ),

                  const SizedBox(height: 8),

                  // Price & Stock
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryGreen.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "₹${widget.product.price}",
                          style: TextStyle(
                            color: AppColors.primaryGreen,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                      ),

                      // Stock alert (if low)
                      if (widget.product.stock <= 10)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.deepOrange.withOpacity(0.12),
                          ),
                          child: Text(
                            "Only ${widget.product.stock} left",
                            style: const TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // ----------- Add to Cart Button -----------
                  if (qty == 0)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _increment,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryGreen,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 2,
                        ),
                        child: const Text(
                          "Add",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          color: AppColors.primaryGreen,
                          visualDensity: VisualDensity.compact,
                          onPressed: _decrement,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.backgroundWhite,
                          ),
                          child: Text(
                            '$qty',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          color: AppColors.primaryGreen,
                          visualDensity: VisualDensity.compact,
                          onPressed: _increment,
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
  }
}
