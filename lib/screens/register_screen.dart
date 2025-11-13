import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    nombreController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _registrar() async {
    final nombre = nombreController.text.trim();
    final email = emailController.text.trim();
    final pass = passwordController.text.trim();
    final pass2 = confirmPasswordController.text.trim();

    if (nombre.isEmpty || email.isEmpty || pass.isEmpty || pass2.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completá todos los campos.')),
      );
      return;
    }

    if (pass != pass2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final cred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);

      // Guardar el nombre en Firebase Auth
      await cred.user!.updateDisplayName(nombre);
      // Refrescar datos en FirebaseAuth
      await FirebaseAuth.instance.currentUser?.reload();

      if (!mounted) return;
      // Usuario ya logueado -> ir a la lista
      context.go('/list');
    } on FirebaseAuthException catch (e) {
      String mensaje = 'Error al registrarse.';

      if (e.code == 'email-already-in-use') {
        mensaje = 'Ya existe una cuenta con ese email.';
      } else if (e.code == 'weak-password') {
        mensaje = 'La contraseña es muy débil.';
      } else if (e.code == 'invalid-email') {
        mensaje = 'Email inválido.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensaje)),
      );
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error desconocido al registrarse.')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(
                  hintText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Confirmar contraseña',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _registrar,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('REGISTRARME'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Ya tengo cuenta, volver al login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
