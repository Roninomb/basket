import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ModoFormulario { agregar, ver, editar }

final modoProvider = StateProvider<ModoFormulario>((ref) => ModoFormulario.ver);
