import 'package:isar/isar.dart';

part 'note.g.dart'; // Generated file

@Collection()
class Note {
  Id id = Isar.autoIncrement; // Unique ID for each note

  late String content;
  late DateTime createdAt;
}
