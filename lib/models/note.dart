class Note {
  int? id;
  String content;
  String createdAt;

  Note({
    this.id,
    required this.content,
    required this.createdAt,
  });

  // Конвертація об'єкта в Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'createdAt': createdAt,
    };
  }

  // Створення об'єкта з Map
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      content: map['content'],
      createdAt: map['createdAt'],
    );
  }
}
