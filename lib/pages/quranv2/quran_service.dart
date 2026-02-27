// lib/services/quran_service.dart
import 'dart:convert';
import 'package:athkary/pages/quranv2/quran_models.dart';
import 'package:http/http.dart' as http;


class QuranService {
  static const String baseUrl = 'https://api.alquran.cloud/v1';

  Future<List<Juz>> getJuzList() async {
  final surahResponse = await http.get(Uri.parse('$baseUrl/surah'));

  if (surahResponse.statusCode != 200) {
    throw Exception('Failed to load surahs');
  }

  final surahData = json.decode(surahResponse.body);
  final surahs = (surahData['data'] as List)
      .map((s) => Surah(
            number: s['number'],
            name: s['name'],
            englishName: s['englishName'],
            numberOfAyahs: s['numberOfAyahs'],
            juzNumber: 1,
          ))
      .toList();

  // 🔥 Run all 30 requests in parallel
  final futures = List.generate(
    30,
    (index) => http.get(
      Uri.parse('$baseUrl/juz/${index + 1}/quran-uthmani'),
    ),
  );

  final responses = await Future.wait(futures);

  List<Juz> juzList = [];

  for (int i = 0; i < responses.length; i++) {
    if (responses[i].statusCode == 200) {
      final data = json.decode(responses[i].body);
      final ayahs = data['data']['ayahs'] as List;

      final surahNumbers = ayahs
          .map<int>((a) => a['surah']['number'] as int)
          .toSet();

      final juzSurahs =
          surahs.where((s) => surahNumbers.contains(s.number)).toList();

      juzList.add(Juz(number: i + 1, surahs: juzSurahs));
    }
  }

  return juzList;
}
  
  Future<int> getFirstPageOfJuz(int juzNumber) async {
  final response =
      await http.get(Uri.parse('$baseUrl/juz/$juzNumber/ar.alafasy'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final ayahs = data['data']['ayahs'] as List;
    return ayahs.first['page'];
  }

  throw Exception('Failed to load juz');
}

  Future<List<Surah>> getSurahs() async {
    final response = await http.get(Uri.parse('$baseUrl/surah'));
    if (response.statusCode == 200) {
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
    throw Exception('Failed to load surahs');
  }

  Future<SurahDetail> getSurahDetail(int surahNumber) async {
    final response = await http.get(
        Uri.parse('$baseUrl/surah/$surahNumber/ar.alafasy'));
    if (response.statusCode == 200) {
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
    throw Exception('Failed to load surah detail');
  }

  Future<List<Ayah>> getAyahsByPage(int page) async {
    final response = await http.get(
        Uri.parse('$baseUrl/page/$page/ar.alafasy'));
    if (response.statusCode == 200) {
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
    throw Exception('Failed to load page');
  }

  Future<Map<String, dynamic>> getJuzWithSurahs(int juzNumber) async {
    final response = await http.get(
        Uri.parse('$baseUrl/juz/$juzNumber/ar.alafasy'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'];
    }
    throw Exception('Failed to load juz');
  }
}
