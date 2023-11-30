// verse_detail_screen.dart

import 'package:bible/service/apiService.dart';
import 'package:bible/Screens/versedetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../models/VerseDetails.dart';
import 'VerseDetailScreen.dart';

class AllVerseDetailScreen extends StatefulWidget {
  final String bibleVersionID;
  final String chapterNumber;

  const AllVerseDetailScreen({
    super.key,
    required this.bibleVersionID,
    required this.chapterNumber,
  });

  @override
  _AllVerseDetailScreenState createState() => _AllVerseDetailScreenState();
}

class _AllVerseDetailScreenState extends State<AllVerseDetailScreen> {
  late Future<List<VerseDetails>> _verses;

  @override
  void initState() {
    super.initState();
    _verses = _getVersesWithDetails();
  }

  Future<List<VerseDetails>> _getVersesWithDetails() async {
    try {
      return ApiService.getVersesWithDetails(
        bibleVersionID: widget.bibleVersionID,
        chapterNumber: widget.chapterNumber,
      );
    } catch (error) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Verses'),
      ),
      body: FutureBuilder<List<VerseDetails>>(
        future: _verses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<VerseDetails> verses = snapshot.data!;
            return ListView.builder(
              itemCount: verses.length,
              itemBuilder: (context, index) {
                VerseDetails verse = verses[index];
                return Directionality(
                  textDirection: LanguagePreferences.getLanguage(),
                  child: ListTile(
                    title: Text(verse.reference),
                    subtitle: HtmlWidget(verse.content),
                    onTap: () {},
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
