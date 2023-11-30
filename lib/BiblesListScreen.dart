import 'package:flutter/material.dart';
import 'package:bible/service/apiService.dart';
import 'BooksScreen.dart';
import 'models/bible.dart';

class BibleListScreen extends StatefulWidget {
  const BibleListScreen({Key? key});

  @override
  _BibleListScreenState createState() => _BibleListScreenState();
}

class _BibleListScreenState extends State<BibleListScreen> {
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
    return bibleVersions.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: bibleVersions.length,
            itemBuilder: (context, index) {
              final languageMap = bibleVersions[index].language;
              final language = languageMap?['name'] ?? "Unknown Language";
              final languageBibles = bibleVersions
                  .where((version) =>
                      version.language?['name'] == languageMap?['name'])
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
                      subtitle: Text("Bibles in $language"),
                    ),
                    BibleVersionList(
                      bibleVersions: languageBibles,
                      onVersionSelected: (version) {
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
