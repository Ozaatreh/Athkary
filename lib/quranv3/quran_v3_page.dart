import 'dart:async';
import 'package:athkary/quranv3/quran_v3_models.dart';
import 'package:athkary/quranv3/quran_v3_service.dart';
import 'package:athkary/quranv3/tajweed_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuranV3Page extends StatefulWidget {
  const QuranV3Page({super.key});

  @override
  State<QuranV3Page> createState() => _QuranV3PageState();
}

class _QuranV3PageState extends State<QuranV3Page> {
  final QuranV3Service _service = QuranV3Service();
  final TextEditingController _searchController = TextEditingController();

  List<SurahLite> _allSurahs = [];
  List<SurahLite> _filteredSurahs = [];
  final Map<int, List<SurahLite>> _juzSurahs = {};
  final Set<int> _loadingJuz = <int>{};
  Set<String> _favoritePages = <String>{};

  bool _isLoading = true;
  String _status = '';

  @override
  void initState() {
    super.initState();
    _boot();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _boot() async {
    try {
      final surahs = await _service.getSurahs();
      final prefs = await SharedPreferences.getInstance();
      final savedFavorites =
          prefs.getStringList('quranv3_favorite_pages') ?? [];
      if (!mounted) return;
      setState(() {
        _allSurahs = surahs;
        _filteredSurahs = surahs;
        _favoritePages = savedFavorites.toSet();
        _isLoading = false;
      });
      await _loadJuz(1);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _status = 'تعذر تحميل بيانات القرآن: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark
        ? const [Color(0xFF061B1A), Color(0xFF0A2E28), Color(0xFF102E2A)]
        : const [Color.fromARGB(255, 23, 63, 24), Color.fromARGB(255, 99, 137, 105), Color.fromARGB(255, 24, 162, 51)];

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: background,
            ),
          ),
          child: SafeArea(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      _buildHeader(isDark),
                      _buildSearch(isDark),
                      Expanded(child: _buildJuzOrSearchList(isDark)),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    final textColor = isDark ? Colors.white : const Color.fromARGB(255, 229, 233, 232);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon:
                    Icon(Icons.arrow_back_ios_new, color: textColor, size: 30),
              ),
              const Spacer(),
              IconButton(
                onPressed: _openBookmarksSheet,
                icon: Icon(
                  Icons.bookmark_rounded,
                  color: _favoritePages.isEmpty ? textColor : Colors.amber,
                  size: 28,
                ),
              ),
            ],
          ),
          Text(
            'بِسْمِ اللهِ الرَّحْمٰنِ الرَّحِيمِ',
            style: GoogleFonts.amiri(
              fontSize: 34,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'القرآن الكريم',
            style: GoogleFonts.amiri(
              fontSize: 40,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Holy Quran',
            style: GoogleFonts.cormorantGaramond(
              letterSpacing: 3,
              fontSize: 25,
              color: textColor.withOpacity(0.6),
            ),
          ),
          if (_status.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(_status, style: TextStyle(color: textColor)),
            ),
        ],
      ),
    );
  }

  Widget _buildSearch(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: TextField(
        controller: _searchController,
        onChanged: _searchSurah,
        decoration: InputDecoration(
          hintText: 'ابحث عن سورة...',
          prefixIcon: const Icon(Icons.search_rounded),
          filled: true,
          fillColor: isDark ? Colors.white10 : Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildJuzOrSearchList(bool isDark) {
    final isSearching = _searchController.text.trim().isNotEmpty;
    if (isSearching) {
      return ListView.builder(
        padding: const EdgeInsets.fromLTRB(14, 6, 14, 16),
        itemCount: _filteredSurahs.length,
        itemBuilder: (_, index) {
          final surah = _filteredSurahs[index];
          return Card(
            color: isDark ? Colors.white10 : Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: ListTile(
              title: Text('سورة ${surah.name}',
                  style: GoogleFonts.amiri(fontSize: 30)),
              subtitle: Text(
                '${surah.englishName} • ${surah.numberOfAyahs} آية',
                style: GoogleFonts.cormorantGaramond(fontSize: 22),
              ),
              trailing: CircleAvatar(child: Text('${surah.number}')),
              onTap: () => _openReader(surah.number, surah.name),
            ),
          );
        },
      );
    }

    final source = List.generate(30, (i) => i + 1);
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(14, 6, 14, 16),
      itemCount: source.length,
      itemBuilder: (_, index) {
        final juz = source[index];
        final surahs = _juzSurahs[juz] ?? [];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.white.withOpacity(0.84),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
                color: isDark ? Colors.white30 : const Color(0xFF92A89B)),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              initiallyExpanded: juz == 1,
              onExpansionChanged: (expanded) async {
                if (expanded) await _loadJuz(juz);
              },
              leading: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white.withOpacity(0.85),
                child: Text('$juz', style: GoogleFonts.amiri(fontSize: 26)),
              ),
              title: Text(
                'الجزء $juz',
                style: GoogleFonts.amiri(
                    fontSize: 32, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Juz $juz • ${surahs.length} سور',
                style: GoogleFonts.cormorantGaramond(fontSize: 24),
              ),
              children: [
                if (_loadingJuz.contains(juz))
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  )
                else
                  ...surahs.map(
                    (surah) => Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Text('${surah.number}'),
                          ),
                          title: Text(
                            'سورة ${surah.name}',
                            style: GoogleFonts.amiri(fontSize: 30),
                          ),
                          subtitle: Text(
                            '${surah.englishName} • ${surah.numberOfAyahs} آية',
                            style: GoogleFonts.cormorantGaramond(fontSize: 23),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded),
                          onTap: () => _openReader(surah.number, surah.name),
                        ),
                        if (surah != surahs.last) const Divider(height: 1),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _openBookmarksSheet() async {
    final sorted = _favoritePages.toList()..sort();
    if (sorted.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لا توجد صفحات محفوظة بعد')));
      return;
    }

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: sorted.length,
          itemBuilder: (_, i) {
            final key = sorted[i];
            final parts = key.split(':');
            final surah = int.tryParse(parts.first) ?? 1;
            final page = parts.length > 1 ? int.tryParse(parts[1]) ?? 1 : 1;
            final matched = _allSurahs.where((s) => s.number == surah).toList();
            final surahName = matched.isNotEmpty ? matched.first.name : '';
            return ListTile(
              leading: const Icon(Icons.bookmark_rounded),
              title: Text(
                surahName.isEmpty ? 'سورة غير معروفة' : 'سورة $surahName',
                style: GoogleFonts.amiri(fontSize: 26),
              ),
              subtitle: Text('الصفحة $page'),
              onTap: () {
                Navigator.pop(context);
                _openReader(surah, surahName, initialPage: page);
              },
            );
          },
        );
      },
    );
  }

  void _searchSurah(String query) {
    final value = query.trim();
    setState(() {
      if (value.isEmpty) {
        _filteredSurahs = _allSurahs;
      } else {
        _filteredSurahs = _allSurahs.where((s) {
          return s.name.contains(value) ||
              s.englishName.toLowerCase().contains(value.toLowerCase()) ||
              s.number.toString() == value;
        }).toList();
      }
    });
  }

  Future<void> _loadJuz(int juz) async {
    if (_juzSurahs.containsKey(juz) || _loadingJuz.contains(juz)) return;

    setState(() => _loadingJuz.add(juz));
    try {
      final ayahs = await _service.getJuz(juz);
      final map = <int, SurahLite>{};
      final Map<int, int> surahFirstPageInJuz = {};

      for (final ayah in ayahs) {
        final surahNumber = ayah.surah.number;

        if (!surahFirstPageInJuz.containsKey(surahNumber)) {
          surahFirstPageInJuz[surahNumber] = ayah.page;
        }

        map[surahNumber] = ayah.surah;
      }
      if (!mounted) return;
      setState(() => _juzSurahs[juz] = map.values.toList());
    } catch (_) {
      if (!mounted) return;
      setState(() => _status = 'تعذر تحميل الجزء $juz');
    } finally {
      if (!mounted) return;
      setState(() => _loadingJuz.remove(juz));
    }
  }

  Future<void> _openReader(int surah, String surahName,
      {int? initialPage}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuranV3ReaderPage(
          initialSurah: surah,
          initialSurahName: surahName,
          initialPage: initialPage,
        ),
      ),
    );
    await _boot();
  }
}
enum LoopModeType {
  none,
  selected,
  page,
}
class QuranV3ReaderPage extends StatefulWidget {
  const QuranV3ReaderPage({
    super.key,
    required this.initialSurah,
    required this.initialSurahName,
    this.initialPage,
  });

  final int initialSurah;
  final String initialSurahName;
  final int? initialPage;

  @override
  State<QuranV3ReaderPage> createState() => _QuranV3ReaderPageState();
}

class _QuranV3ReaderPageState extends State<QuranV3ReaderPage> {
  final QuranV3Service _service = QuranV3Service();
  final AudioPlayer _player = AudioPlayer();
  final ScrollController _scrollController = ScrollController();
  StreamSubscription<Duration>? _positionSub;

  final Map<String, String> _qareeMap = {
    'العفاسي': 'ar.alafasy',
    'عبدالباسط عبدالصمد': 'ar.abdulbasitmurattal',
    'ماهر المعيقلي': 'ar.mahermuaiqly',
    'هاني الرفاعي': 'ar.hanirifai',
  };

  final Map<String, Map<String, Color>> _palettes = {
    'classic': TajweedText.defaultColors,
    'emerald': {
      ...TajweedText.defaultColors,
      'q': const Color(0xFFE53935),
      'n': const Color(0xFF2E7D32),
      'p': const Color(0xFF1565C0),
      'g': const Color(0xFFFF8F00),
    },
    'night': {
      ...TajweedText.defaultColors,
      'q': const Color(0xFFFF5252),
      'n': const Color(0xFF82B1FF),
      'p': const Color(0xFF448AFF),
      'g': const Color(0xFFFFAB40),
    },
  };

  List<AyahItem> _pageAyahs = [];
  Set<int> _selectedAyahs = <int>{};
  Set<String> _favoritePages = <String>{};

  int _currentSurah = 1;
  String _currentSurahName = '';
  int _currentPage = 1;
  int _currentPlayIndex = 0;
  int? _currentlyPlayingAyahNumber;

  bool _loading = true;
  bool _showTajweed = true;
  double _fontSize = 34;
  String _fontFamily = 'Amiri';
  String _palette = 'classic';
  String _status = '';
  String _selectedQareeLabel = 'العفاسي';
  LoopModeType _loopMode = LoopModeType.none;
  bool _continuousNextPage = false;
 bool _transitioning = false;
  @override
  void initState() {
    super.initState();
    _currentSurah = widget.initialSurah;
    _currentSurahName = widget.initialSurahName;
    _positionSub = _player.positionStream.listen((position) {
      final duration = _player.duration;
      if (duration == null) return;

      if (position >= duration - const Duration(milliseconds: 120)) {
        _playNext();
      }
    });
    _loadPrefs();
    _loadInitialData();
  }

  @override
  void dispose() {
    _positionSub?.cancel();
    _player.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    final savedFavorites = prefs.getStringList('quranv3_favorite_pages') ?? [];
    final qaree = prefs.getString('quranv3_qaree_label') ?? 'العفاسي';

    if (!mounted) return;

    setState(() {
      _favoritePages = savedFavorites.toSet();
      _selectedQareeLabel = _qareeMap.containsKey(qaree) ? qaree : 'العفاسي';

      // ✅ Page settings
      _showTajweed = prefs.getBool('quranv3_show_tajweed') ?? true;
      _fontSize = prefs.getDouble('quranv3_font_size') ?? 34;
      _fontFamily = prefs.getString('quranv3_font_family') ?? 'Amiri';
      _palette = prefs.getString('quranv3_palette') ?? 'classic';
    });
  }

  Future<void> _saveReaderSettings() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('quranv3_show_tajweed', _showTajweed);
    await prefs.setDouble('quranv3_font_size', _fontSize);
    await prefs.setString('quranv3_font_family', _fontFamily);
    await prefs.setString('quranv3_palette', _palette);
  }

  Future<void> _saveQaree(String label) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('quranv3_qaree_label', label);
  }

  Future<void> _toggleFavoritePage() async {
    final key = '${_currentSurah}:${_currentPage}';
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_favoritePages.contains(key)) {
        _favoritePages.remove(key);
      } else {
        _favoritePages.add(key);
      }
    });
    await prefs.setStringList(
        'quranv3_favorite_pages', _favoritePages.toList());
  }

  Future<void> _loadInitialData() async {
    setState(() {
      _loading = true;
      _status = '';
      _selectedAyahs.clear();
      _currentPlayIndex = 0;
      _currentlyPlayingAyahNumber = null;
    });

    try {
      int page = widget.initialPage ?? 1;
      if (widget.initialPage == null) {
        final surahAyahs = await _service.getSurahAyahs(_currentSurah,
            edition: 'quran-tajweed');
        if (surahAyahs.isNotEmpty) {
          page = surahAyahs.first.page;
          _currentSurahName = surahAyahs.first.surah.name;
        }
      }
      await _loadPage(page, updateLoading: false);
      if (!mounted) return;
      setState(() => _loading = false);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _status = 'تعذر تحميل السورة: $e';
      });
    }
  }

  Future<void> _loadPage(int page, {bool updateLoading = true}) async {
    if (page < 1 || page > 604) return;
    if (updateLoading) {
      setState(() {
        _loading = true;
        _status = '';
      });
    }

    try {
      final ayahs = await _service.getPage(page, edition: 'quran-tajweed');
      if (!mounted) return;
      setState(() {
        _currentPage = page;
        _pageAyahs = ayahs;
        _currentSurah =
            ayahs.isNotEmpty ? ayahs.first.surah.number : _currentSurah;
        if (ayahs.isNotEmpty && ayahs.first.surah.name.trim().isNotEmpty) {
          _currentSurahName = ayahs.first.surah.name;
        }
        _loading = false;
        _selectedAyahs.clear();
        _currentPlayIndex = 0;
        _currentlyPlayingAyahNumber = null;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(0);
        }
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _status = 'تعذر تحميل الصفحة: $e';
      });
    }
  }

  int get _juzNumber => _pageAyahs.isNotEmpty ? _pageAyahs.first.juz : 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF081F45), Color(0xFF102A57), Color(0xFF1B325D)],
            ),
          ),
          child: SafeArea(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      _readerHeader(),
                      Expanded(
                        child: GestureDetector(
                          onHorizontalDragEnd: (details) async {
                            final v = details.primaryVelocity ?? 0;
                            if (v > 120) {
                              await _loadPage(_currentPage + 1);
                            } else if (v < -120) {
                              await _loadPage(_currentPage - 1);
                            }
                          },
                          child: _ayahList(),
                        ),
                      ),
                      _audioBar(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _readerHeader() {
    final favKey = '${_currentSurah}:${_currentPage}';
    final isFav = _favoritePages.contains(favKey);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: _openSettings,
                icon: const Icon(Icons.settings_rounded, color: Colors.white),
              ),
              IconButton(
                onPressed: _toggleFavoritePage,
                icon: Icon(
                  isFav
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  color: isFav ? Colors.amber : Colors.white,
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          Text(
            _currentSurahName.isEmpty ? 'سورة' : 'سورة $_currentSurahName',
            style: GoogleFonts.amiri(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'الجزء $_juzNumber • الصفحة $_currentPage',
            style: GoogleFonts.amiri(color: Colors.white70, fontSize: 22),
          ),
          if (_status.isNotEmpty)
            Text(_status,
                style: GoogleFonts.tajawal(color: Colors.red.shade200)),
        ],
      ),
    );
  }

  Widget _ayahList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 130),
      itemCount: _pageAyahs.length,
      itemBuilder: (_, i) {
        final ayah = _pageAyahs[i];
        final selected = _selectedAyahs.contains(ayah.number);
        final isReading = _currentlyPlayingAyahNumber == ayah.number;

        return GestureDetector(
          onTap: () => _toggleSelection(ayah.number),
          onLongPress: () => _copyAyah(ayah),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: selected
                  ? Colors.green.withOpacity(0.18)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: isReading
                  ? Border.all(color: Colors.amberAccent, width: 1.6)
                  : Border.all(color: Colors.transparent),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white70),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${ayah.numberInSurah}',
                    style: GoogleFonts.amiri(color: Colors.white, fontSize: 22),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _showTajweed
                      ? TajweedText(
                          text: ayah.text,
                          fontSize: _fontSize,
                          baseColor: Colors.white,
                          tajweedColors: _palettes[_palette],
                        )
                      : Text(
                          _stripTajweed(ayah.text),
                          textAlign: TextAlign.right,
                          style: GoogleFonts.getFont(
                            _fontFamily,
                            color: Colors.white,
                            fontSize: _fontSize,
                            height: 2,
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _audioBar() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _playPrevious,
            icon: const Icon(Icons.skip_previous_rounded,
                color: Colors.white, size: 40),
          ),
          InkWell(
            onTap: _togglePlayPause,
            child: Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                color: Color(0xFF2B2B2B),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _player.playing ? Icons.stop_rounded : Icons.play_arrow_rounded,
                color: Colors.white,
                size: 54,
              ),
            ),
          ),
          IconButton(
            onPressed: _playNext,
            icon: const Icon(Icons.skip_next_rounded,
                color: Colors.white, size: 40),
          ),
        ],
      ),
    );
  }

  void _toggleSelection(int ayahNumber) {
    setState(() {
      if (_selectedAyahs.contains(ayahNumber)) {
        _selectedAyahs.remove(ayahNumber);
      } else {
        _selectedAyahs.add(ayahNumber);
      }
    });
  }

  List<int> _queueIndexes() {
    if (_selectedAyahs.isEmpty) {
      return List<int>.generate(_pageAyahs.length, (i) => i);
    }
    final queue = <int>[];
    for (var i = 0; i < _pageAyahs.length; i++) {
      if (_selectedAyahs.contains(_pageAyahs[i].number)) {
        queue.add(i);
      }
    }
    return queue;
  }

  Future<void> _togglePlayPause() async {
    if (_player.playing) {
      await _player.stop();
      if (!mounted) return;

      setState(() {
        _currentlyPlayingAyahNumber = null;
      });

      return;
    }

    await _playIndex(
        _currentPlayIndex < _pageAyahs.length ? _currentPlayIndex : 0);
  }

  Future<void> _playIndex(int index) async {
    if (_pageAyahs.isEmpty) return;
    final queue = _queueIndexes();
    if (queue.isEmpty) return;

    if (!queue.contains(index)) {
      index = queue.first;
    }

    _currentPlayIndex = index;
    final ayah = _pageAyahs[index];
    final qareeId = _qareeMap[_selectedQareeLabel] ?? 'ar.alafasy';
    final url =
        'https://cdn.islamic.network/quran/audio/128/$qareeId/${ayah.number}.mp3';

    await _player.setUrl(url);
    await _player.play();
    if (!mounted) return;
    setState(() {
      _currentlyPlayingAyahNumber = ayah.number;
    });
  }

  Future<void> _playNext() async {
  final queue = _queueIndexes();
  if (queue.isEmpty) return;

  final currentPosition = queue.indexOf(_currentPlayIndex);

  if (currentPosition == -1) {
    await _playIndex(queue.first);
    return;
  }

  final next = currentPosition + 1;

  if (next < queue.length) {
    await _playIndex(queue[next]);
    return;
  }

  // ===== Reached end =====

  if (_loopMode == LoopModeType.selected ||
      _loopMode == LoopModeType.page) {
    await _playIndex(queue.first);
    return;
  }

  if (_continuousNextPage) {
    await _loadPage(_currentPage + 1);
    if (_pageAyahs.isNotEmpty) {
      await _playIndex(0);
    }
    return;
  }

  await _player.stop();
  if (!mounted) return;
  setState(() {
    _currentlyPlayingAyahNumber = null;
  });
}

  Future<void> _playPrevious() async {
    final queue = _queueIndexes();
    if (queue.isEmpty) return;
    final currentPosition = queue.indexOf(_currentPlayIndex);
    if (currentPosition <= 0) {
      await _playIndex(queue.first);
      return;
    }
    await _playIndex(queue[currentPosition - 1]);
  }

  Future<void> _copyAyah(AyahItem ayah) async {
    await Clipboard.setData(
      ClipboardData(
          text:
              '${_stripTajweed(ayah.text)}\n(${ayah.surah.name}:${ayah.numberInSurah})'),
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('تم نسخ الآية')));
  }

  String _stripTajweed(String value) {
    return value.replaceAllMapped(
        RegExp(r'\[(\w)(?::\d+)?\[(.*?)\]'), (m) => m.group(2) ?? '');
  }

  void _openSettings() {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final surface = theme.colorScheme.tertiary;

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (_, setSheetState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ===== TITLE =====
                    Text(
                      'إعدادات القراءة',
                      style: GoogleFonts.amiri(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: primary,
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// ===== TAJWEED TOGGLE =====
                    _sectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              'تفعيل ألوان التجويد',
                              style: GoogleFonts.tajawal(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            value: _showTajweed,
                            activeColor: primary,
                            onChanged: (v) {
                              setSheetState(() => _showTajweed = v);
                              setState(() {});
                              _saveReaderSettings();
                            },
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'إذا واجهت مشكلة في عرض القرآن (مثلاً ظهور أحرف إنجليزية داخل النص)، قم بإلغاء تفعيل الألوان.',
                            style: GoogleFonts.tajawal(
                              fontSize: 13,
                              color: theme.textTheme.bodySmall?.color
                                  ?.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// ===== FONT SIZE =====
                    _sectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'حجم الخط',
                            style: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: primary,
                              thumbColor: primary,
                              overlayColor: primary.withOpacity(0.15),
                            ),
                            child: Slider(
                              value: _fontSize,
                              min: 24,
                              max: 50,
                              divisions: 13,
                              label: _fontSize.toInt().toString(),
                              onChanged: (v) {
                                setSheetState(() => _fontSize = v);
                                setState(() {});
                                _saveReaderSettings();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// ===== FONT TYPE =====
                    _sectionCard(
                      child: _dropdownRow(
                        title: 'نوع الخط',
                        value: _fontFamily,
                        items: const [
                          'Amiri',
                          'Tajawal',
                          'Cairo',
                          'Scheherazade New',
                        ],
                        onChanged: (value) {
                          if (value == null) return;
                          setSheetState(() => _fontFamily = value);
                          setState(() {});
                          _saveReaderSettings();
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// ===== QAREE =====
                    _sectionCard(
                      child: _dropdownRow(
                        title: 'القارئ',
                        value: _selectedQareeLabel,
                        items: _qareeMap.keys.toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setSheetState(() => _selectedQareeLabel = value);
                          _saveQaree(value);
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

_sectionCard(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Text(
        'وضع التكرار',
        style: GoogleFonts.tajawal(
          fontWeight: FontWeight.w600,
        ),
      ),

      const SizedBox(height: 10),

      RadioListTile<LoopModeType>(
        title: const Text('بدون تكرار'),
        value: LoopModeType.none,
        groupValue: _loopMode,
        onChanged: (v) {
          setSheetState(() => _loopMode = v!);
          setState(() {});
        },
      ),

      RadioListTile<LoopModeType>(
        title: const Text('تكرار المحدد فقط'),
        value: LoopModeType.selected,
        groupValue: _loopMode,
        onChanged: (v) {
          setSheetState(() => _loopMode = v!);
          setState(() {});
        },
      ),

      RadioListTile<LoopModeType>(
        title: const Text('تكرار الصفحة كاملة'),
        value: LoopModeType.page,
        groupValue: _loopMode,
        onChanged: (v) {
          setSheetState(() => _loopMode = v!);
          setState(() {});
        },
      ),

      const Divider(),

      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('تشغيل مستمر للصفحة التالية'),
        subtitle: const Text(
          'عند انتهاء الصفحة ينتقل للصفحة التالية تلقائياً',
        ),
        value: _continuousNextPage,
        onChanged: (v) {
          setSheetState(() => _continuousNextPage = v);
          setState(() {});
        },
      ),
    ],
  ),
),
                    const SizedBox(height: 16),
                    
                    /// ===== TAJWEED PALETTES =====
                    _sectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ألوان التجويد',
                            style: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _palettes.keys.map((key) {
                              final selected = _palette == key;

                              return ChoiceChip(
                                label: Text(key),
                                selected: selected,
                                selectedColor: primary.withOpacity(0.15),
                                labelStyle: TextStyle(
                                  color: selected
                                      ? primary
                                      : theme.textTheme.bodyMedium?.color,
                                  fontWeight: selected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                                side: BorderSide(
                                  color: selected
                                      ? primary
                                      : primary.withOpacity(0.2),
                                ),
                                onSelected: (_) {
                                  setSheetState(() => _palette = key);
                                  setState(() {});
                                  _saveReaderSettings();
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// ===== ACTIONS =====
                    _sectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'اختصارات التحديد',
                            style: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 10,
                            children: [
                              OutlinedButton(
                                onPressed: _copySelected,
                                child: const Text('نسخ المحدد'),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  setSheetState(() => _selectedAyahs.clear());
                                  setState(() {});
                                },
                                child: const Text('مسح التحديد'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _sectionCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
        ),
      ),
      child: child,
    );
  }

  Widget _dropdownRow({
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.tajawal(
            fontWeight: FontWeight.w600,
          ),
        ),
        DropdownButton<String>(
          value: value,
          underline: const SizedBox(),
          items: items
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Future<void> _copySelected() async {
    final selected =
        _pageAyahs.where((a) => _selectedAyahs.contains(a.number)).toList();
    if (selected.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('لا يوجد تحديد')));
      return;
    }
    final text = selected
        .map((a) =>
            '${_stripTajweed(a.text)}\n(${a.surah.name}:${a.numberInSurah})')
        .join('\n\n');
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('تم نسخ الآيات المحددة')));
  }
}
