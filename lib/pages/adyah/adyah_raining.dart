import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdyahRaining extends StatefulWidget {
  const AdyahRaining({super.key});

  @override
  State<AdyahRaining> createState() => _AdyahRainingState();
}

class _AdyahRainingState extends State<AdyahRaining> {
  
  
      final List<String> adyahAlmatar = [
  "اللهم صيباً نافعاً، اللهم صيباً هنيئاً",
  "اللهم اسقنا غيثاً مغيثاً مريئاً نافعا",
  "اللَّهُمَّ حَوَالَيْنَا وَلاَ عَلَيْنَا، اللَّهُمَّ عَلَى الآكَامِ وَالظِّرَابِ، وَبُطُونِ الأَوْدِيَةِ، وَمَنَابِتِ الشَّجَرِ",
  "اللهم لا تقتلنا بغضبك، ولا تهلكنا بعذابك، وعافنا قبل ذلك",
  "اللهم اكرمنا واسترنا وارزقنا واحفظنا يا رب العالمين",
  "اللَّهمَّ اسْقِ عِبادَك وبهائمَك، وانشُرْ رحْمتَك، وأَحْيِ بلدَك الميِّتَ",
  "اللهم اجعل هذه الأمطار بركة وخير لنا، وارزقنا معها الرضا واجعلنا لك شاكرين، حامدين، ذاكرين، طائعين، واجعلنا يا إلهي من أوليائك الصالحين",
  "سبحانَ الذي يسبحُ الرعدُ بحمدِه والملائكةُ من خيفتِه",
  "مُطرنا بفضل الله ورحمته"
   "اللهم أنت الله لا إله إلا أنت الغني ونحن الفقراء، أنزل علينا الغيث، واجعل ما أنزلت لنا قوة وبلاغًا إلى حين، اللهم إني أسألك خيرها وخير ما فيها، وخير ما أُرسلت به، وأعوذ بك من شرها، وشر ما فيها، وشر ما أُرسلت به، اللهم لا تقتلنا بغضبك، ولا تهلكنا بعذابك، وعافنا قبل ذلك، سبحان الذي يسبح الرعد بحمده والملائكة من خيفته",
];

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateItems());
  }

  void _animateItems() async {
    for (int i = 0; i < adyahAlmatar.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      _listKey.currentState?.insertItem(i);
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "أدعية المطر",
          style: GoogleFonts.tajawal(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : theme.colorScheme.inversePrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDarkMode ? Colors.white : theme.colorScheme.inversePrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
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
                    theme.colorScheme.surface,
                  ],
                )
              : null,
          color: isDarkMode ? theme.colorScheme.surface : theme.colorScheme.surface,
        ),
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
                child: _buildDuaCard(context, index),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDuaCard(BuildContext context, int index) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color.fromARGB(255, 90, 90, 90) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isDarkMode
            ? null
            : [
                BoxShadow(
                  color: theme.colorScheme.primary,
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          title: Text(
            adyahAlmatar[index],
            textAlign: TextAlign.start,
            style: GoogleFonts.tajawal(
              fontSize: 20,
              height: 1.6,
              color: isDarkMode ? Colors.white : theme.colorScheme.surface,
            ),
          ),
        ),
      ),
    );
  }
}