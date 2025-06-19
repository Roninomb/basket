import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/user.dart';

final currentUserProvider = StateProvider<Usuario?>((ref) => null);
