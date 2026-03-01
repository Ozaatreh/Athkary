// lib/services/quran_service.dart
import 'dart:convert';
import 'package:athkary/pages/quranv2/quran_models.dart';
import 'package:http/http.dart' as http;

class QuranService {
  static const String baseUrl = 'https://api.alquran.cloud/v1';

  /// Load all Surahs (metadata only)
  Future<List<Surah>> getSurahs() async {
    final response = await http.get(Uri.parse('$baseUrl/surah'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load surahs');
    }

    final data = json.decode(response.body);

    return (data['data'] as List)
        .map((s) => Surah(
              number: s['number'],
              name: s['name'],
              englishName: s['englishName'],
              numberOfAyahs: s['numberOfAyahs'],
              juzNumber: 1,
            ))
        .toList();
  }

  /// Load Surah detail (for first page detection only)
  Future<SurahDetail> getSurahDetail(int surahNumber) async {
    final response =
        await http.get(Uri.parse('$baseUrl/surah/$surahNumber/ar.alafasy'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load surah detail');
    }

    final data = json.decode(response.body);
    final surahData = data['data'];

    return SurahDetail(
      number: surahData['number'],
      name: surahData['name'],
      englishName: surahData['englishName'],
      ayahs: (surahData['ayahs'] as List)
          .map((a) => Ayah(
                number: a['number'],
                numberInSurah: a['numberInSurah'],
                text: a['text'],
                audioUrl: a['audio'],
                page: a['page'],
                juz: a['juz'],
              ))
          .toList(),
    );
  }

  /// Load ayahs by page
  Future<List<Ayah>> getAyahsByPage(int page) async {
    final response =
        await http.get(Uri.parse('$baseUrl/page/$page/ar.alafasy'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load page');
    }

    final data = json.decode(response.body);

    return (data['data']['ayahs'] as List)
        .map((a) => Ayah(
              number: a['number'],
              numberInSurah: a['numberInSurah'],
              text: a['text'],
              audioUrl: a['audio'],
              page: a['page'],
              juz: a['juz'],
              surahNumber: a['surah']['number'],
              surahName: a['surah']['name'],
            ))
        .toList();
  }
Future<int> getFirstPageOfSurah(int surahNumber) async {
  final response = await http.get(
    Uri.parse('$baseUrl/surah/$surahNumber/ar.alafasy'),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to load surah');
  }

  final data = json.decode(response.body);
  final ayahs = data['data']['ayahs'] as List;

  return ayahs.first['page'];
}


Future<int> getFirstPageOfSurahInJuz(int juzNumber, int surahNumber) async {
  final response =
      await http.get(Uri.parse('$baseUrl/juz/$juzNumber/ar.alafasy'));

  if (response.statusCode != 200) {
    throw Exception('Failed to load juz');
  }

  final data = json.decode(response.body);
  final ayahs = data['data']['ayahs'] as List;

  final firstMatch = ayahs.cast<Map<String, dynamic>?>().firstWhere(
        (ayah) => ayah?['surah']?['number'] == surahNumber,
        orElse: () => null,
      );

  if (firstMatch != null) {
    return firstMatch['page'] as int;
  }

  return getFirstPageOfSurah(surahNumber);
}

Future<int> getFirstPageOfJuz(int juzNumber) async {
  final response =
      await http.get(Uri.parse('$baseUrl/juz/$juzNumber/ar.alafasy'));

  if (response.statusCode != 200) {
    throw Exception('Failed to load juz');
  }

  final data = json.decode(response.body);
  final ayahs = data['data']['ayahs'] as List;

  return ayahs.first['page'];
}
  /// 🔥 Optimized: Get Juz → Surahs (parallel requests)
  Future<Map<int, List<int>>> getJuzSurahNumbers() async {
    final futures = List.generate(
      30,
      (index) => http.get(
        Uri.parse('$baseUrl/juz/${index + 1}/quran-uthmani'),
      ),
    );

    final responses = await Future.wait(futures);

    Map<int, List<int>> result = {};

    for (int i = 0; i < responses.length; i++) {
      if (responses[i].statusCode == 200) {
        final data = json.decode(responses[i].body);
        final ayahs = data['data']['ayahs'] as List;

        final surahNumbers =
            ayahs.map<int>((a) => a['surah']['number'] as int).toSet().toList()
              ..sort();

        result[i + 1] = surahNumbers;
      }
    }

    return result;
  }
}