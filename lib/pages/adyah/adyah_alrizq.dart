import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdyahAlrizq extends StatefulWidget {
  const AdyahAlrizq({super.key});

  @override
  State<AdyahAlrizq> createState() => _AdyahAlrizqState();
}

class _AdyahAlrizqState extends State<AdyahAlrizq>
    with TickerProviderStateMixin {
  late AnimationController _controller;

    final List<String> adyahAlrizq = [
  "اللَّهُمَّ لا مَانِعَ لِما أعْطَيْتَ، ولَا مُعْطِيَ لِما مَنَعْتَ، ولَا يَنْفَعُ ذَا الجَدِّ مِنْكَ الجد",
  "اللهم إني أعوذُ بكَ منَ الهمِّ والحزَنِ، وأعوذُ بكَ منَ العجزِ والكسلِ، وأعوذُ بكَ منَ الجُبنِ والبخلِ؛ وأعوذُ بكَ مِن غلبةِ الدَّينِ وقهرِ الرجالِ",
  "اللهمَّ مالكَ الملكِ تُؤتي الملكَ مَن تشاء، وتنزعُ الملكَ ممن تشاء، وتُعِزُّ مَن تشاء، وتذِلُّ مَن تشاء، بيدِك الخيرُ إنك على كلِّ شيءٍ قدير، رحمنُ الدنيا والآخرةِ ورحيمُهما، تعطيهما من تشاء، وتمنعُ منهما من تشاء، ارحمْني رحمةً تُغنيني بها عن رحمةِ مَن سواك",
  "اللهم أَغْنِني من الفقرِ واقضِ عني الدَّينَ وتوفّني في عبادتِك وجهادٍ في سبيلِك",
  "اللهم إن كان رزقي في السّماء فأنزله، وإن كان في الأرض فأخرجه، وإن كان بعيداً فقرّبه، وإن كان قريباً فيسّره، وإن كان قليلاً فكثّره، وإن كان كثيراً فبارك لي فيه",
  "اللهم رب السموات السبع، ورب العرش العظيم، اقض عنا الدين وأغننا من الفقر",
  "اللهم صل على سيدنا محمد، وعلى آل محمد، يا ذا الجلال والإكرام، يا قاضي الحاجات، يا أرحم الراحمين، يا حي يا قيوم، لا إله إلا أنت الملك الحق المبين",
  "اللهم اكفني وأغنني بحلالك عن حرامك، وأغنني بفضلك عمن سواك",
  "يا الله، يا رب، يا حي يا قيوم، يا ذا الجلال والإكرام، أسألك باسمك العظيم الأعظم أن ترزقني رزقاً واسعاً حلالاً طيباً، برحمتك يا أرحم الراحمين",
  "اللهم ارزقنا رزقا حلالا طيبا مباركا فيه كما تحب وترضى يا رب العالمين",
  "حسبنا الله سيؤتينا من فضله إنا إلى الله لراغبون",
  "اللهم يا رازق السائلين، يا راحم المساكين، ويا ذا القوة المتين، ويا خير الناصرين، يا ولي المؤمنين، يا غيّاث المستغيثين، إياك نعبد وإيّاك نستعين، اللهم إني أسألك رزقاً واسعاً طيباً من رزقك",
  "يا مقيل العثرات، يا قاضي الحاجات، اقض حاجتي، وفرج كربتي، وارزقني من حيث لا أحتسب",
  "اللهم أغننا بحلالك عن حرامك، وتولّنا فأنت أرحم الراحمين",
  "يا واصل المنقطعين أوصلنا إليك، ويا جابر المنكسرين اجعل حاجتنا إليك، وأغننا بالافتقار إليك، ولا تفقرنا بالاستغناء عنك"
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
                            "أدعية الرزق",
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
                    itemCount: adyahAlrizq.length,
                    itemBuilder: (context, index) {
                      final animation = CurvedAnimation(
                        parent: _controller,
                        curve: Interval(
                          (index / adyahAlrizq.length),
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
                          child: _buildCard(adyahAlrizq[index]),
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