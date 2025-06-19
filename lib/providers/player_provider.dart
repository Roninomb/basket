import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/player.dart';

final playerListProvider = StateNotifierProvider<PlayerListNotifier, List<Player>>((ref) {
  return PlayerListNotifier();
});

class PlayerListNotifier extends StateNotifier<List<Player>> {
  PlayerListNotifier()
      : super([
          Player(name: 'LeBron James', team: 'Lakers', position: 'Alero', photoUrl: 'https://i.imgur.com/kTPWzxq.jpg'),
          Player(name: 'Stephen Curry', team: 'Warriors', position: 'Base', photoUrl: 'https://i.imgur.com/SyPSHUg.jpg'),
        ]);

  void add(Player player) => state = [...state, player];

  void update(int index, Player updatedPlayer) {
    final newList = [...state];
    newList[index] = updatedPlayer;
    state = newList;
  }
}
