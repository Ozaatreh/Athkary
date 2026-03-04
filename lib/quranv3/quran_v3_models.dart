class QuranEdition {
  const QuranEdition({
    required this.identifier,
    required this.language,
    required this.name,
    required this.englishName,
    required this.format,
    required this.type,
  });

  final String identifier;
  final String language;
  final String name;
  final String englishName;
  final String format;
  final String type;

  factory QuranEdition.fromJson(Map<String, dynamic> json) {
    return QuranEdition(
      identifier: json['identifier']?.toString() ?? '',
      language: json['language']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      englishName: json['englishName']?.toString() ?? '',
      format: json['format']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
    );
  }
}

class SurahLite {
  const SurahLite({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.revelationType,
    required this.numberOfAyahs,
  });

  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;
  final int numberOfAyahs;

  factory SurahLite.fromJson(Map<String, dynamic> json) {
    return SurahLite(
      number: json['number'] as int? ?? 0,
      name: json['name']?.toString() ?? '',
      englishName: json['englishName']?.toString() ?? '',
      englishNameTranslation: json['englishNameTranslation']?.toString() ?? '',
      revelationType: json['revelationType']?.toString() ?? '',
      numberOfAyahs: json['numberOfAyahs'] as int? ?? 0,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurahLite && runtimeType == other.runtimeType && number == other.number;

  @override
  int get hashCode => number.hashCode;
}

class AyahItem {
  const AyahItem({
    required this.number,
    required this.numberInSurah,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda,
    required this.text,
    required this.audio,
    required this.surah,
  });

  final int number;
  final int numberInSurah;
  final int juz;
  final int manzil;
  final int page;
  final int ruku;
  final int hizbQuarter;
  final dynamic sajda;
  final String text;
  final String audio;
  final SurahLite surah;

  factory AyahItem.fromJson(Map<String, dynamic> json) {
    return AyahItem(
      number: json['number'] as int? ?? 0,
      numberInSurah: json['numberInSurah'] as int? ?? 0,
      juz: json['juz'] as int? ?? 0,
      manzil: json['manzil'] as int? ?? 0,
      page: json['page'] as int? ?? 0,
      ruku: json['ruku'] as int? ?? 0,
      hizbQuarter: json['hizbQuarter'] as int? ?? 0,
      sajda: json['sajda'],
      text: json['text']?.toString() ?? '',
      audio: json['audio']?.toString() ?? '',
      surah: SurahLite.fromJson(json['surah'] as Map<String, dynamic>? ?? {}),
    );
  }
}

class SearchResult {
  const SearchResult({required this.count, required this.matches});

  final int count;
  final List<AyahItem> matches;
}
