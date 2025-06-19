import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/mode_provider.dart';
import '../providers/player_provider.dart';
import '../entities/player.dart';
import 'package:go_router/go_router.dart';

class FormScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic>? extra;

  const FormScreen({super.key, this.extra});

  @override
  ConsumerState<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends ConsumerState<FormScreen> {
  late final TextEditingController nameController;
  late final TextEditingController teamController;
  late final TextEditingController positionController;
  late final TextEditingController photoUrlController;

  int? index;

  @override
  void initState() {
    super.initState();
    final player = widget.extra?['player'] as Player?;
    index = widget.extra?['index'] as int?;
    nameController = TextEditingController(text: player?.name);
    teamController = TextEditingController(text: player?.team);
    positionController = TextEditingController(text: player?.position);
    photoUrlController = TextEditingController(text: player?.photoUrl);
  }

  @override
  Widget build(BuildContext context) {
    final modo = ref.watch(modoProvider);

    final isEditable = modo == ModoFormulario.agregar || modo == ModoFormulario.editar;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          modo == ModoFormulario.agregar
              ? 'Agregar jugador'
              : modo == ModoFormulario.ver
                  ? 'Ver jugador'
                  : 'Editar jugador',
        ),
        actions: [
          if (modo == ModoFormulario.ver)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                ref.read(modoProvider.notifier).state = ModoFormulario.editar;
                setState(() {}); // refresca el modo
              },
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
              enabled: isEditable,
            ),
            TextField(
              controller: teamController,
              decoration: const InputDecoration(labelText: 'Equipo'),
              enabled: isEditable,
            ),
            TextField(
              controller: positionController,
              decoration: const InputDecoration(labelText: 'Posición'),
              enabled: isEditable,
            ),
            TextField(
              controller: photoUrlController,
              decoration: const InputDecoration(labelText: 'URL de foto'),
              enabled: isEditable,
            ),
            const SizedBox(height: 20),
            if (isEditable)
              ElevatedButton(
                onPressed: () {
                  final newPlayer = Player(
                    name: nameController.text,
                    team: teamController.text,
                    position: positionController.text,
                    photoUrl: photoUrlController.text,
                  );

                  if (modo == ModoFormulario.agregar) {
                    ref.read(playerListProvider.notifier).add(newPlayer);
                  } else if (modo == ModoFormulario.editar && index != null) {
                    ref.read(playerListProvider.notifier).update(index!, newPlayer);
                  }

                  context.pop();
                },
                child: const Text('Guardar'),
              )
          ],
        ),
      ),
    );
  }
}
