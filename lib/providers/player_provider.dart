import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/player.dart';

final playerListProvider = StateNotifierProvider<PlayerListNotifier, List<Player>>((ref) {
  return PlayerListNotifier();
});

class PlayerListNotifier extends StateNotifier<List<Player>> {
  PlayerListNotifier()
      : super([
          Player(name: 'Lebron James', team: 'Lakers', position: 'Alero', photoUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzvG-yBH-73rXt9aWWQJN1G161fo5b1W-8ng&s'),
          Player(name: 'Stephen Curry', team: 'Warriors', position: 'Base', photoUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRg8RTJce8ySVsLYTlqBVyPEJPovPL5yGk3ow&s',
        ),
         Player(name: 'Shai Gilgeous-Alexander', team: 'Oklahoma', position: 'Base', photoUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvftlZiWxWowM1c_trzJCMkXj4u11WUJ_Rnw&s'),]);

  void add(Player player) => state = [...state, player];

  void update(int index, Player updatedPlayer) {
    final newList = [...state];
    newList[index] = updatedPlayer;
    state = newList;
  }
  void remove(int index, Player removedPlayer) {
    final newList = [...state];
    newList.removeAt(index);
    state = newList;
  }
}
