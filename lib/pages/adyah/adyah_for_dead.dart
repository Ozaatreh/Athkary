import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdyahForDead extends StatefulWidget {
  const AdyahForDead({super.key});

  @override
  State<AdyahForDead> createState() => _AdyahForDeadState();
}

class _AdyahForDeadState extends State<AdyahForDead>
    with TickerProviderStateMixin {
  late AnimationController _controller;

      final List adyahfordead = [
    "اللَّهُمَّ أبدله داراً خيراً من داره، وأهلاً خيراً من أهله، وأدخله الجنّة، وأعذه من عذاب القبر ومن عذاب النّار",
    "اللَّهُمَّ عامله بما أنت أهله، ولا تعامله بما هو أهله",
    "اللَّهُمَّ اجزه عن الإحسان إحساناً وعن الإساءة عفواً وغفراناً",
    "اللَّهُمَّ إن كان محسناً فزد من حسناته، وإن كان مسيئاً فتجاوز عن سيّئاته",
    "اللَّهُمَّ أدخله الجنّة من غير مناقشة حساب ولا سابقة عذاب",
    "اللَّهُمَّ آنسه في وحدته وفي وحشته وفي غربته",
    "اللَّهُمَّ أنزله منزلاً مباركاً وأنت خير المنزلين",
    "اللَّهُمَّ أنزله منازل الصدّيقين والشّهداء والصّالحين، وحسن أولئك رفيقاً",
    "اللَّهُمَّ اجعل قبره روضةً من رياض الجنّة، ولا تجعله حفرةً من حفر النّار",
    "اللَّهُمَّ افسح له في قبره مدّ بصره، وافرش قبره من فراش الجنّة",
    "اللَّهُمَّ أعذه من عذاب القبر، وجفاف ِالأرض عن جنبيها",
    "اللَّهُمَّ املأ قبره بالرّضا والنّور والفسحة والسّرور",
    "اللَّهُمَّ إنّه في ذمّتك وحبل جوارك، فقِهِِ فتنة القبر، وعذاب النّار، وأنت أهل الوفاء والحقّ، فاغفر له وارحمه إنّك أنت الغفور الرّحيم.",
    "اللَّهُمَّ إنّه عبدك وابن عبدك خرج من الدّنيا وسعتها ومحبوبها وأحبّائه فيها إلى ظلمة القبر وما هو لاقيه",
    "اللَّهُمَّ إنّه كان يشهد أنّك لا إله إلّا أنت وأنّ محمّداً عبدك ورسولك وأنت أعلم به",
    "اللَّهُمَّ إنّا نتوسّل بك إليك، ونقسم بك عليك أن ترحمه ولا تعذّبه، وأن تثبّته عند السؤال",
    "اللَّهُمَّ إنّه نَزَل بك وأنت خير منزولٍ به، وأصبح فقيراً إلى رحمتك وأنت غنيٌّ عن عذابه",
    "اللَّهُمَّ آته برحمتك ورضاك، وقهِ فتنة القبر وعذابه، وآته برحمتك الأمن من عذابك حتّى تبعثه إلى جنّتك يا أرحم الرّاحمين",
    "اللَّهُمَّ انقله من مواطن الدّود وضيق اللحود إلى جنّات الخلود",
    "اللَّهُمَّ احمه تحت الأرض، واستره يوم العرض، ولا تخزه يوم يبعثون يوم لا ينفع مالٌ ولا بنون إلّا من أتى الله بقلبٍ سليم",
    "اللَّهُمَّ يمّن كتابه، ويسّر حسابه، وثقّل بالحسنات ميزانه، وثبّت على الصّراط أقدامه، وأسكنه في أعلى الجنّات بجوار حبيبك ومصطفاك (صلّى الله عليه وسلّم)",
    "اللَّهُمَّ أمّنه من فزع يوم القيامة، ومن هول يوم القيامة، واجعل نفسه آمنة مطمئنّة، ولقّنه حجّته",
    "اللَّهُمَّ اجعله في بطن القبر مطمئنّاً وعند قيام الأشهاد آمن، وبجود رضوانك واثق، وإلى أعلى درجاتك سابق",
    "اللَّهُمَّ اجعل عن يمينه نوراً حتّى تبعثه آمناً مطمئنّاً في نورٍ من نورك",
    "اللَّهُمَّ انظر إليه نظرة رضا، فإنّ من تنظر إليه نظرة رضا لا تعذّبه أبداً",
    "اللَّهُمَّ أسكنه فسيح الجنان، واغفر له يا رحمن، وارحمه يا رحيم، وتجاوز عمّا تعلم يا عليم",
    "اللَّهُمَّ اعف عنه فإنّك القائل ويعفو عن كثير",
    "اللَّهُمَّ إنّه جاء ببابك، وأناخ بجنابك، فَجد عليه بعفوك وإكرامك وجود إحسانك",
    "اللَّهُمَّ إنّ رحمتك وسعت كلّ شيء فارحمه رحمةً تطمئنّ بها نفسه، وتقرّ بها عينه",
    "اللَّهُمَّ احشره مع المتّقين إلى الرّحمن وفداً",
    "اللَّهُمَّ احشره مع أصحاب اليمين، واجعل تحيّته سلامٌ لك من أصحاب اليمين",
    "اللَّهُمَّ بشّره بقولك كلوا واشربوا هنيئاً بما أسلفتم في الأيّام الخالية",
    "اللَّهُمَّ اجعله من الّذين سعدوا في الجنّة خالدين فيها ما دامت السموات والأرض",
    "اللَّهُمَّ لا نزكّيه عليك، ولكنّا نحسبه أنّه أمن وعمل صالحاً، فاجعل له جنّتين ذواتي أفنان بحقّ قولك: ولمن خاف مقام ربّه جنّتان",
    "اللَّهُمَّ شفع فيه نبيّنا ومصطفاك، واحشره تحت لوائه، واسقه من يده الشّريفة شربةً هنيئةً لا يظمأ بعدها أبداً",
    "اللَّهُمَّ اجعله في جنّة الخلد الَّتِي وُعِدَ الْمُتَّقُونَ كَانَتْ لَهُمْ جَزَاء وَمَصِيرًا. لَهُمْ فِيهَا مَا يَشَاؤُونَ خَالِدِينَ كَانَ عَلَى رَبِّكَ وَعْدًا مَسؤُولا",
    "اللَّهُمَّ إنّه صبر على البلاء فلم يجزع، فامنحه درجة الصّابرين الّذين يوفون أجورهم بغير حساب",
    "اللَّهُمَّ إنّه كان مصلّ لك، فثبّته على الصّراط يوم تزل الأقدام",
    "اللَّهُمَّ إنّه كان صائماً لك، فأدخله الجنّة من باب الريّان",
    "اللَّهُمَّ إنّه كان لكتابك تالٍ وسامع، فشفّع فيه القرآن، وارحمه من النّيران",
    "اللَّهُمَّ ارحمه فإنّه كان مسلماً، واغفر له فإنّه كان مؤمناً، وأدخله الجنّة فإنّه كان بنبيّك مصدّقاً، وسامحه فإنّه كان لكتابك مرتّلاً",
    "اللَّهُمَّ اغفر لحيّنا وميّتنا، وشاهدنا وغائبنا، وصغيرنا وكبيرنا، وذَكرنَا وأنثانا",
    "اللَّهُمَّ من أحييته منّا فأحيه على الإسلام، ومن توفّيته منّا فتوفّه على الإيمان",
    "اللَّهُمَّ لا تحرمنا أجره ولا تضللنا بعده",
    "اللَّهُمَّ أنزل على أهله الصّبر والسلوان وارضهم بقضائك",
    "اللَّهُمَّ ثبّتنا على القول الثّابت في الحياة الدّنيا، وفي الآخرة، ويوم يقوم الأشهاد",
    "اللَّهُمَّ صلّ وسلّم وبارك على سيّدنا محمّد، وعلى اّله وصحبه وسلّم إلى يوم الدّين"
];


  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))
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
                            "أدعية للميّت",
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
                    itemCount: adyahfordead.length,
                    itemBuilder: (context, index) {
                      final animation = CurvedAnimation(
                        parent: _controller,
                        curve: Interval(
                          (index / adyahfordead.length),
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
                          child: _buildCard(adyahfordead[index]),
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
