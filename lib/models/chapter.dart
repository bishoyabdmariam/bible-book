// models/chapter.dart

class Chapter {
  final String id;
  final String number;

  Chapter({required this.id, required this.number});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'],
      number: json['number'],
    );
  }
}
