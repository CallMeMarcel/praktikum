import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notebook/model/note_model.dart';
import 'package:notebook/sqflite/sqlite.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final title = TextEditingController();
  final content = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final db = DatabaseHelper();
  String? selectedEmoji;

  String get currentDateTime {
    final now = DateTime.now();
    final dateFormat = DateFormat('EEEE, dd MMMM yyyy HH:mm:ss');
    return dateFormat.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create note"),
        backgroundColor: Colors.purple, 
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: title,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Judul is required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Judul",
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: content,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Catatan is required";
                    }
                    return null;
                  },
                  maxLines: 5, // Membuat kotak catatan lebih besar
                  decoration: const InputDecoration(
                    labelText: "Catatan",
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    db.createNote(NoteModel(
                      title: title.text, // Sesuaikan dengan nama kolom 'title'
                      content: content.text, // Sesuaikan dengan nama kolom 'content'
                      createdTime: DateTime.now().toIso8601String(), // Sesuaikan dengan nama kolom 'createdTime'
                    )).then((_) {
                      Navigator.of(context).pop(true);
                    }).catchError((error) {
                      print("Error creating note: $error");
                    });
                  }
                },
                child: const Text('Simpan'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
