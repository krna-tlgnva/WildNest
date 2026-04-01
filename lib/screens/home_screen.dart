import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import '../widgets/marketplace_bottom_bar.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.shopState, super.key});

  final ShopState shopState;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shopState,
      builder: (context, _) {
        final items = shopState.products;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Shop app'),
            actions: <Widget>[
              IconButton(
                onPressed: () => context.go('/profile'),
                icon: const Icon(Icons.person_outline),
              ),
            ],
          ),
          bottomNavigationBar: MarketplaceBottomBar(
            currentIndex: 0,
            cartItemsCount: shopState.cartItemsCount,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Products',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  '${shopState.favoriteProducts.length} favorites, ${shopState.cartItemsCount} items in cart',
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    itemCount: items.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.58,
                        ),
                    itemBuilder: (context, index) {
                      final product = items[index];
                      return ProductCard(
                        product: product,
                        isFavorite: shopState.isFavorite(product.id),
                        isInCart: shopState.isInCart(product.id),
                        onTap: () => context.go('/product/${product.id}'),
                        onFavoritePressed: () =>
                            shopState.toggleFavorite(product.id),
                        onAddToCartPressed: () =>
                            shopState.addToCart(product.id),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
