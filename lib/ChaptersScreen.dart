import 'package:bible/VersesScreen.dart';
import 'package:bible/service/apiService.dart';
import 'package:flutter/material.dart';

import 'SectionsScreen.dart';
import 'models/chapter.dart';

class ChapterListScreen extends StatefulWidget {
  final String bibleVersionID;
  final String bibleBookID;

  const ChapterListScreen({
    super.key,
    required this.bibleVersionID,
    required this.bibleBookID,
  });

  @override
  _ChapterListScreenState createState() => _ChapterListScreenState();
}

class _ChapterListScreenState extends State<ChapterListScreen> {
  List<Chapter> chapterList = [];

  @override
  void initState() {
    super.initState();
    _getChapters();
  }

  Future<void> _getChapters() async {
    chapterList = await ApiService.getChapters(
      widget.bibleVersionID,
      widget.bibleBookID,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Chapter'),
      ),
      body: chapterList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: chapterList.length,
              itemBuilder: (context, index) {
                final chapter = chapterList[index];
                return Card(
                  elevation: 2.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text(
                      'Chapter ${chapter.number}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    onTap: () {
                      print("this ${chapter.number}");
                      print("thisis  ${widget.bibleVersionID}");
                      print("thisisis  ${widget.bibleBookID}");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => VerseListScreen(
                            bibleVersionID: widget.bibleVersionID,
                            chapterNumber: "${widget.bibleBookID}.${chapter.number}",
                            bibleBookID: widget
                                .bibleBookID, // Replace with the actual book ID
                          ),
                        ),
                      );

                      // Navigate to the verse screen
                      /*  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerseListScreen(
                      bibleVersionID: widget.bibleVersionID,
                      abbreviation: widget.abbreviation,
                      bibleBookID: widget.bibleBookID,
                      chapterID: chapter.id,
                    ),
                  ),
                );
              */
                    },
                  ),
                );
              },
            ),
    );
  }
}
