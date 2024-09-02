import 'package:isar/isar.dart';
import 'package:isar_flutter_libs/isar_flutter_libs.dart'; // For Flutter
import 'package:path_provider/path_provider.dart';
import '../models/note.dart';

class IsarService {
  static late final Isar _instance;

  // Initialize database
  static Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    _instance = await Isar.open(
      [NoteSchema],
      directory: directory.path,
    );
  }

  static Isar get instance => _instance;
}
