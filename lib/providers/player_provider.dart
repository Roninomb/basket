import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/services/player_service.dart';
import '../entities/player.dart';

// Provider for the selected player
final selectedPlayerProvider = StateProvider<Player?>((ref) => null);

final playerServiceProvider = Provider((ref) => PlayerService());

final playerListProvider = StateNotifierProvider<PlayerListNotifier, List<Player>>((ref) {
  final playerService = ref.watch(playerServiceProvider);
  return PlayerListNotifier(playerService);
});

class PlayerListNotifier extends StateNotifier<List<Player>> {
  final PlayerService _playerService;

  PlayerListNotifier(this._playerService) : super([]) {
    _fetchPlayers();
  }

  Future<void> _fetchPlayers() async {
    state = await _playerService.getPlayers();
  }

  Future<void> add(Player player) async {
    final newPlayer = await _playerService.addPlayer(player);
    state = [...state, player.copyWith(id: newPlayer.id)];
  }

  Future<void> update(Player updatedPlayer) async {
    await _playerService.updatePlayer(updatedPlayer);
    state = [
      for (final player in state)
        if (player.id == updatedPlayer.id) updatedPlayer else player,
    ];
  }

  Future<void> remove(Player player) async {
    await _playerService.removePlayer(player);
    state = state.where((p) => p.id != player.id).toList();
  }
}
