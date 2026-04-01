import 'package:flutter/material.dart';

import '../main.dart';
import '../widgets/marketplace_bottom_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({required this.shopState, super.key});

  final ShopState shopState;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shopState,
      builder: (context, _) {
        final cartItems = shopState.cartEntries;

        return Scaffold(
          appBar: AppBar(title: const Text('Profile')),
          bottomNavigationBar: MarketplaceBottomBar(
            currentIndex: 2,
            cartItemsCount: shopState.cartItemsCount,
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              const CircleAvatar(
                radius: 36,
                child: Icon(Icons.person, size: 36),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Karina',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
              Text('Favorites: ${shopState.favoriteProducts.length}'),
              const SizedBox(height: 8),
              Text('Cart items: ${shopState.cartItemsCount}'),
              const SizedBox(height: 24),
              const Text(
                'Items in cart',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              if (cartItems.isEmpty)
                const Text('No items yet')
              else
                ...cartItems.map(
                  (entry) => Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text(entry.product.title),
                      subtitle: Text(
                        '${entry.product.price.toStringAsFixed(0)} KZT x ${entry.quantity}',
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
