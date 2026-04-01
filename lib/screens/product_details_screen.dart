import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import '../widgets/product_image.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    required this.productId,
    required this.shopState,
    super.key,
  });

  final int productId;
  final ShopState shopState;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shopState,
      builder: (context, _) {
        final product = shopState.getProductById(productId);

        if (product == null) {
          return const Scaffold(body: Center(child: Text('Product not found')));
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(product.brand),
            leading: IconButton(
              onPressed: () => context.go('/'),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              SizedBox(
                height: 280,
                child: ProductImage(
                  imageUrl: product.imageUrl,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.brand,
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 8),
              Text(
                '${product.price.toStringAsFixed(0)} KZT',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(product.description),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => shopState.toggleFavorite(product.id),
                      child: Text(
                        shopState.isFavorite(product.id) ? 'Saved' : 'Save',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => shopState.addToCart(product.id),
                      child: const Text('Add to cart'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
