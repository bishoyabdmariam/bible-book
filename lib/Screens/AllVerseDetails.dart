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
  late List<VerseDetails> _loadedVerses;
  int _loadedVerseCount = 0;

  @override
  void initState() {
    super.initState();
    _loadedVerses = [];
    _verses = _getVersesWithDetails().then((verses) {
      _loadMoreVerses(); // Load more verses after the initial list is fetched
      return verses;
    });
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

  void _loadMoreVerses() {
    final remainingVerses = _verses.then((verses) {
      if (_loadedVerseCount < verses.length) {

        final endIndex = _loadedVerseCount + 1; // Load next 10 verses
        setState(() {
        });
        return verses.sublist(_loadedVerseCount, endIndex);

      }
      return [];
    });

    remainingVerses.then((verses) {
      if(verses.isNotEmpty) {
          _loadedVerses.add(verses.first);
          _loadedVerseCount += 1;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Verses'),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            _loadMoreVerses(); // Load more verses when reaching the end of the list
            setState(() {});
          }
          setState(() {});
          return true;
        },
        child: FutureBuilder<List<VerseDetails>>(
          future: _verses,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                // Experiment with different values to find the optimal one
                itemCount: _loadedVerses.length,
                itemBuilder: (context, index) {
                  VerseDetails verse = _loadedVerses[index];
                  return Directionality(
                    textDirection: LanguagePreferences.getLanguage(),
                    child: HtmlWidget(verse.content),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
