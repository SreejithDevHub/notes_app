import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import '../models/note.dart';
import '../service/isar_service.dart';

class NoteViewModel extends ChangeNotifier {
  final Isar _isar = IsarService.instance;
  List<Note> _notes = [];

  NoteViewModel() {
    _loadNotes();
  }

  List<Note> get notes => _notes;

  Future<void> _loadNotes() async {
    try {
      _notes = await _isar.notes.where().findAll();
      notifyListeners();
    } catch (e) {
      print('Error loading notes: $e');
    }
  }

  Future<void> addNote(String content) async {
    final note = Note()
      ..content = content
      ..createdAt = DateTime.now();

    try {
      await _isar.writeTxn(() async {
        await _isar.notes.put(note);
      });
      await _loadNotes();
    } catch (e) {
      print('Error adding note: $e');
    }
  }

  Future<void> deleteNote(Id id) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.notes.delete(id);
      });
      await _loadNotes();
    } catch (e) {
      print('Error deleting note: $e');
    }
  }
}
