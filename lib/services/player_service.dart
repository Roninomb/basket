import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/entities/player.dart';

class PlayerService {
  late final CollectionReference<Player> _playersRef;

  PlayerService() {
    _playersRef = FirebaseFirestore.instance.collection('Players').withConverter<Player>(
          fromFirestore: (snapshot, _) => Player.fromMap(snapshot.data()!, snapshot.id),
          toFirestore: (player, _) => player.toMap(),
        );
  }

  Future<List<Player>> getPlayers() async {
    try {
      final snapshot = await _playersRef.get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error fetching players: $e');
      return [];
    }
  }

  Future<DocumentReference> addPlayer(Player player) async {
    try {
      return await _playersRef.add(player);
    } catch (e) {
      print('Error adding player: $e');
      rethrow;
    }
  }

  Future<void> updatePlayer(Player player) async {
    try {
      await _playersRef.doc(player.id).update(player.toMap());
    } catch (e) {
      print('Error updating player: $e');
    }
  }

    Future<void> removePlayer(Player player) async {
    try {
      await _playersRef.doc(player.id).delete();
    } catch (e) {
      print('Error deleting player: $e');
    }
  }
}
