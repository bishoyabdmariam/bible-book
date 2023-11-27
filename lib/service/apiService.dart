import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/bible.dart';
import '../models/book.dart';
import '../models/chapter.dart';
import '../models/section.dart';
import '../models/verse.dart'; // Add this import for Section model

class ApiService {
  static const String apiKey =
      'b408dfc9ba8475d7be9be4aedf728383'; // Replace with your actual API key
  static const String baseUrl = 'https://api.scripture.api.bible/v1/bibles';

  static Future<List<BibleVersion>> getBibleVersions() async {
    const String apiUrl = '$baseUrl';
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'api-key': apiKey,
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((data) {
          return BibleVersion(
            name: data['name'],
            id: data['id'],
            abbreviation: data['abbreviation'],
            description: data['description'],
            language: data['language']['name'],
          );
        }).toList();
      } else {
        print('Failed to load Bible versions: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error fetching Bible versions: $error');
      return [];
    }
  }

  static Future<List<Book>> getBooks(String bibleVersionID) async {
    final String apiUrl = '$baseUrl/$bibleVersionID/books';
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'api-key': apiKey,
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((data) {
          return Book(
            name: data['name'],
            id: data['id'],
          );
        }).toList();
      } else {
        print('Failed to load books: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error fetching books: $error');
      return [];
    }
  }

  static Future<List<Chapter>> getChapters(
      String bibleVersionID, String bibleBookID) async {
    final String apiUrl = '$baseUrl/$bibleVersionID/books/$bibleBookID/chapters';
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'api-key': apiKey,
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((data) {
          return Chapter(
            id: data['id'],
            number: data['number'],
          );
        }).toList();
      } else {
        print('Failed to load chapters: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error fetching chapters: $error');
      return [];
    }
  }

  static Future<List<Section>> getSections(
      String bibleVersionID, String bibleBookID) async {
    final String apiUrl =
        '$baseUrl/$bibleVersionID/books/$bibleBookID/sections';
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'api-key': apiKey,
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((data) {
          return Section.fromJson(data);
        }).toList();
      } else {
        print('Failed to load sections: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error fetching sections: $error');
      return [];
    }
  }

  static Future<List<Verse>> getVerses(
      String bibleVersionID, String bibleBookID, int chapterNumber) async {
    final String apiUrl =
        '$baseUrl/$bibleVersionID/books/$bibleBookID/chapters/$chapterNumber/verses';
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'api-key': apiKey,
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((data) {
          return Verse.fromJson(data);
        }).toList();
      } else {
        print('Failed to load verses: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error fetching verses: $error');
      return [];
    }
  }
}
