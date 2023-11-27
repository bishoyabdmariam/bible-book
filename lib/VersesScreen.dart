// screens/VerseListScreen.dart

import 'package:flutter/material.dart';
import 'models/verse.dart'; // Import the Verse model
import 'service/apiService.dart';

class VerseListScreen extends StatefulWidget {
  final String bibleVersionID;
  final String bibleBookID;
  final String chapterNumber;

  VerseListScreen({
    required this.bibleVersionID,
    required this.bibleBookID,
    required this.chapterNumber,
  });

  @override
  _VerseListScreenState createState() => _VerseListScreenState();
}

class _VerseListScreenState extends State<VerseListScreen> {
  List<Verse> verseList = [];

  @override
  void initState() {
    super.initState();
    _getVerses();
  }

  Future<void> _getVerses() async {
    final int chapterNumber = int.tryParse(widget.chapterNumber) ?? 1;
    print(chapterNumber);
    verseList = await ApiService.getVerses(
      widget.bibleVersionID,
      widget.bibleBookID,
      chapterNumber,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Verse'),
      ),
      body: verseList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: verseList.length,
              itemBuilder: (context, index) {
                final verse = verseList[index];
                return ListTile(
                  title: Text('Verse ${verse.number}'),
                  subtitle: Text(verse.text),
                  onTap: () {
                    // Implement your desired action when a verse is selected
                  },
                );
              },
            ),
    );
  }
}
