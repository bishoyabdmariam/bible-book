class BibleVersion {
  final String? name;
  final String? id;
  final String? description;
  final String? scriptDirection;
  final Map<String, dynamic>? language;

  BibleVersion({
    required this.name,
    required this.id,
    required this.description,
    required this.language,
    required this.scriptDirection,
  });

  static BibleVersion fromJson(Map<String, dynamic> json) {
    return BibleVersion(
      scriptDirection: json['scriptDirection'],
      name: json['name'],
      id: json['id'],
      description: json['description'],
      language: (json['language'] as Map<String, dynamic>?),
    );
  }
}
