import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../entities/user.dart';
import '../providers/user_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController inputEmail = TextEditingController();
  final TextEditingController inputPassword = TextEditingController();

  final List<Usuario> users = [
    Usuario(email: 'roninomb@gmail.com', password: 'roni', nombre: 'Roni'),
    Usuario(email: 'esteban@gmail.com', password: 'aaaa', nombre: 'esteban'),
    Usuario(email: 'julian@gmail.com', password: 'aaaa', nombre: 'Lola'),
    Usuario(email: 'juan@gmail.com', password: 'aaaa', nombre: 'Juan'),
    Usuario(email: 'pablo@gmail.com', password: 'aaaa', nombre: 'Pablo'),
  ];

  void confirmarLogin() {
    for (var user in users) {
      if (inputEmail.text == user.email && inputPassword.text == user.password) {
        ref.read(currentUserProvider.notifier).state = user;
        context.push('/list');
        return;
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Usuario y/o contraseña incorrectos.')),
    );
  }
//.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: inputEmail,
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
              onPressed: confirmarLogin,
              child: const Text('INGRESAR'),
            ),
          ],
        ),
      ),
    );
  }
}
