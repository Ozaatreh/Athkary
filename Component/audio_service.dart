import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;

class AudioService {
  static final AudioPlayer _player = AudioPlayer();
  static bool _isPlaying = false;

  static Future<void> playAudio(String url) async {
    try {
      if (_isPlaying) {
        await _player.stop();
      }
      await _player.play(UrlSource(url));
      _isPlaying = true;
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  static Future<void> stopAudio() async {
    await _player.stop();
    _isPlaying = false;
  }

  static Future<bool> checkAudioExists(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}