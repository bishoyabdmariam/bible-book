// models/verse.dart

class Verse {
  final String? id;
  final String? number;
  final String? text;
  final String? bookId;
  final String? chapterId;
  final String? bibleId;
  final String? reference;

  Verse({
    required this.id,
    required this.number,
    required this.text,
    required this.bookId,
    required this.chapterId,
    required this.bibleId,
    required this.reference,
  });

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      id: json["id"],
      number: json["number"],
      text: json["text"],
      bookId: json["bookId"],
      chapterId: json["chapterId"],
      bibleId: json["bibleId"],
      reference: json["reference"],
    );
  }
}
