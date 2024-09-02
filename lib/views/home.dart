import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void addNote() {
    final _textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Note'),
        content: TextField(
          controller: _textController,
          decoration: const InputDecoration(
            hintText: 'Enter note content',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final content = _textController.text;
              if (content.isNotEmpty) {
                context.read<NoteViewModel>().addNote(content);
                Navigator.of(context).pop(); // Close the dialog
              }
            },
            child: const Text('Add'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Consumer<NoteViewModel>(
        builder: (context, viewModel, child) {
          final notes = viewModel.notes;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return ListTile(
                title: Text(note.content),
                subtitle: Text(note.createdAt.toLocal().toString()),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => viewModel.deleteNote(note.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
