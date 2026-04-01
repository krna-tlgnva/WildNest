import 'package:flutter/material.dart';

import '../main.dart';
import '../widgets/marketplace_bottom_bar.dart';
import '../widgets/product_image.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({required this.shopState, super.key});

  final ShopState shopState;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shopState,
      builder: (context, _) {
        final items = shopState.cartEntries;

        return Scaffold(
          appBar: AppBar(title: const Text('Cart')),
          bottomNavigationBar: MarketplaceBottomBar(
            currentIndex: 1,
            cartItemsCount: shopState.cartItemsCount,
          ),
          body: items.isEmpty
              ? const Center(child: Text('Your cart is empty'))
              : Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final entry = items[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(12),
                              leading: SizedBox(
                                width: 60,
                                height: 60,
                                child: ProductImage(
                                  imageUrl: entry.product.imageUrl,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              title: Text(entry.product.title),
                              subtitle: Text(
                                '${entry.product.price.toStringAsFixed(0)} KZT x ${entry.quantity}',
                              ),
                              trailing: IconButton(
                                onPressed: () =>
                                    shopState.removeFromCart(entry.product.id),
                                icon: const Icon(Icons.delete_outline),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Total: ${shopState.totalPrice.toStringAsFixed(0)} KZT',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Checkout'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
