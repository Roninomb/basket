import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/user_provider.dart';
import '../providers/player_provider.dart';
import '../providers/mode_provider.dart';
import '../providers/favorite_provider.dart';
import '../entities/player.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final players = ref.watch(playerListProvider);

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('No hay usuario logueado')),
      );
    }

    final favoritesIds = ref.watch(favoritePlayerIdsProvider(user.uid));

    final favoritePlayers = players
        .where((p) => p.id != null && favoritesIds.contains(p.id!))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis favoritos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: favoritePlayers.isEmpty
          ? const Center(
              child: Text('Todavía no tenés jugadores favoritos.'),
            )
          : ListView.builder(
              itemCount: favoritePlayers.length,
              itemBuilder: (context, index) {
                final player = favoritePlayers[index];
                final playerId = player.id!;
                final isFavorite = favoritesIds.contains(playerId);

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
                    trailing: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.star : Icons.star_border,
                      ),
                      color: isFavorite ? Colors.amber : null,
                      onPressed: () {
                        ref
                            .read(
                              favoritePlayerIdsProvider(user.uid).notifier,
                            )
                            .toggleFavorite(playerId);
                      },
                    ),
                    onTap: () {
                      ref.read(modoProvider.notifier).state =
                          ModoFormulario.ver;
                      ref.read(selectedPlayerProvider.notifier).state = player;
                      context.push('/form');
                    },
                  ),
                );
              },
            ),
    );
  }
}
