import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../providers/user_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController inputEmail = TextEditingController();
  final TextEditingController inputPassword = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    inputEmail.dispose();
    inputPassword.dispose();
    super.dispose();
  }

  Future<void> confirmarLogin() async {
    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: inputEmail.text.trim(),
        password: inputPassword.text.trim(),
      );

      if (!mounted) return;
      context.go('/list');
    } on FirebaseAuthException catch (e) {
      String mensaje = 'Error al iniciar sesión.';

      if (e.code == 'user-not-found') {
        mensaje = 'No existe un usuario con ese email.';
      } else if (e.code == 'wrong-password') {
        mensaje = 'Contraseña incorrecta.';
      } else if (e.code == 'invalid-email') {
        mensaje = 'Email inválido.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensaje)),
      );
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error desconocido al iniciar sesión.')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Si ya hay usuario logueado, mandarlo directo a /list
    final currentUser = ref.watch(currentUserProvider);
    if (currentUser != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.go('/list');
        }
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: inputEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: inputPassword,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : confirmarLogin,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('INGRESAR'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => context.push('/register'),
              child: const Text('¿No tenés cuenta? Registrate'),
            ),
          ],
        ),
      ),
    );
  }
}
