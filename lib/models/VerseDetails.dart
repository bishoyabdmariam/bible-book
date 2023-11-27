class VerseDetails {
  final String content;
  final String reference;



  VerseDetails({required this.content, required this.reference,});

  factory VerseDetails.fromJson(Map<String, dynamic> json) {
    return VerseDetails(
      content: json["content"],
      reference: json["reference"],
    );
  }

}
