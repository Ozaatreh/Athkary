// lib/services/quran_service.dart
import 'dart:convert';
import 'package:athkary/pages/quranv2/quran_models.dart';
import 'package:http/http.dart' as http;


class QuranService {
  static const String baseUrl = 'https://api.alquran.cloud/v1';

  Future<List<Juz>> getJuzList() async {
    // Build juz list with surah info from the API
    final response = await http.get(Uri.parse('$baseUrl/surah'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final surahs = (data['data'] as List)
          .map((s) => Surah(
                number: s['number'],
                name: s['name'],
                englishName: s['englishName'],
                numberOfAyahs: s['numberOfAyahs'],
                juzNumber: (s['number'] as int),
              ))
          .toList();

      // Group surahs by juz
      Map<int, List<Surah>> juzMap = {};
      for (var surah in surahs) {
        // We'll assign surahs to juz via juz endpoint data
      }

      // Get juz data
      List<Juz> juzList = [];
      for (int i = 1; i <= 30; i++) {
        final juzResponse =
            await http.get(Uri.parse('$baseUrl/juz/$i/quran-uthmani'));
        if (juzResponse.statusCode == 200) {
          final juzData = json.decode(juzResponse.body);
          final ayahs = juzData['data']['ayahs'] as List;
          Set<int> surahNumbers = {};
          for (var ayah in ayahs) {
            surahNumbers.add(ayah['surah']['number'] as int);
          }
          final juzSurahs = surahs
              .where((s) => surahNumbers.contains(s.number))
              .toList();
          juzList.add(Juz(number: i, surahs: juzSurahs));
        }
      }
      return juzList;
    }
    throw Exception('Failed to load juz list');
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
