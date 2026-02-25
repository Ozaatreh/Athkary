import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class RamadanPdfService {
  static const String _baseUrl =
      'https://ykvcjhxfyodririeyqiw.supabase.co/storage/v1/object/public/Ramadan';

  static const List<String> pdfFiles = [
    '100duaa.pdf',
    'jawame_alduaa.pdf',
    'layllat_alqader.pdf',
  ];

  static Future<Directory> _cacheDir() async {
    final dir = await getApplicationDocumentsDirectory();
    final ramadanDir = Directory('${dir.path}/ramadan_pdfs');
    if (!await ramadanDir.exists()) {
      await ramadanDir.create(recursive: true);
    }
    return ramadanDir;
  }

  static Future<File> _localFileFor(String fileName) async {
    final dir = await _cacheDir();
    return File('${dir.path}/$fileName');
  }

  static Future<File> ensureDownloaded(String fileName) async {
    final local = await _localFileFor(fileName);
    if (await local.exists() && await local.length() > 0) {
      return local;
    }

    final url = '$_baseUrl/${Uri.encodeComponent(fileName)}';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode != 200) {
      throw Exception('Failed to download $fileName (${res.statusCode})');
    }

    await local.writeAsBytes(res.bodyBytes, flush: true);
    return local;
  }

  static Future<Map<String, String>> prefetchAll() async {
    final Map<String, String> result = {};
    for (final file in pdfFiles) {
      final local = await ensureDownloaded(file);
      result[file] = local.path;
    }
    return result;
  }

  static Future<String?> getCachedPath(String fileName) async {
    final file = await _localFileFor(fileName);
    if (await file.exists()) {
      return file.path;
    }
    return null;
  }
}
