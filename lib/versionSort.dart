
import 'models/bible.dart';

class VersionSorter {
  static Map<String, List<BibleVersion>> sortVersionsByLanguage(
      List<BibleVersion> bibleVersionList) {
    Map<String, List<BibleVersion>> sortedVersions = {};

    for (final version in bibleVersionList) {
      if (!sortedVersions.containsKey(version.language)) {
        sortedVersions[version.language!] = [];
      }
      sortedVersions[version.language]!.add(version);
    }

    for (final languageGroup in sortedVersions.keys) {
      sortedVersions[languageGroup]!.sort((a, b) {
        final nameA = a.abbreviation!.toUpperCase();
        final nameB = b.abbreviation!.toUpperCase();
        return nameA.compareTo(nameB);
      });
    }
    return sortedVersions;
  }

  static List<String> getLanguages(List<BibleVersion> bibleVersionList) {
    Set<String> languages = {};
    for (final version in bibleVersionList) {
      languages.add(version.language!);
    }
    return languages.toList();
  }
}
