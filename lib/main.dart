import 'package:flutter/material.dart';

import 'app_router.dart';
import 'data/mock_products.dart';
import 'models/product.dart';

void main() {
  runApp(const InteractiveNavigationApp());
}

class InteractiveNavigationApp extends StatefulWidget {
  const InteractiveNavigationApp({super.key});

  @override
  State<InteractiveNavigationApp> createState() =>
      _InteractiveNavigationAppState();
}

class _InteractiveNavigationAppState extends State<InteractiveNavigationApp> {
  late final ShopState _shopState;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _shopState = ShopState(products: mockProducts);
    _appRouter = AppRouter(shopState: _shopState);
  }

  @override
  void dispose() {
    _appRouter.dispose();
    _shopState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shopState,
      builder: (context, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Shop app',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF8F2BFF),
            ),
            scaffoldBackgroundColor: const Color(0xFFF7F5FA),
          ),
          routerConfig: _appRouter.router,
        );
      },
    );
  }
}

class ShopState extends ChangeNotifier {
  ShopState({required List<Product> products}) : _products = products;

  final List<Product> _products;
  final Set<int> _favoriteIds = <int>{};
  final Map<int, int> _cartItems = <int, int>{};

  List<Product> get products => List<Product>.unmodifiable(_products);

  List<Product> get favoriteProducts {
    return _products.where((item) => _favoriteIds.contains(item.id)).toList();
  }

  List<CartEntry> get cartEntries {
    return _cartItems.entries.map((entry) {
      return CartEntry(
        product: getProductById(entry.key)!,
        quantity: entry.value,
      );
    }).toList();
  }

  int get cartItemsCount {
    return _cartItems.values.fold(0, (sum, value) => sum + value);
  }

  double get totalPrice {
    return cartEntries.fold(0, (sum, item) {
      return sum + item.product.price * item.quantity;
    });
  }

  bool isFavorite(int id) => _favoriteIds.contains(id);

  bool isInCart(int id) => _cartItems.containsKey(id);

  Product? getProductById(int id) {
    for (final product in _products) {
      if (product.id == id) {
        return product;
      }
    }
    return null;
  }

  void toggleFavorite(int id) {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    notifyListeners();
  }

  void addToCart(int id) {
    _cartItems.update(id, (count) => count + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  void removeFromCart(int id) {
    _cartItems.remove(id);
    notifyListeners();
  }
}

class CartEntry {
  const CartEntry({required this.product, required this.quantity});

  final Product product;
  final int quantity;
}
