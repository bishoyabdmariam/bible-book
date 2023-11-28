import 'package:bible/VerseDetailScreen.dart';
import 'package:bible/versedetail.dart';
import 'package:flutter/material.dart';
import 'package:bible/models/verse.dart'; // Import the updated Verse model
import 'package:bible/service/apiService.dart';

class VerseListScreen extends StatefulWidget {
  final String bibleVersionID;
  final String bibleBookID;
  final String chapterNumber;

  const VerseListScreen({
    Key? key,
    required this.bibleVersionID,
    required this.bibleBookID,
    required this.chapterNumber,
  }) : super(key: key);

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
    print(widget.chapterNumber);
    verseList = await ApiService.getVerses(
      widget.bibleVersionID,
      widget.bibleBookID,
      widget.chapterNumber,
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
                  title: Text(verse.reference!),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                    VerseDetailScreen(
                      bibleBookID: widget.bibleBookID,
                      bibleVerseID: verse.id!,
                    )
                    // Implement your desired action when a verse is selected
                    ));
                  },
                );
              },
            ),
    );
  }
}
