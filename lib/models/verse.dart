class Verse {
  final int id;
  final int number;
  final String text;

  Verse({required this.id, required this.number, required this.text});

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      id: json['id'],
      number: json['number'],
      text: json['text'],
    );
  }
}
