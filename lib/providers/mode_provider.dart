import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ModoFormulario { agregar, ver, editar, sacar }

final modoProvider = StateProvider<ModoFormulario>((ref) => ModoFormulario.ver);
