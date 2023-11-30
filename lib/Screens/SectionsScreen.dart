import 'package:bible/service/apiService.dart';
import 'package:flutter/material.dart';
import 'VersesScreen.dart';
import '../models/section.dart'; // Import the VerseListScreen

class SectionListScreen extends StatefulWidget {
  final String bibleVersionID;
  final String abbreviation;
  final String bibleBookID;

  const SectionListScreen({super.key,
    required this.bibleVersionID,
    required this.abbreviation,
    required this.bibleBookID,
  });

  @override
  _SectionListScreenState createState() => _SectionListScreenState();
}

class _SectionListScreenState extends State<SectionListScreen> {
  List<Section> sectionList = [];

  @override
  void initState() {
    super.initState();
    _getSections();
  }

  Future<void> _getSections() async {
    sectionList = await ApiService.getSections(
      widget.bibleVersionID,
      widget.bibleBookID,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Section'),
      ),
      body: sectionList.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: sectionList.length,
        itemBuilder: (context, index) {
          final section = sectionList[index];
          return Card(
            elevation: 2.0,
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(
                'Section ${section.id}: ${section.title}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                // Navigate to the VerseListScreen when a section is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerseListScreen(
                      bibleVersionID: widget.bibleVersionID,
                      bibleBookID: widget.bibleBookID,
                      chapterNumber: section.id, // Assuming section id is the chapter number
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
