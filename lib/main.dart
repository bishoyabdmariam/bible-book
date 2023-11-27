import 'package:bible/service/apiService.dart';
import 'package:flutter/material.dart';
import 'BooksScreen.dart';
import 'models/bible.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      theme: ThemeData(
        // Add your desired background color here
        scaffoldBackgroundColor: Colors.grey[200],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bible Versions'),
      ),
      body: bibleVersions.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : BibleVersionList(
              bibleVersions: bibleVersions,
              onVersionSelected: (version) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BookListScreen(
                      bibleVersionID: version.id!,
                      abbreviation: version.abbreviation!,
                    ),
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
      itemCount: bibleVersions.length,
      itemBuilder: (context, index) {
        final version = bibleVersions[index];
        return Card(
          color: Colors.white, // Add your desired card color here
          elevation: 2.0, // Add elevation for a subtle shadow
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
