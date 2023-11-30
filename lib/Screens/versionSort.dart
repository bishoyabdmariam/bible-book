/*
import '../models/bible.dart';

class VersionSorter {
  static Map<String, List<BibleVersion>> sortVersionsByLanguage(
      List<BibleVersion> bibleVersionList) {
    Map<String, List<BibleVersion>> sortedVersions = {};

    for (final version in bibleVersionList) {
      final language = version.language!['name']!;
      if (!sortedVersions.containsKey(language)) {
        sortedVersions[language] = [];
      }
      sortedVersions[language]!.add(version);
    }

    for (final languageGroup in sortedVersions.keys) {
      sortedVersions[languageGroup]!.sort((a, b) {
        final nameA = a.name!.toUpperCase();
        final nameB = b.name!.toUpperCase();
        return nameA.compareTo(nameB);
      });
    }
    print("A7A");
    print(sortedVersions.length);
    return sortedVersions;
  }
}
*/
