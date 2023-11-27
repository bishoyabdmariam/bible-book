// verse_detail_screen.dart

import 'package:bible/service/apiService.dart';
import 'package:bible/versedetail.dart';
import 'package:flutter/material.dart';
import 'models/VerseDetails.dart';

class VerseDetailScreen extends StatefulWidget {
  final String bibleVersionID;
  final String abbreviation;
  final String bibleVerseID;

  VerseDetailScreen({
    required this.bibleVersionID,
    required this.abbreviation,
    required this.bibleVerseID,
  });

  @override
  _VerseDetailScreenState createState() => _VerseDetailScreenState();
}

class _VerseDetailScreenState extends State<VerseDetailScreen> {
  late Future<VerseDetails> _verse;

  @override
  void initState() {
    super.initState();
    _verse = _getSelectedVerse();
  }

  Future<VerseDetails> _getSelectedVerse() async {
    try {
      return ApiService.getSelectedVerse(widget.bibleVersionID, widget.bibleVerseID);
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verse Detail'),
      ),
      body: FutureBuilder<VerseDetails>(
        future: _verse,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            VerseDetails verse = snapshot.data!;
            return VerseDetail(verse: verse);
          }
        },
      ),
    );
  }
}
