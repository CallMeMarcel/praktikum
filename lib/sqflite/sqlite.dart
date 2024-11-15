import 'package:notebook/model/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final String databaseName = "notes.db";
  final String noteTable = """
  CREATE TABLE notes (
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    title TEXT NOT NULL, 
    content TEXT NOT NULL, 
    createdTime TEXT NOT NULL
  );
  """;

  // Inisialisasi database
  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      // Membuat tabel baru jika database tidak ada
      await db.execute(noteTable);
    });
  }

  // Fungsi untuk membuat catatan baru
  Future<int> createNote(NoteModel note) async {
    final db = await initDB();
    print("Inserting note: ${note.toMap()}");
    return await db.insert('notes', note.toMap());
  }

  // Fungsi untuk mendapatkan semua catatan
  Future<List<NoteModel>> getNotes() async {
    final db = await initDB();
    final List<Map<String, dynamic>> result = await db.query('notes');
    return result.map((e) => NoteModel.fromMap(e)).toList();
  }

  // Fungsi untuk menghapus catatan berdasarkan ID
  Future<int> deleteNote(int id) async {
    final db = await initDB();
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  // Fungsi untuk memperbarui catatan berdasarkan ID
  Future<int> updateNote(String title, String content, int id) async {
    final db = await initDB();
    print("Updating note: ID=$id, Title=$title, Content=$content");
    return await db.update(
      'notes',
      {
        'title': title,
        'content': content,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
