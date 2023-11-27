class BibleVersion {
  final String? name;
  final String? id;
  final String? abbreviation;
  final String? description;
  final String? language;

  BibleVersion({
    required this.name,
    required this.id,
    required this.abbreviation,
    required this.description,
    required this.language,
  });

  static BibleVersion fromJson(Map<String, dynamic> json) {
    return BibleVersion(
      name: json['name'],
      id: json['id'],
      abbreviation: json['abbreviation'],
      description: json['description'],
      language: json['language']['name'],
    );
  }

}
