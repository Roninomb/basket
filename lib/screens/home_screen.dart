import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// ignore: unused_import
import '../entities/player.dart';
import '../providers/user_provider.dart';
import '../providers/player_provider.dart';
import '../providers/mode_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final players = ref.watch(playerListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Hola ${user?.nombre ?? 'Usuario'}'),
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
              onTap: () {
                ref.read(modoProvider.notifier).state = ModoFormulario.ver;
                context.push('/form', extra: {
                  'player': player,
                  'index': index,
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(modoProvider.notifier).state = ModoFormulario.agregar;
          context.push('/form');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
