import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdyahAlsafar extends StatefulWidget {
  const AdyahAlsafar({super.key});

  @override
  State<AdyahAlsafar> createState() => _AdyahAlsafarState();
}

class _AdyahAlsafarState extends State<AdyahAlsafar>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  
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

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))
          ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              colors: [
                Color(0xFF0D1B2A),
                Color(0xFF1B263B),
                Color(0xFF2C3E50),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [

                /// ===== HEADER =====
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Center(
                          child: Text(
                            "أدعية السفر",
                            style: GoogleFonts.amiri(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                ),

                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  color: Colors.white.withOpacity(0.1),
                ),

                const SizedBox(height: 16),

                /// ===== CONTENT =====
                Expanded(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: adyahAlsafar.length,
                    itemBuilder: (context, index) {
                      final animation = CurvedAnimation(
                        parent: _controller,
                        curve: Interval(
                          (index / adyahAlsafar.length),
                          1.0,
                          curve: Curves.easeOut,
                        ),
                      );

                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.05),
                            end: Offset.zero,
                          ).animate(animation),
                          child: _buildCard(adyahAlsafar[index]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String dua) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white.withOpacity(0.08),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Text(
        dua,
        textAlign: TextAlign.justify,
        style: GoogleFonts.amiri(
          fontSize: 22,
          height: 1.9,
          color: Colors.white.withOpacity(0.95),
        ),
      ),
    );
  }
}