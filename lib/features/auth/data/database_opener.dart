import 'dart:io';

import 'package:drift/native.dart';
import 'package:madivizion_jdonuts_app/features/auth/data/app_database.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

/// Opens the on-device database file.
Future<AppDatabase> openAppDatabase() async {
  final directory = await getApplicationSupportDirectory();
  final file = File(path.join(directory.path, 'jdonuts.sqlite'));
  return AppDatabase(NativeDatabase.createInBackground(file));
}
