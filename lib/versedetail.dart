// verse_detail.dart

import 'package:flutter/material.dart';

import 'models/VerseDetails.dart';
import 'models/verse.dart';

class VerseDetail extends StatelessWidget {
  final VerseDetails verse;

  const VerseDetail({super.key, required this.verse});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            verse.reference,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(verse.content),
        ),
      ],
    );
  }
}
