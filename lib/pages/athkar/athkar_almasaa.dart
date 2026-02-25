import 'dart:io';
import 'package:athkary/Component/audios_files.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class AthkarAlmasaa extends StatefulWidget {
  const AthkarAlmasaa({super.key});

  @override
  State<AthkarAlmasaa> createState() => _AthkarAlmasaaState();
}

class _AthkarAlmasaaState extends State<AthkarAlmasaa> {
  final List<String> athkarEvening = [
    'سُورَةُ الإِخْلَاصِ\nبِسْمِ ٱللهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ قُلْ هُوَ ٱللهُ أَحَدٌ * ٱللهُ ٱلصَّمَدُ * لَمْ يَلِدْ وَلَمْ يُولَدْ * وَلَمْ يَكُن لَّهُۥ كُفُوًا أَحَدٌ *',
    'سُورَةُ الْفَلَقِ\nبِسْمِ ٱللهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ قُلْ أَعُوذُ بِرَبِّ ٱلْفَلَقِ * مِن شَرِّ مَا خَلَقَ * وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ * وَمِن شَرِّ ٱلنَّفَّـٰثَـٰتِ فِى ٱلْعُقَدِ * وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ *',
    'سُورَةُ النَّاسِ\nبِسْمِ ٱللهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ قُلْ أَعُوذُ بِرَبِّ ٱلنَّاسِ * مَلِكِ ٱلنَّاسِ * إِلَـٰهِ ٱلنَّاسِ * مِن شَرِّ ٱلْوَسْوَاسِ ٱلْخَنَّاسِ * ٱلَّذِى يُوَسْوِسُ فِى صُدُورِ ٱلنَّاسِ * مِنَ ٱلْجِنَّةِ وَٱلنَّاسِ *',
    'اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْماً نَافِعاً، وَرِزْقاً طَيِّباً، وَعَمَلاً مُتَقَبَّلاً',
    'أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ',
    'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الَْأرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
    'اللَّهُمَّ عَالِمَ الْغَيْبِ وَالشَّهَادَةِ فَاطِرَ السَّماوَاتِ وَالْأَرْضِ، رَبَّ كُلِّ شَيْءٍ وَمَلِيكَهُ، أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا أَنْتَ، أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي، وَمِنْ شَرِّ الشَّيْطَانِ وَشِرْكِهِ، وَأَنْ أَقْتَرِفَ عَلَى نَفْسِي سُوءاً أَوْ أَجُرَّهُ إِلَى مُسْلِمٍ',
    'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ عَدَدَ خَلْقِهِ، وَرِضَا نَفْسِهِ، وَزِنَةَ عَرْشِهِ وَمِدَادَ كَلِمَاتِهِ',
    'رَضِيتُ باللَّهِ رَبًّا، وَبِالْإِسْلَامِ دِيناً، وَبِمُحَمَّدٍ صَلَى اللَّهُ عَلِيهِ وَسَلَّمَ نَبِيَّاً',
    'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
    'يَاحَيُّ، يَا قَيُّومُ، بِرَحْمَتِكَ أَسْتَغِيثُ، أَصْلِحْ لِي شَأْنِي كُلَّهُ، وَلَا تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ',
    'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ رَبِّ الْعَالَمِينَ، اللَّهُمَّ إِنِّـي أَسْأَلُكَ خَـيْرَ هَذَا الْلَيْلِ ، فَتْحَهُ، وَنَصْرَهُ، وَنُورَهُ وَبَرَكَتَهُ، وَهُدَاهُ، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِيهِ وَشَرِّ مَا بَعْدَهُ',
    'اللَّهُمَّ إِنِّي أَمْسَيْتُ أُشْهِدُكَ وَأُشْهِدُ حَمَلَةَ عَرْشِكَ، وَمَلَائِكَتَكَ وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَهَ إِلَّا أَنْتَ وَحْدَكَ لَا شَرِيكَ لَكَ، وَأَنَّ مُحَمَّداً عَبْدُكَ وَرَسُولُكَ',
    'اللَّهُمَّ أَنْتَ رَبِّي لَّا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِر لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ',
    'اللَّهُمَّ مَا أَمْسَى بِي مِنْ نِعْمَةٍ أَوْ بِأَحَدٍ مِنْ خَلْقِكَ فَمِنْكَ وَحْدَكَ لَا شَرِيكَ لَكَ، فَلَكَ الْحَمْدُ وَلَكَ الشُّكْرُ',
    'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
  ];

  final List<String> athkarInfo = [
    'سورة الإخلاص فيها التوحيد الخالص',
    'سورة الفلق للحماية من الشرور',
    'سورة الناس للحماية من وسوسة الشيطان',
    'طلب العلم النافع والعمل المقبول',
    'طلب المغفرة والعودة إلى الله',
    'ذكر للحفظ من الأذى',
    'دعاء للحماية من النفس والشيطان',
    'ذكر يعظم الله بطرق متعددة',
    'دعاء يعبر عن الرضا بالله والإسلام والنبي',
    'تسبيح لله بحمده',
    'طلب إصلاح كل شؤون العبد',
    'طلب الخير في الليل والبركة',
    'شهادة على وحدانية الله ورسالة النبي',
    'دعاء للثبات على الوعد والاستغفار',
    'شكر الله على نعمه العظيمة',
    'ذكر عظيم يثبت التوحيد وقدرة الله',
  ];

  final List<int> maxCounts = [3, 3, 3, 1, 100, 3, 1, 3, 1, 100, 1, 1, 4, 1, 1, 100];
  late List<int> currentCounts;
  late DateTime lastResetDate;
  late SharedPreferences _prefs;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  int? _currentlyPlayingIndex;
  final Map<int, String> _downloadedAudioPaths = <int, String>{};

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final ScrollController _scrollController = ScrollController();

  // Keys for SharedPreferences
  final String _prefsKey = 'lastResetDateEvening';
  final String _countsKey = 'eveningCounts';

  @override
  void initState() {
    super.initState();
    _initializeCounts();
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateItems());
    _prefetchCloudAudio();
  }

  Future<void> _initializeCounts() async {
    _prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Load last reset date
    final lastResetString = _prefs.getString(_prefsKey);
    DateTime? storedResetDate;

    if (lastResetString != null) {
      storedResetDate = DateTime.parse(lastResetString);
      storedResetDate = DateTime(storedResetDate.year, storedResetDate.month, storedResetDate.day);
    }

    // Check if we need to reset (new day)
    if (storedResetDate == null || storedResetDate.isBefore(today)) {
      debugPrint('Resetting evening counts - new day detected');
      await _resetCounts();
      await _prefs.setString(_prefsKey, today.toString());
      lastResetDate = today;
    } else {
      // Load saved counts if available
      final savedCounts = _prefs.getStringList(_countsKey);
      if (savedCounts != null && savedCounts.length == maxCounts.length) {
        currentCounts = savedCounts.map((e) => int.parse(e)).toList();
      } else {
        currentCounts = List<int>.from(maxCounts);
      }
      lastResetDate = storedResetDate;
    }

    setState(() {});
  }

  Future<void> _resetCounts() async {
    currentCounts = List<int>.from(maxCounts);
    await _saveCounts();
  }

  Future<void> _saveCounts() async {
    await _prefs.setStringList(
      _countsKey,
      currentCounts.map((e) => e.toString()).toList(),
    );
  }

  Future<void> _decrementCount(int index) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Re-check date in case app was running across midnight
    if (lastResetDate.isBefore(today)) {
      await _initializeCounts(); // This will handle the reset
      return;
    }

    if (currentCounts[index] > 0) {
      setState(() {
        currentCounts[index]--;
      });
      await _saveCounts();
    }
  }

  void _animateItems() async {
    for (int i = 0; i < athkarEvening.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      _listKey.currentState?.insertItem(i);
    }
  }


  Future<void> _prefetchCloudAudio() async {
    for (int i = 0; i < maxCounts.length; i++) {
      final cloudUrl = AudiosFiles.cloudAudioUrlForEvening(i);
      if (cloudUrl == null) continue;
      await _downloadAudioIfNeeded(i, cloudUrl);
    }
  }

  Future<String?> _downloadAudioIfNeeded(int index, String cloudUrl) async {
    if (_downloadedAudioPaths[index] != null) return _downloadedAudioPaths[index];

    try {
      final dir = await getApplicationDocumentsDirectory();
      final cacheDir = Directory('${dir.path}/athkar_audio_cache');
      if (!await cacheDir.exists()) {
        await cacheDir.create(recursive: true);
      }

      final file = File('${cacheDir.path}/evening_$index.mp3');
      if (!await file.exists() || await file.length() == 0) {
        final response = await http.get(Uri.parse(cloudUrl));
        if (response.statusCode != 200) return null;
        await file.writeAsBytes(response.bodyBytes, flush: true);
      }

      _downloadedAudioPaths[index] = file.path;
      return file.path;
    } catch (_) {
      return null;
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "أذكار المساء",
          style: GoogleFonts.tajawal(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: theme.colorScheme.primary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.nights_stay_rounded,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.colorScheme.surface.withOpacity(0.8),
                    theme.colorScheme.surface,
                  ],
                )
              : null,
          color: isDarkMode ? theme.colorScheme.surface : theme.colorScheme.surface,
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: AnimatedList(
            key: _listKey,
            controller: _scrollController,
            initialItemCount: 0,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            itemBuilder: (context, index, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.5),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutQuart,
                  )),
                  child: _buildThikrCard(context, index),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildThikrCard(BuildContext context, int index) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => _decrementCount(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? LinearGradient(
                  colors: [Color(0xFF2E2E2E), Color(0xFF1C1C1C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [Color(0xFFEAF2F8), Color(0xFFDFECF2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.nights_stay_rounded,
                      color: isDarkMode
                          ? theme.colorScheme.primary.withOpacity(0.65)
                          : theme.colorScheme.surface),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: currentCounts[index] == 0
                          ? Colors.green.withOpacity(0.65)
                          : theme.colorScheme.primary.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      currentCounts[index] == 0
                          ? "تم"
                          : "${currentCounts[index]} ",
                      style: GoogleFonts.tajawal(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                athkarEvening[index],
                style: GoogleFonts.tajawal(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  height: 1.8,
                  color: isDarkMode ? Colors.white : theme.colorScheme.surface,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                athkarInfo[index],
                style: GoogleFonts.tajawal(
                  fontSize: 14,
                  color: isDarkMode ? Colors.grey[300] : Colors.grey[800],
                ),
              ),
              Divider(
                  height: 20,
                  color: theme.colorScheme.primary.withOpacity(0.2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      _currentlyPlayingIndex == index && _isPlaying
                          ? Icons.stop_rounded
                          : Icons.volume_up_rounded,
                      color: isDarkMode
                          ? theme.colorScheme.primary.withOpacity(0.65)
                          : theme.colorScheme.surface,
                    ),
                    onPressed: () async {
                      if (_currentlyPlayingIndex == index && _isPlaying) {
                        await _audioPlayer.stop();
                        setState(() {
                          _isPlaying = false;
                          _currentlyPlayingIndex = null;
                        });
                      } else {
                        if (_isPlaying) {
                          await _audioPlayer.stop();
                        }

                        if (AudiosFiles.audioFiles2[index] != null) {
                          final cloudUrl = AudiosFiles.cloudAudioUrlForEvening(index);
                          final localCachedPath = cloudUrl == null
                              ? null
                              : await _downloadAudioIfNeeded(index, cloudUrl);
                          try {
                            if (localCachedPath != null) {
                              await _audioPlayer.play(DeviceFileSource(localCachedPath));
                            } else if (cloudUrl != null) {
                              await _audioPlayer.play(UrlSource(cloudUrl));
                            } else {
                              await _audioPlayer.play(
                                  AssetSource(AudiosFiles.audioFiles2[index]!));
                            }
                          } catch (_) {
                            await _audioPlayer.play(
                                AssetSource(AudiosFiles.audioFiles2[index]!));
                          }

                          setState(() {
                            _isPlaying = true;
                            _currentlyPlayingIndex = index;
                          });

                          _audioPlayer.onPlayerComplete.listen((_) {
                            if (mounted) {
                              setState(() {
                                _isPlaying = false;
                                _currentlyPlayingIndex = null;
                              });
                            }
                          });
                        }
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}