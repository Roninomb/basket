import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/form_screen.dart';
// ignore: unused_import
import 'entities/player.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

// GoRouter config
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/list',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/form',
      builder: (context, state) {
        final extra = state.extra;
        if (extra is Map<String, dynamic>) {
          return FormScreen(extra: extra);
        }
        return const FormScreen(); // caso agregar
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
