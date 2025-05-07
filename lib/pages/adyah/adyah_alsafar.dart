import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdyahAlsafar extends StatefulWidget {
  const AdyahAlsafar({super.key});

  @override
  State<AdyahAlsafar> createState() => _AdyahAlsafarState();
}

class _AdyahAlsafarState extends State<AdyahAlsafar> {
  
      final List<String> adyahAlsafar = [
  "اللهمّ احفظني في سفري، واجعلني من المقبولين عندك، وارزقني التوفيق والنجاح",
  "اللهمّ احفظ أهلي ومالي، واحفظني من كل سوء",
  "اللهمّ احفظني في سفري وأكتب لي السلامة مما لا أعلمه",
  "اللهمّ احفظ أهلي ومالي، واحفظني من كل سوء",
  "اللهمّ أن كانت لي دعوة مستجابة في سفري فاكتب لي الحفظ من كل شر واحفظ اهلي واحبتي في غيابي",
  "اللهمّ احفظ اولادي في سفري استودعتك إياهم ونفسي فردني اليهم سالما معافى ولا تبتليني فيهم",
  "اللهم يا ذا الركن الشديد والأمر الرشيد أسألك أن تيسر أمري وتحفظني في سفري وتردني إلى اهلي سالما معافى",
  "اللهمّ اجعل سفري خالصًا لوجهك الكريم، واجعلني من المخلصين في أعمالي",
  "يا رب ارزقنا في سفرنا هذا البر والتقوى ووسع لنا فيه الرزق واطو عنا بعده",
  "بسم الله توكلت على الله، اللهُمَّ أنتَ الْصَاحِبُ فِي السَّفَرِ، وَالْخَلِيفَةُ فِي الْأَهْلِ",
  "الله أكبر الله أكبر الله أكبر، سُبْحَانَ الَّذِي سَخَّرَ لَنَا هَذَا وَمَا كُنَّا لَهُ مُقْرِنِينَ، وَإِنَّا إِلَى رَبِّنَا لَمُنْقَلِبُونَ",
  "يا رب أسألك في سفري هذا الْبِرَّ وَالتَّقْوَى، وَمِنَ الْعَمَلِ مَا تَرْضَى.",
  "يا رب احمنا مِنْ وعثَاءِ السَّفَرِ، وكَآبَةِ الْمَنْظَرِ، وَسُوءِ الْمُنْقَلَبِ فِي الْمَالِ وَالْأَهْلِ",
  "اللهم ارزقنا في سفرنا هذا أمنًا وسلامة ورزقًا طيبًا وعودًا حميدًا.",
  "اللهم اجعل التوفيق حليفنا في سفرنا هذا ويسر لنا طريقنا، وجنبنا من كل سوء",
  "اللهم أنت الصاحب في السفر والخليفة في الأهل، توكلت على الله ولا حول ولا قوة إلا بالله",
  "يا رب استودعتك روحي ونفسي وجسدي فردني إلى أهلي سالمًا وأعوذ بك من وعثاء السفر"
];

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateItems());
  }

  void _animateItems() async {
    for (int i = 0; i < adyahAlsafar.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      _listKey.currentState?.insertItem(i);
      // await _scrollController.animateTo(
      //   _scrollController.position.maxScrollExtent,
      //   duration: const Duration(milliseconds: 300),
      //   curve: Curves.easeOut,
      // );
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
          "أدعية السفر",
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
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Text(
          adyahAlsafar[index],
          textAlign: TextAlign.right,
          style: GoogleFonts.amiri(
            fontSize: 20,
            height: 1.6,
            color: isDarkMode ? Colors.white : theme.colorScheme.surface,
          ),
        ),
      ),
    );
  }
}