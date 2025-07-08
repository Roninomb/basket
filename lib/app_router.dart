// lib/app_router.dart
// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/form_screen.dart';

final appRouter = GoRouter(
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
