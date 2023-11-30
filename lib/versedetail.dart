// verse_detail.dart

import 'package:bible/service/apiService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'models/VerseDetails.dart';

class VerseDetail extends StatelessWidget {
  final VerseDetails verse;

  const VerseDetail({
    super.key,
    required this.verse,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: LanguagePreferences.getLanguage(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  verse.reference,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: HtmlWidget(
                  verse.content,
                  textStyle: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
