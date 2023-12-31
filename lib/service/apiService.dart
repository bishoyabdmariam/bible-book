import 'dart:convert';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/bible.dart';
import '../models/VerseDetails.dart';
import '../models/book.dart';
import '../models/chapter.dart';
import '../models/section.dart';
import '../models/verse.dart'; // Add this import for Section model
import 'package:shared_preferences/shared_preferences.dart';


class ApiService {
  static const String apiKey =
      '17b41645555d5aecd782d0f37e25174b'; // Replace with your actual API key
  static const String baseUrl = 'https://api.scripture.api.bible/v1/bibles';

  static Future<List<BibleVersion>> getBibleVersions() async {
    const String apiUrl = baseUrl;
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'api-key': apiKey,
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((data) {
          return BibleVersion(
            scriptDirection: data['scriptDirection'],
            name: data['name'],
            id: data['id'],
            description: data['description'],
            language: {
              'name': data['language']['name'],
            },
          );
        }).toList();
      } else {
        if (kDebugMode) {
          print('Failed to load Bible versions: ${response.statusCode}');
        }
        return [];
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching Bible versions: $error');
      }
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
        if (kDebugMode) {
          print('Failed to load books: ${response.statusCode}');
        }
        return [];
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching books: $error');
      }
      return [];
    }
  }

  static Future<List<Chapter>> getChapters(
    String bibleVersionID,
    String bibleBookID,
  ) async {
    final String apiUrl =
        '$baseUrl/$bibleVersionID/books/$bibleBookID/chapters';
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
        if (kDebugMode) {
          print('Failed to load chapters: ${response.statusCode}');
        }
        return [];
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching chapters: $error');
      }
      return [];
    }
  }

  static Future<List<Section>> getSections(
    String bibleVersionID,
    String bibleBookID,
  ) async {
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
        if (kDebugMode) {
          print('Failed to load sections: ${response.statusCode}');
        }
        return [];
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching sections: $error');
      }
      return [];
    }
  }

  static Future<List<Verse>> getVerses(
      {required String bibleVersionID,required String chapterNumber}) async {
    final String apiUrl =
        '$baseUrl/$bibleVersionID/chapters/$chapterNumber/verses';
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
        if (kDebugMode) {
          print('Failed to load verses: ${response.statusCode}');
        }
        return [];
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching verses: $error');
      }
      return [];
    }
  }

  static Future<VerseDetails> getSelectedVerse(
      String bibleBookID, String bibleVerseID) async {
    final String apiUrl =
        '$baseUrl/$bibleBookID/verses/$bibleVerseID?content-type=html&include-notes=false&include-titles=true&include-chapter-numbers=false&include-verse-numbers=true&include-verse-spans=false&use-org-id=false';

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'api-key': apiKey,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body)['data'];
        return VerseDetails.fromJson(data);
      } else {
        throw Exception(
            'Failed to load selected verse: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching selected verse: $error');
    }
  }
// apiService.dart

  static Future<List<VerseDetails>> getVersesWithDetails({
    required String bibleVersionID,
    required String chapterNumber,
  }) async {
    final String apiUrl =
        '$baseUrl/$bibleVersionID/chapters/$chapterNumber/verses';
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'api-key': apiKey,
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        final List<VerseDetails> versesWithDetails = [];

        for (final verseData in data) {
          final VerseDetails verseDetails = await getSelectedVerse(
            bibleVersionID,
            verseData['id'],
          );
          versesWithDetails.add(verseDetails);
        }

        return versesWithDetails;
      } else {
        if (kDebugMode) {
          print('Failed to load verses: ${response.statusCode}');
        }
        return [];
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching verses: $error');
      }
      return [];
    }
  }

}




class LanguagePreferences {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static TextDirection getLanguage() {
    String storedLanguage = _prefs.getString('languageDir') ?? 'LTR';
    return storedLanguage == 'RTL' ? TextDirection.rtl : TextDirection.ltr;
  }

  static Future<void> setLanguage(TextDirection languageDirection) async {
    String languageCode = languageDirection == TextDirection.rtl ? 'RTL' : 'LTR';
    await _prefs.setString('languageDir', languageCode);
  }

}
