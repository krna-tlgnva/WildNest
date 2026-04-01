import 'package:go_router/go_router.dart';

import 'main.dart';
import 'screens/cart_screen.dart';
import 'screens/error_screen.dart';
import 'screens/home_screen.dart';
import 'screens/product_details_screen.dart';
import 'screens/profile_screen.dart';

class AppRouter {
  AppRouter({required ShopState shopState})
    : router = GoRouter(
        initialLocation: '/',
        refreshListenable: shopState,
        routes: <RouteBase>[
          GoRoute(
            path: '/',
            builder: (context, state) => HomeScreen(shopState: shopState),
          ),
          GoRoute(
            path: '/product/:id',
            builder: (context, state) {
              final id = int.tryParse(state.pathParameters['id'] ?? '');
              if (id == null) {
                return const ErrorScreen(
                  message: 'Product id is missing or invalid.',
                );
              }

              return ProductDetailsScreen(productId: id, shopState: shopState);
            },
          ),
          GoRoute(
            path: '/cart',
            builder: (context, state) => CartScreen(shopState: shopState),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => ProfileScreen(shopState: shopState),
          ),
        ],
        errorBuilder: (context, state) =>
            ErrorScreen(message: state.error?.toString() ?? 'Page not found.'),
      );

  final GoRouter router;

  void dispose() {
    router.dispose();
  }
}
