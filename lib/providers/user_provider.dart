import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../entities/user.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

/// Stream con el usuario de Firebase (User?).
final authStateChangesProvider = StreamProvider<User?>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return auth.authStateChanges();
});

/// Usuario de tu app, derivado del User de Firebase.
final currentUserProvider = Provider<Usuario?>((ref) {
  final authState = ref.watch(authStateChangesProvider);

  return authState.when(
    data: (user) {
      if (user == null) return null;

      return Usuario(
        uid: user.uid,
        email: user.email ?? '',
        nombre: user.displayName ?? 'Usuario',
      );
    },
    loading: () => null,
    error: (_, __) => null,
  );
});
