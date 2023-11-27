// models/section.dart

class Section {
  final String id;
  final String title;

  Section({required this.id, required this.title});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      title: json['title'],
    );
  }
}
