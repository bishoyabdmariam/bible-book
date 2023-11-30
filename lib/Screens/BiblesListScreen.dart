import 'package:flutter/material.dart';
import 'package:bible/service/apiService.dart';
import 'BooksScreen.dart';
import '../models/bible.dart';

class BibleListScreen extends StatefulWidget {
  const BibleListScreen({Key? key}) : super(key: key);

  @override
  BibleListScreenState createState() => BibleListScreenState();
}

class BibleListScreenState extends State<BibleListScreen> {
  List<BibleVersion> bibleVersions = [];

  @override
  void initState() {
    super.initState();
    _getBibleVersions();
  }

  Future<void> _getBibleVersions() async {
    bibleVersions = await ApiService.getBibleVersions();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (bibleVersions.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    // Extract unique languages
    Set<String> uniqueLanguages = {};
    for (var version in bibleVersions) {
      final language = version.language?['name'] ?? "Unknown Language";
      uniqueLanguages.add(language);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bible Versions'),
      ),
      body: ListView.builder(
        itemCount: uniqueLanguages.length,
        itemBuilder: (context, index) {
          final language = uniqueLanguages.elementAt(index);
          final languageBibles = bibleVersions
              .where((version) => version.language?['name'] == language)
              .toList();

          return Card(
            color: Colors.grey[200],
            elevation: 2.0,
            margin:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(language),
                ),
                BibleVersionList(
                  bibleVersions: languageBibles,
                  onVersionSelected: (version) {
                    version.scriptDirection == "LTR"
                        ? LanguagePreferences.setLanguage(TextDirection.ltr)
                        : LanguagePreferences.setLanguage(TextDirection.rtl);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BookListScreen(
                          bibleVersionID: version.id!,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class BibleVersionList extends StatelessWidget {
  final List<BibleVersion> bibleVersions;
  final Function(BibleVersion) onVersionSelected;

  const BibleVersionList({
    Key? key,
    required this.bibleVersions,
    required this.onVersionSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: bibleVersions.length,
      itemBuilder: (context, index) {
        final version = bibleVersions[index];
        return Card(
          color: Colors.white,
          elevation: 2.0,
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ListTile(
            title: Text(version.name ?? "No Name"),
            subtitle: Text(version.description ?? "No description"),
            onTap: () {
              onVersionSelected(version);
            },
          ),
        );
      },
    );
  }
}
