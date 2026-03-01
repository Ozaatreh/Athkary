import 'dart:convert';

import 'package:athkary/quranv3/quran_v3_models.dart';
import 'package:http/http.dart' as http;

class QuranV3Service {
  static const String _baseUrl = 'https://api.alquran.cloud/v1';

  Future<List<QuranEdition>> getEditions() async {
    final res = await http.get(Uri.parse('$_baseUrl/edition'));
    _check(res, 'Failed to load editions');
    final data = jsonDecode(res.body)['data'] as List<dynamic>;
    return data
        .map((e) => QuranEdition.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<SurahLite>> getSurahs() async {
    final res = await http.get(Uri.parse('$_baseUrl/surah'));
    _check(res, 'Failed to load surahs');
    final data = jsonDecode(res.body)['data'] as List<dynamic>;
    return data
        .map((s) => SurahLite.fromJson(s as Map<String, dynamic>))
        .toList();
  }

  Future<List<AyahItem>> getSurahAyahs(int surahNumber,
      {String edition = 'quran-uthmani'}) async {
    final res = await http.get(Uri.parse('$_baseUrl/surah/$surahNumber/$edition'));
    _check(res, 'Failed to load surah');
    final ayahs = jsonDecode(res.body)['data']['ayahs'] as List<dynamic>;
    return ayahs
        .map((a) => AyahItem.fromJson(a as Map<String, dynamic>))
        .toList();
  }

  Future<SearchResult> searchAyah(String query,
      {int surah = 0, String edition = 'ar.alafasy'}) async {
    final encoded = Uri.encodeComponent(query);
    final res = await http.get(Uri.parse(
      '$_baseUrl/search/$encoded/$surah/$edition',
    ));
    _check(res, 'Failed to search');
    final map = jsonDecode(res.body)['data'] as Map<String, dynamic>;
    final matches = (map['matches'] as List<dynamic>)
        .map((a) => AyahItem.fromJson(a as Map<String, dynamic>))
        .toList();
    return SearchResult(count: map['count'] as int? ?? 0, matches: matches);
  }

  Future<Map<String, dynamic>> getMeta() async {
    final res = await http.get(Uri.parse('$_baseUrl/meta'));
    _check(res, 'Failed to load meta');
    return jsonDecode(res.body)['data'] as Map<String, dynamic>;
  }

  Future<List<AyahItem>> getJuz(int number, {String edition = 'quran-uthmani'}) {
    return _segment('juz', number, edition);
  }

  Future<List<AyahItem>> getManzil(int number,
      {String edition = 'quran-uthmani'}) {
    return _segment('manzil', number, edition);
  }

  Future<List<AyahItem>> getRuku(int number, {String edition = 'quran-uthmani'}) {
    return _segment('ruku', number, edition);
  }

  Future<List<AyahItem>> getPage(int number, {String edition = 'quran-uthmani'}) {
    return _segment('page', number, edition);
  }

  Future<List<AyahItem>> getHizbQuarter(int number,
      {String edition = 'quran-uthmani'}) {
    return _segment('hizbQuarter', number, edition);
  }

  Future<List<AyahItem>> getSajda({String edition = 'quran-uthmani'}) async {
    final res = await http.get(Uri.parse('$_baseUrl/sajda/$edition'));
    _check(res, 'Failed to load sajda verses');
    final data = jsonDecode(res.body)['data']['ayahs'] as List<dynamic>;
    return data
        .map((a) => AyahItem.fromJson(a as Map<String, dynamic>))
        .toList();
  }

  Future<List<AyahItem>> _segment(
    String endpoint,
    int number,
    String edition,
  ) async {
    final res = await http.get(Uri.parse('$_baseUrl/$endpoint/$number/$edition'));
    _check(res, 'Failed to load $endpoint $number');
    final data = jsonDecode(res.body)['data']['ayahs'] as List<dynamic>;
    return data
        .map((a) => AyahItem.fromJson(a as Map<String, dynamic>))
        .toList();
  }

  void _check(http.Response response, String message) {
    if (response.statusCode != 200) {
      throw Exception('$message (${response.statusCode})');
    }
  }
}