import 'package:flutter/material.dart';
import 'package:lingxi_ai_app/app/presentation/pages/not_found_page.dart';
import 'package:lingxi_ai_app/app/router/app_routes.dart';
import 'package:lingxi_ai_app/features/auth/presentation/pages/loginPage.dart';
import 'package:lingxi_ai_app/features/cart/presentation/pages/cartPage.dart';
import 'package:lingxi_ai_app/features/home/presentation/pages/mainTabPage.dart';
import 'package:lingxi_ai_app/features/product/presentation/pages/productDetailPage.dart';
import 'package:lingxi_ai_app/features/product/presentation/pages/productListPage.dart';
import 'package:lingxi_ai_app/features/profile/presentation/pages/profilePage.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage(), settings: settings);
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const MainTabPage(), settings: settings);
      case AppRoutes.productList:
        return MaterialPageRoute(builder: (_) => const ProductListPage(), settings: settings);
      case AppRoutes.productDetail:
        final args = settings.arguments;
        final productId = args is String ? args : null;
        return MaterialPageRoute(
          builder: (_) => ProductDetailPage(productId: productId),
          settings: settings,
        );
      case AppRoutes.cart:
        return MaterialPageRoute(builder: (_) => const CartPage(), settings: settings);
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage(), settings: settings);
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundPage(), settings: settings);
    }
  }
}
