import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class AthanDownloadService {
  final _supabase = Supabase.instance.client;
  final Dio _dio = Dio();

  Future<String> getOrDownloadAthan(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);

    // ✅ If already downloaded, return local path
    if (await file.exists()) {
      return filePath;
    }

    // ✅ Get public URL from Supabase Storage
    final publicUrl = _supabase.storage
        .from('Quranv1')
        .getPublicUrl(fileName);

    // ✅ Download and store locally
    await _dio.download(publicUrl, filePath);

    return filePath;
  }
}