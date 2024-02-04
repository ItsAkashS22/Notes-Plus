// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NoteModel {
  final String id;
  final String uid;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool pinned;
  final bool isDeleted;

  NoteModel({
    required this.id,
    required this.uid,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.pinned,
    required this.isDeleted,
  });

  static const String tableName = 'notes';

  static const String createQuery = '''
    CREATE TABLE notes (
      id TEXT PRIMARY KEY,
      uid TEXT NOT NULL,
      title TEXT NOT NULL,
      content TEXT NOT NULL,
      createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
      updatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
      pinned BOOLEAN NOT NULL DEFAULT 0,
      isDeleted BOOLEAN NOT NULL DEFAULT 0,
      toBeSynced BOOLEAN NOT NULL DEFAULT 1
    )
    ''';

  NoteModel copyWith({
    String? id,
    String? uid,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? pinned,
    bool? isDeleted,
  }) {
    return NoteModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      pinned: pinned ?? this.pinned,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'title': title,
      'content': content,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'pinned': pinned,
      'isDeleted': isDeleted,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] as String,
      uid: map['uid'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      pinned: map['pinned'] == 1 || map['pinned'] == true,
      isDeleted: map['isDeleted'] == 1 || map['isDeleted'] == true,
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NoteModel(id: $id, uid: $uid, title: $title, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, pinned: $pinned, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(covariant NoteModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.uid == uid &&
        other.title == title &&
        other.content == content &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.pinned == pinned &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        title.hashCode ^
        content.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        pinned.hashCode ^
        isDeleted.hashCode;
  }
}
