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
        photoUrl: 'https://upload.wikimedia.org/wikipedia/commons/2/2f/LeBron_James_Lakers.jpg',
      ),
      Player(
        name: 'Stephen Curry',
        team: 'Golden State Warriors',
        position: 'Base',
        photoUrl: 'https://upload.wikimedia.org/wikipedia/commons/8/89/Stephen_Curry_2016.jpg',
      ),
      Player(
        name: 'Luka Dončić',
        team: 'Dallas Mavericks',
        position: 'Escolta',
        photoUrl: 'https://upload.wikimedia.org/wikipedia/commons/e/e5/Luka_Don%C4%8Di%C4%87_2021.jpg',
      ),
      Player(
        name: 'Giannis Antetokounmpo',
        team: 'Milwaukee Bucks',
        position: 'Ala-pívot',
        photoUrl: 'https://upload.wikimedia.org/wikipedia/commons/f/fd/Giannis_Antetokounmpo_2018.jpg',
      ),
      Player(
        name: 'Nikola Jokić',
        team: 'Denver Nuggets',
        position: 'Pívot',
        photoUrl: 'data:image/jpeg;base64,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',
      ),
      Player(
        name: 'Jayson Tatum',
        team: 'Boston Celtics',
        position: 'Alero',
        photoUrl: 'https://upload.wikimedia.org/wikipedia/commons/f/f0/Jayson_Tatum_2022.jpg',
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
