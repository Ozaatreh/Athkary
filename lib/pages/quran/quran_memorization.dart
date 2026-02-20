import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuranMemorizationPage extends StatefulWidget {
  const QuranMemorizationPage({super.key});

  @override
  State<QuranMemorizationPage> createState() => _QuranMemorizationPageState();
}

class _QuranMemorizationPageState extends State<QuranMemorizationPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List verses = [];
  int currentVerseIndex = 0;
  bool isPlaying = false;
  bool isLoading = false;
  String selectedSurah = "Al-Mulk";

  Future<void> fetchSurah(String surahName) async {
    setState(() => isLoading = true);
    final response = await http.get(
      Uri.parse("https://api.alquran.cloud/v1/surah/67/ar.alafasy"), // سورة الملك كمثال
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        verses = data['data']['ayahs'];
        currentVerseIndex = 0;
        isLoading = false;
      });
    }
  }

  Future<void> playCurrentVerse() async {
    if (verses.isEmpty) return;
    String audioUrl = verses[currentVerseIndex]['audio'];
    await _audioPlayer.play(UrlSource(audioUrl));
    setState(() => isPlaying = true);

    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() => isPlaying = false);
    });
  }

  void nextVerse() {
    if (currentVerseIndex < verses.length - 1) {
      setState(() => currentVerseIndex++);
    }
  }

  void previousVerse() {
    if (currentVerseIndex > 0) {
      setState(() => currentVerseIndex--);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSurah(selectedSurah);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تحفيظ القرآن", style: TextStyle(fontFamily: 'Amiri')),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : verses.isEmpty
              ? const Center(child: Text("لم يتم تحميل السورة"))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "سورة الملك - الآية ${currentVerseIndex + 1}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Amiri',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        verses[currentVerseIndex]['text'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontFamily: 'Amiri',
                          height: 1.8,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.skip_previous, size: 32),
                            onPressed: previousVerse,
                          ),
                          IconButton(
                            icon: Icon(
                              isPlaying ? Icons.stop : Icons.play_arrow,
                              size: 40,
                            ),
                            onPressed: playCurrentVerse,
                          ),
                          IconButton(
                            icon: const Icon(Icons.skip_next, size: 32),
                            onPressed: nextVerse,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: playCurrentVerse,
                        icon: const Icon(Icons.loop),
                        label: const Text("تكرار الآية"),
                      )
                    ],
                  ),
                ),
    );
  }
}
