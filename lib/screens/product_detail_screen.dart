import 'package:flutter/material.dart';
import '../models/products.dart';
import '../core/colors.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 900;

        return Scaffold(
          backgroundColor: AppColors.backgroundWhite,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: AppColors.primaryGreen,
            centerTitle: false,
            title: Text(
              product.name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ),
          body: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: const EdgeInsets.all(24.0),
              child: isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: _ProductImageSection(product: product),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          flex: 6,
                          child: _ProductDetailInfo(
                            product: product,
                            onAdd: onAdd,
                            spacing: 24,
                          ),
                        ),
                      ],
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _ProductImageSection(product: product),
                          const SizedBox(height: 16),
                          _ProductDetailInfo(
                            product: product,
                            onAdd: onAdd,
                            spacing: 18,
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}

class _ProductImageSection extends StatelessWidget {
  final Product product;

  const _ProductImageSection({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 260,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              // gradient: LinearGradient(
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              //   // colors: [
              //   //   // ignore: deprecated_member_use
              //   //   AppColors.primaryGreen.withOpacity(0.08),
              //   //   Colors.white,
              //   // ],
              // ),
            ),
            child: Center(
              child: Hero(
                tag: product.imageUrl,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(product.imageUrl, fit: BoxFit.contain),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _pill(icon: Icons.eco_outlined, label: "Ayurvedic"),
              const SizedBox(width: 8),
              _pill(icon: Icons.verified_outlined, label: "Oushadhi Certified"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pill({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.primaryGreen.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primaryGreen),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.primaryGreen,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductDetailInfo extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;
  final double spacing;
  const _ProductDetailInfo({
    required this.product,
    required this.onAdd,
    this.spacing = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: spacing > 20 ? spacing : 0, top: spacing),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Brand chip
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: AppColors.primaryGreen.withOpacity(0.08),
                  ),
                  child: Text(
                    product.brand,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primaryGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border, color: AppColors.textGrey),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Size: ${product.size}",
              style: const TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const SizedBox(height: 18),

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "₹${product.price}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: AppColors.primaryGreen,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "Inclusive of all taxes",
                  style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Highlights
            Row(
              children: const [
                Icon(Icons.local_shipping_outlined, size: 18),
                SizedBox(width: 8),
                Text("Fast delivery available", style: TextStyle(fontSize: 13)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.health_and_safety_outlined, size: 18),
                SizedBox(width: 8),
                Text(
                  "Authentic & quality checked",
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              "Description",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              "Traditional Ayurvedic formulation from Oushadhi. "
              "Carefully prepared with quality ingredients to support your wellness.",
              style: TextStyle(
                fontSize: 13.5,
                height: 1.4,
                color: AppColors.textGrey,
              ),
            ),

            const SizedBox(height: 22),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.add_shopping_cart,
                  color: AppColors.pureWhite,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  elevation: 3,
                ),
                label: const Text(
                  "Add to Cart",
                  style: TextStyle(color: AppColors.pureWhite),
                ),
                onPressed: onAdd,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
