// lib/models/quran_models.dart

class Juz {
  final int number;
  final List<Surah> surahs;

  Juz({required this.number, required this.surahs});
}

class Surah {
  final int number;
  final String name;
  final String englishName;
  final int numberOfAyahs;
  final int juzNumber;

  Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.numberOfAyahs,
    required this.juzNumber,
  });
}

class SurahDetail {
  final int number;
  final String name;
  final String englishName;
  final List<Ayah> ayahs;

  SurahDetail({
    required this.number,
    required this.name,
    required this.englishName,
    required this.ayahs,
  });
}

class Ayah {
  final int number;
  final int numberInSurah;
  final String text;
  final String audioUrl;
  final int page;
  final int juz;
  final int? surahNumber;
  final String? surahName;

  Ayah({
    required this.number,
    required this.numberInSurah,
    required this.text,
    required this.audioUrl,
    required this.page,
    required this.juz,
    this.surahNumber,
    this.surahName,
  });
}

class BookmarkedPage {
  final int pageNumber;
  final String surahName;
  final DateTime savedAt;

  BookmarkedPage({
    required this.pageNumber,
    required this.surahName,
    required this.savedAt,
  });

  Map<String, dynamic> toJson() => {
        'pageNumber': pageNumber,
        'surahName': surahName,
        'savedAt': savedAt.toIso8601String(),
      };

  factory BookmarkedPage.fromJson(Map<String, dynamic> json) => BookmarkedPage(
        pageNumber: json['pageNumber'],
        surahName: json['surahName'],
        savedAt: DateTime.parse(json['savedAt']),
      );
}
