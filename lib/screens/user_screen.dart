import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_provider.dart';

class UserScreen extends ConsumerWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('No hay usuario logueado')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Cuenta"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Información de la cuenta",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // Avatar centrado
            

            const SizedBox(height: 30),

            Text(
              "Nombre: ${user.nombre}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),

            Text(
              "Email: ${user.email}",
              style: const TextStyle(fontSize: 18),
            ),

            
          ],
        ),
      ),
    );
  }
}
