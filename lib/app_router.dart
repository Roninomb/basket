import 'package:go_router/go_router.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/form_screen.dart';
import 'screens/register_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/user_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/list',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesScreen(),
    ),
    GoRoute(
      path: '/user',
      builder: (context, state) => const UserScreen(),
    ),
    GoRoute(
      path: '/form',
      builder: (context, state) => const FormScreen(),
    ),
  ],
);
