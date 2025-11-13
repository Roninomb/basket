import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Devuelve el conjunto de IDs de jugadores favoritos para este usuario.
  Future<Set<String>> getFavorites(String uid) async {
    try {
      final doc = await _db.collection('userFavorites').doc(uid).get();
      if (!doc.exists) return {};

      final data = doc.data();
      final List<dynamic> rawIds = (data?['playerIds'] ?? []) as List<dynamic>;
      return rawIds.whereType<String>().toSet();
    } catch (e) {
      print('Error al obtener favoritos: $e');
      return {};
    }
  }

  Future<void> addFavorite(String uid, String playerId) async {
    try {
      await _db.collection('userFavorites').doc(uid).set(
        {
          'playerIds': FieldValue.arrayUnion([playerId]),
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      print('Error al agregar favorito: $e');
    }
  }

  Future<void> removeFavorite(String uid, String playerId) async {
    try {
      await _db.collection('userFavorites').doc(uid).set(
        {
          'playerIds': FieldValue.arrayRemove([playerId]),
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      print('Error al eliminar favorito: $e');
    }
  }
}
