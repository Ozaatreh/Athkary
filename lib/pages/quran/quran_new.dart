import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';

class QuranPage extends StatefulWidget {
  @override
  _QuranPageState createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  int selectedSurah = 1;
  List<dynamic> ayahs = [];
  List<List<dynamic>> pages = [];
  String surahName = "";
  bool isLoading = true;
  Axis scrollDirection = Axis.horizontal;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    fetchSurah();
  }

  Future<void> fetchSurah() async {
    setState(() {
      isLoading = true;
      ayahs = [];
      pages = [];
    });

    final url = Uri.parse("https://api.alquran.cloud/v1/surah/$selectedSurah");
    try {
      final response = await http.get(url);
      final data = json.decode(response.body);
      final allAyahs = data['data']['ayahs'];
      setState(() {
        surahName = data['data']['name'];
        ayahs = allAyahs;
        pages = chunkAyahs(allAyahs, 10); // Adjust ayahs per "صفحة"
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching surah: $e");
      setState(() => isLoading = false);
    }
  }

  List<List<dynamic>> chunkAyahs(List<dynamic> list, int chunkSize) {
    List<List<dynamic>> chunks = [];
    for (int i = 0; i < list.length; i += chunkSize) {
      chunks.add(list.sublist(i, i + chunkSize > list.length ? list.length : i + chunkSize));
    }
    return chunks;
  }

  Future<void> playAyah(String url) async {
    try {
      await player.setUrl(url);
      player.play();
    } catch (e) {
      print("Audio error: $e");
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.black),
        title: Text(
          'القرآن الكريم',
          style: GoogleFonts.amiri(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          DropdownButton<int>(
            dropdownColor: Colors.white,
            value: selectedSurah,
            underline: SizedBox(),
            iconEnabledColor: Colors.black,
            items: List.generate(114, (index) {
              int surahNum = index + 1;
              return DropdownMenuItem(
                value: surahNum,
                child: Text(
                  'سورة ${surahNamesArabic[surahNum - 1]}',
                  style: GoogleFonts.amiri(color: Colors.black),
                ),
              );
            }),
            onChanged: (value) {
              setState(() {
                selectedSurah = value!;
                fetchSurah();
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.swap_vert, color: Colors.black),
            tooltip: 'Change Scroll Direction',
            onPressed: () {
              setState(() {
                scrollDirection = scrollDirection == Axis.horizontal ? Axis.vertical : Axis.horizontal;
              });
            },
          ),
          SizedBox(width: 10),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : PageView.builder(
              scrollDirection: scrollDirection,
              reverse: scrollDirection == Axis.horizontal, // for RTL paging
              itemCount: pages.length,
              itemBuilder: (context, pageIndex) {
                return Column(
                  children: [
                    SizedBox(height: 8),
                    Text(
                      "Juz ${ayahs.isNotEmpty ? ayahs[0]['juz'] : ''}",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.symmetric(horizontal: BorderSide(color: Colors.grey.shade300)),
                      ),
                      child: Center(
                        child: Text(
                          surahName,
                          style: GoogleFonts.amiri(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        children: pages[pageIndex].map((ayah) {
                          return GestureDetector(
                            onTap: () => playAyah(ayah['audio']),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  '${ayah['text']} ﴿${ayah['numberInSurah']}﴾',
                                  style: GoogleFonts.amiri(
                                    fontSize: 23,
                                    height: 2.4,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Divider(thickness: 0.8),
                    Text(
                      '${selectedSurah} - ${surahNamesArabic[selectedSurah - 1]} - صفحة ${pageIndex + 1}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 12),
                  ],
                );
              },
            ),
    );
  }
}

const List<String> surahNamesArabic = [
  'الفاتحة', 'البقرة', 'آل عمران', 'النساء', 'المائدة', 'الأنعام', 'الأعراف', 'الأنفال', 'التوبة',
  'يونس', 'هود', 'يوسف', 'الرعد', 'إبراهيم', 'الحجر', 'النحل', 'الإسراء', 'الكهف', 'مريم', 'طه',
  'الأنبياء', 'الحج', 'المؤمنون', 'النور', 'الفرقان', 'الشعراء', 'النمل', 'القصص', 'العنكبوت', 'الروم',
  'لقمان', 'السجدة', 'الأحزاب', 'سبإ', 'فاطر', 'يس', 'الصافات', 'ص', 'الزمر', 'غافر',
  'فصلت', 'الشورى', 'الزخرف', 'الدخان', 'الجاثية', 'الأحقاف', 'محمد', 'الفتح', 'الحجرات', 'ق',
  'الذاريات', 'الطور', 'النجم', 'القمر', 'الرحمن', 'الواقعة', 'الحديد', 'المجادلة', 'الحشر', 'الممتحنة',
  'الصف', 'الجمعة', 'المنافقون', 'التغابن', 'الطلاق', 'التحريم', 'الملك', 'القلم', 'الحاقة', 'المعارج',
  'نوح', 'الجن', 'المزمل', 'المدثر', 'القيامة', 'الإنسان', 'المرسلات', 'النبأ', 'النازعات', 'عبس',
  'التكوير', 'الانفطار', 'المطففين', 'الانشقاق', 'البروج', 'الطارق', 'الأعلى', 'الغاشية', 'الفجر', 'البلد',
  'الشمس', 'الليل', 'الضحى', 'الشرح', 'التين', 'العلق', 'القدر', 'البينة', 'الزلزلة', 'العاديات',
  'القارعة', 'التكاثر', 'العصر', 'الهمزة', 'الفيل', 'قريش', 'الماعون', 'الكوثر', 'الكافرون', 'النصر',
  'المسد', 'الإخلاص', 'الفلق', 'الناس'
];
