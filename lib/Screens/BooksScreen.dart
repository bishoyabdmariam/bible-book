import 'package:bible/service/apiService.dart';
import 'package:flutter/material.dart';

import 'ChaptersScreen.dart';
import '../models/book.dart';

class BookListScreen extends StatefulWidget {
  final String bibleVersionID;

  const BookListScreen({super.key, required this.bibleVersionID,});

  @override
  BookListScreenState createState() => BookListScreenState();
}

class BookListScreenState extends State<BookListScreen> {
  List<Book> bookList = [];

  TextDirection textDirection = LanguagePreferences.getLanguage();

  @override
  void initState() {
    super.initState();
    _getBooks();
  }

  Future<void> _getBooks() async {
    bookList = await ApiService.getBooks(widget.bibleVersionID);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Book'),
      ),
      body: bookList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: bookList.length,
              itemBuilder: (context, index) {
                final book = bookList[index];
                return Card(
                  elevation: 2.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text(
                      book.name,
                      textDirection:textDirection,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChapterListScreen(
                            bibleVersionID: widget.bibleVersionID,
                            bibleBookID:
                                book.id, // Replace with the actual book ID
                          ),
                        ),
                      );

                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChapterScreen(
                            bibleVersionID: widget.bibleVersionID,
                            abbreviation: widget.abbreviation,
                            bookID: book.id,
                          ),
                        ),
                      );*/
                    },
                  ),
                );
              },
            ),
    );
  }
}
