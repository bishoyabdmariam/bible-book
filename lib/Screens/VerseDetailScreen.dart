// verse_detail_screen.dart

import 'package:bible/service/apiService.dart';
import 'package:bible/Screens/versedetail.dart';
import 'package:flutter/material.dart';
import '../models/VerseDetails.dart';

class VerseDetailScreen extends StatefulWidget {
  final String bibleBookID;
  final String bibleVerseID;

  const VerseDetailScreen({
    super.key,
    required this.bibleBookID,
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
      return ApiService.getSelectedVerse(
        widget.bibleBookID,
        widget.bibleVerseID,
      );
    } catch (error) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verse Caption'),
      ),
      body: FutureBuilder<VerseDetails>(
        future: _verse,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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
