import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PdfCacheService {

  static const String pdfUrl =
      "https://ykvcjhxfyodririeyqiw.supabase.co/storage/v1/object/public/Quranv1/Quraan_v0.pdf";

  static const String fileName = "quran.pdf";

  static Future<File> _getLocalFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$fileName');
  }

  /// Check if file exists
  static Future<bool> isDownloaded() async {
    final file = await _getLocalFile();
    return file.exists();
  }

  /// Download file
  static Future<File> downloadPdf() async {
    final file = await _getLocalFile();

    final response = await http.get(Uri.parse(pdfUrl));

    if (response.statusCode == 200) {
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } else {
      throw Exception("Download failed: ${response.statusCode}");
    }
  }

  /// Get file (no forced download)
  static Future<File?> getIfExists() async {
    final file = await _getLocalFile();
    if (await file.exists()) return file;
    return null;
  }
}