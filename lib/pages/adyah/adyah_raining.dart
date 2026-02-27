import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdyahRaining extends StatefulWidget {
  const AdyahRaining({super.key});

  @override
  State<AdyahRaining> createState() => _AdyahRainingState();
}

class _AdyahRainingState extends State<AdyahRaining>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  final List<String> adyahAlmatar = [
  "اللهم صيباً نافعاً",
  "اللهم صيباً هنيئاً مريئاً",
  "اللهم اسقنا غيثاً مغيثاً مريئاً نافعاً غير ضار",
  "اللَّهُمَّ حَوَالَيْنَا وَلاَ عَلَيْنَا، اللَّهُمَّ عَلَى الآكَامِ وَالظِّرَابِ، وَبُطُونِ الأَوْدِيَةِ، وَمَنَابِتِ الشَّجَرِ",
  "اللهم لا تقتلنا بغضبك، ولا تهلكنا بعذابك، وعافنا قبل ذلك",
  "اللهم اكرمنا واسترنا وارزقنا واحفظنا يا رب العالمين",
  "اللَّهُمَّ اسْقِ عِبادَك وبهائمَك، وانشُرْ رحمتَك، وأحيِ بلدَك الميِّتَ",
  "اللهم اجعل هذه الأمطار بركة وخيراً لنا، وارزقنا معها الرضا، واجعلنا لك شاكرين حامدين ذاكرين طائعين، واجعلنا من أوليائك الصالحين",
  "سبحانَ الذي يسبحُ الرعدُ بحمدِه والملائكةُ من خيفتِه",
  "مُطرنا بفضل الله ورحمته",
  "اللهم أنت الله لا إله إلا أنت الغني ونحن الفقراء، أنزل علينا الغيث، واجعل ما أنزلت لنا قوة وبلاغاً إلى حين",
  "اللهم إني أسألك خيرها وخير ما فيها وخير ما أُرسلت به، وأعوذ بك من شرها وشر ما فيها وشر ما أُرسلت به",
  "اللهم سقيا رحمة لا سقيا عذاب ولا بلاء ولا هدم ولا غرق",
  "اللهم اجعلها أمطار خير وبركة، ولا تجعلها أمطار ضرر وهلاك",
  "اللهم اجعلها رحمةً ولا تجعلها نقمة، اللهم لا تجعلها عذاباً ولا بلاء",
  "اللهم أغثنا، اللهم أغثنا، اللهم أغثنا",
  "اللهم أنبت لنا الزرع، وأدر لنا الضرع، واسقنا من بركات السماء",
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
                            "أدعية المطر",
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
                    itemCount: adyahAlmatar.length,
                    itemBuilder: (context, index) {
                      final animation = CurvedAnimation(
                        parent: _controller,
                        curve: Interval(
                          (index / adyahAlmatar.length),
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
                          child: _buildCard(adyahAlmatar[index]),
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