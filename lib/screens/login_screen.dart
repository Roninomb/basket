import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../entities/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController inputEmail = TextEditingController();
  final TextEditingController inputPassword = TextEditingController();

  final List<Usuario> users = [
    Usuario(email: 'roninomb@gmail.com', password: 'roni', nombre: 'Roni',),
    Usuario(email: 'esteban@gmail.com', password: '1234', nombre: 'esteban', ),
    Usuario(email: 'julian@gmail.com', password: 'abcd', nombre: 'Lola', ),
    Usuario(email: 'juan@gmail.com', password: 'pass123', nombre: 'Juan', ),
    Usuario(email: 'pablo@gmail.com', password: 'basket', nombre: 'Pablo', ),
  ];

  void confirmarLogin() {
    for (var user in users) {
      if (inputEmail.text == user.email && inputPassword.text == user.password) {
        context.push('/home', extra: user);
        return;
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Usuario y/o contraseña incorrectos.')),
    );
  }

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
