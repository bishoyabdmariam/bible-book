// models/verse.dart


/*{
      "id": "GEN.2.1",
      "orgId": "GEN.2.1",
      "bookId": "GEN",
      "chapterId": "GEN.2",
      "bibleId": "b17e246951402e50-01",
      "reference": "التكوين 2:1"
    },
    */

class Verse {
  final String? id;
  final String? bookId;
  final String? chapterId;
  final String? bibleId;
  final String? reference;

  Verse({
    required this.id,
    required this.bookId,
    required this.chapterId,
    required this.bibleId,
    required this.reference,
  });

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      id: json["id"],
      bookId: json["bookId"],
      chapterId: json["chapterId"],
      bibleId: json["bibleId"],
      reference: json["reference"],
    );
  }
}
