import 'package:flutter/material.dart';
import 'package:notebook/Views/update.dart';
import 'package:notebook/model/note_model.dart';
import 'package:notebook/sqflite/sqlite.dart';

class NoteDetail extends StatelessWidget {
  final NoteModel note;
  final DatabaseHelper db = DatabaseHelper();

  NoteDetail({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              db.deleteNote(note.id!).then((_) {
                Navigator.pop(context, true); // Kembali ke halaman sebelumnya setelah delete
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              note.content,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigasi ke halaman formulir untuk memperbarui catatan
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateNoteForm(note: note),
            ),
          );

          // Refresh halaman jika pembaruan berhasil
          if (result == true) {
            Navigator.pop(context, true);
          }
        },
        backgroundColor: Colors.purple,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
