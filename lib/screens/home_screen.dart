import 'package:flutter/material.dart';
import '../entities/player.dart';
import '../entities/user.dart';

class HomeScreen extends StatelessWidget {
  final Usuario user;

  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final List<Player> players = [
      Player(
        name: 'LeBron James',
        team: 'Los Angeles Lakers',
        position: 'Alero',
        photoUrl: 'https://i.imgur.com/kTPWzxq.jpg',
      ),
      Player(
        name: 'Stephen Curry',
        team: 'Golden State Warriors',
        position: 'Base',
        photoUrl: 'https://i.imgur.com/SyPSHUg.jpg',
      ),
      Player(
        name: 'Luka Dončić',
        team: 'Dallas Mavericks',
        position: 'Escolta',
        photoUrl: 'https://i.imgur.com/gH9HKv0.jpg',
      ),
      Player(
        name: 'Giannis Antetokounmpo',
        team: 'Milwaukee Bucks',
        position: 'Ala-pívot',
        photoUrl: 'https://i.imgur.com/n6TjXnK.jpg',
      ),
      Player(
        name: 'Nikola Jokić',
        team: 'Denver Nuggets',
        position: 'Pívot',
        photoUrl: 'https://i.imgur.com/4z1b14e.jpg',
      ),
      Player(
        name: 'Jayson Tatum',
        team: 'Boston Celtics',
        position: 'Alero',
        photoUrl: 'https://i.imgur.com/TpFCZnI.jpg',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Hola ${user.nombre}'),
      ),
      body: ListView.builder(
        itemCount: players.length,
        itemBuilder: (context, index) {
          final player = players[index];
          return Card(
            child: ListTile(
              leading: Image.network(
                player.photoUrl,
                width: 50,
                height: 75,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.person, size: 50),
              ),
              title: Text(player.name),
              subtitle: Text('${player.team} - ${player.position}'),
            ),
          );
        },
      ),
    );
  }
}
