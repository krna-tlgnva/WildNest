import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MarketplaceBottomBar extends StatelessWidget {
  const MarketplaceBottomBar({
    required this.currentIndex,
    required this.cartItemsCount,
    super.key,
  });

  final int currentIndex;
  final int cartItemsCount;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: (index) {
        if (index == 0) {
          context.go('/');
        }
        if (index == 1) {
          context.go('/cart');
        }
        if (index == 2) {
          context.go('/profile');
        }
      },
      destinations: <Widget>[
        const NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Badge(
            isLabelVisible: cartItemsCount > 0,
            label: Text('$cartItemsCount'),
            child: const Icon(Icons.shopping_cart_outlined),
          ),
          selectedIcon: Badge(
            isLabelVisible: cartItemsCount > 0,
            label: Text('$cartItemsCount'),
            child: const Icon(Icons.shopping_cart),
          ),
          label: 'Cart',
        ),
        const NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
