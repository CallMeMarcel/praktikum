class NoteModel {
  int? id;  // Ubah 'noteId' menjadi 'id'
  String title;
  String content;
  String createdTime;

  NoteModel({
    this.id,
    required this.title,
    required this.content,
    required this.createdTime,
  });

  // Convert from Map to NoteModel
  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],  // Ubah 'noteId' menjadi 'id'
      title: map['title'],
      content: map['content'],
      createdTime: map['createdTime'],
    );
  }

  // Convert from NoteModel to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,  // Ubah 'noteId' menjadi 'id'
      'title': title,
      'content': content,
      'createdTime': createdTime,
    };
  }
}
