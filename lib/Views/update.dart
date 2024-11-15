import 'package:flutter/material.dart';
import 'package:notebook/model/note_model.dart';
import 'package:notebook/sqflite/sqlite.dart';

class UpdateNoteForm extends StatefulWidget {
  final NoteModel note;

  const UpdateNoteForm({super.key, required this.note});

  @override
  _UpdateNoteFormState createState() => _UpdateNoteFormState();
}

class _UpdateNoteFormState extends State<UpdateNoteForm> {
  final DatabaseHelper db = DatabaseHelper();
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    contentController = TextEditingController(text: widget.note.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Note'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                db.updateNote(
                  titleController.text,
                  contentController.text,
                  widget.note.id ?? 0,
                ).then((_) {
                  Navigator.pop(context, true); // Kembali dengan true jika berhasil
                });
              },
              child: const Text('Update Note'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
