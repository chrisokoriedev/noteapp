const String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    id, isImportant, number, title, description, time
  ];

  static const String id = '_id';
  static const String isImportant = 'isImportant';
  static const String number = 'number';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';
}

class NoteSearch {
  final int id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;

  const NoteSearch({
    required this.id,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  factory NoteSearch.fromJson(Map<String, dynamic> json) {
    return NoteSearch(
      id: json[NoteFields.id] as int,
      isImportant: json[NoteFields.isImportant] == 1,
      number: json[NoteFields.number] as int,
      title: json[NoteFields.title] as String,
      description: json[NoteFields.description] as String,
      createdTime: DateTime.parse(json[NoteFields.time] as String),
    );
  }
}

class Note {
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;

  const Note({
    this.id,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  Note copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        isImportant: json[NoteFields.isImportant] == 1,
        number: json[NoteFields.number] as int,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.isImportant: isImportant ? 1 : 0,
        NoteFields.number: number,
        NoteFields.description: description,
        NoteFields.time: createdTime.toIso8601String(),
      };
}

// class SearchMain {
//   late final int id;
//   late final bool isImportant;
//   late final int number;
//   late final String title;
//   late final String description;
//   late final DateTime createdTime;
//
//   SearchMain(
//       {required this.id, required this.isImportant, required this.number, required this.title, required this.description, required this.createdTime});
//
//
//   SearchMain.fromMap(dynamic obj) {
//     id = obj['id'];
//     isImportant = obj['isImportant'];
//     number = obj['number'];
//     title = obj['title'];
//     description = obj['description'];
//     createdTime = obj['createdTime'];
//   }
//
//   Map<String, dynamic> toMap() {
//     var map = <String, dynamic>{
//       'id': id,
//       'contactSurname': isImportant,
//       'number': number,
//       'title': title,
//       'description': description,
//       'createdTime': createdTime,
//     };
//
//     return map;
//   }
// }

// class SearchNote {
//   int _id;
//   bool _isImportant;
//   int _number;
//   String _title;
//   String _description;
//   DateTime _createdTime;
//
//   SearchNote(this._id, this._isImportant, this._number, this._title,
//       this._description, this._createdTime);
//
//   int get id => _id;
//
//   bool get isImportant => _isImportant;
//
//   int get number => _number;
//
//   String get title => _title;
//
//   String get description => _description;
//
//   DateTime get createdTime => _createdTime;
//
//   SearchNote.fromMapObject(
//       Map<String, dynamic> map,
//       this._id,
//       this._isImportant,
//       this._number,
//       this._title,
//       this._description,
//       this._createdTime) {
//     _id = map['id'];
//     _isImportant = map['isImportant'];
//     _number = map['number'];
//     _title = map['title'];
//     _description = map['description'];
//     _createdTime = map['createdTime'];
//   }
// }
//
// class Drink {
//   int id;
//   bool isImportant;
//   String number;
//   String title;
//   String des;
//   DateTime time;
//
//   Drink(
//       {required this.id,
//       required this.isImportant,
//       required this.number,
//       required this.title,
//       required this.des,
//       required this.time});
//
//   factory Drink.fromJson(Map<String, dynamic> json) {
//     return Drink(
//       id: json['id'],
//       isImportant: json['isImportant'],
//       number: json['number'],
//       title: json['title'],
//       des: json['description'],
//       time: json['createdTime'],
//     );
//   }
// }
