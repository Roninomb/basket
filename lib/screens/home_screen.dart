import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/user_provider.dart';
import '../providers/player_provider.dart';
import '../providers/mode_provider.dart';
import '../providers/favorite_provider.dart';
import '../entities/player.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

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

    return Scaffold(
      appBar: AppBar(
        title: Text('Hola ${user.nombre}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            tooltip: 'Ver favoritos',
            onPressed: () {
              context.push('/favorites');
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Mi Perfil',
            onPressed: () {
              context.push('/user');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                context.go('/');
              }
            },
          ),
        ],
      ),
      body: _buildPlayerList(
        context: context,
        ref: ref,
        players: players,
        favoritesIds: favoritesIds,
        userUid: user.uid,
        showOnlyFavorites: false, // TODOS
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(modoProvider.notifier).state = ModoFormulario.agregar;
          ref.read(selectedPlayerProvider.notifier).state = null;
          context.push('/form');
        },
        child: const Icon(
          Icons.add,
          size: 50,
        ),
      ),
    );
  }

  Widget _buildPlayerList({
    required BuildContext context,
    required WidgetRef ref,
    required List<Player> players,
    required Set<String> favoritesIds,
    required String userUid,
    required bool showOnlyFavorites,
  }) {
    final filteredPlayers = showOnlyFavorites
        ? players.where((p) => p.id != null && favoritesIds.contains(p.id!)).toList()
        : players;

    if (filteredPlayers.isEmpty) {
      return const Center(
        child: Text('No hay jugadores aún.'),
      );
    }

    return ListView.builder(
      itemCount: filteredPlayers.length,
      itemBuilder: (context, index) {
        final player = filteredPlayers[index];
        final playerId = player.id;

        final isFavorite =
            playerId != null && favoritesIds.contains(playerId);

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
              onPressed: playerId == null
                  ? null
                  : () {
                      ref
                          .read(favoritePlayerIdsProvider(userUid).notifier)
                          .toggleFavorite(playerId);
                    },
            ),
            onTap: () {
              ref.read(modoProvider.notifier).state = ModoFormulario.ver;
              ref.read(selectedPlayerProvider.notifier).state = player;
              context.push('/form');
            },
          ),
        );
      },
    );
  }
}
