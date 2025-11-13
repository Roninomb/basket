import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/services/favorite_service.dart';

final favoriteServiceProvider = Provider<FavoriteService>((ref) {
  return FavoriteService();
});

/// Notifier que maneja los IDs de jugadores favoritos para un usuario.
class FavoriteNotifier extends StateNotifier<Set<String>> {
  final FavoriteService _service;
  final String uid;

  FavoriteNotifier(this._service, this.uid) : super({}) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favorites = await _service.getFavorites(uid);
    state = favorites;
  }

  Future<void> toggleFavorite(String playerId) async {
    final current = Set<String>.from(state);
    final isFavorite = current.contains(playerId);

    if (isFavorite) {
      await _service.removeFavorite(uid, playerId);
      current.remove(playerId);
    } else {
      await _service.addFavorite(uid, playerId);
      current.add(playerId);
    }

    state = current;
  }
}

/// Provider "family" para obtener los favoritos de un usuario por uid.
final favoritePlayerIdsProvider =
    StateNotifierProvider.family<FavoriteNotifier, Set<String>, String>(
  (ref, uid) {
    final service = ref.watch(favoriteServiceProvider);
    return FavoriteNotifier(service, uid);
  },
);
