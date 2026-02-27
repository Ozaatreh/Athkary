import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LaylatAlQadrInfoScreen extends StatefulWidget {
  const LaylatAlQadrInfoScreen({super.key});

  @override
  State<LaylatAlQadrInfoScreen> createState() =>
      _LaylatAlQadrInfoScreenState();
}

class _LaylatAlQadrInfoScreenState extends State<LaylatAlQadrInfoScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  final List<Map<String, String>> laylatAlQadrInfo = const [
    {
      'title': 'هل ليلة 27 رمضان هي ليلة القدر؟',
      'description':
          'نعم، ليلة سبع وعشرين هي أرجى ما تكون ليلة القدر، كما جاء في صحيح مسلم من حديث أُبي بن كعب رضي الله عنه',
    },
    {
      'title': 'كيف نعرف أن ليلة القدر هي ليلة القدر؟',
      'description':
          'علامات ليلة القدر:\n'
          '- ليلة هادئة لطيفة لا حارة ولا باردة\n'
          '- تطلع الشمس في صباحها ضعيفة حمراء\n'
          '- قوة الإضاءة والنور في تلك الليلة\n'
          '- طمأنينة القلب وانشراح الصدر\n'
          '- الرياح تكون ساكنة\n'
          '- قد تراها في المنام كما حدث مع بعض السلف الصالح\n'
          '- لا يحل لشيطان أن يخرج فيها حتى الفجر\n'
          '- طلوع الشمس بيضاء لا شعاع لها بعد تمام الليلة',
    },
    {
      'title': 'كيف نلتمس ليلة القدر؟',
      'description':
          'إحياءها بالقيام، ففي الصحيحين عن أبي هريرة رضي الله عنه قال: قال رسول الله صلى الله عليه وسلم: "من قام ليلة القدر إيماناً واحتساباً غفر له ما تقدم من ذنبه"\n'
          'الدعاء، وخصوصاً ما ورد به الدليل، فعن عائشة رضي الله عنها قالت: قلت: يا رسول الله، أرأيت إن علمت ليلة القدر ما أقول فيها؟',
    },
    {
      'title': 'كم ركعة صلاة ليلة القدر؟',
      'description':
          'عدد ركعات صلاة ليلة القدر:\n'
          '- الحنفية: عشرون ركعة بعشر تسليمات\n'
          '- المالكية: ست وثلاثون ركعة بتسع ترويحات\n'
          '- الشافعية: عشرون ركعة بعشر تسليمات\n'
          '- الحنابلة: عشرون ركعة ولا حرج من الزيادة',
    },
    {
      'title': 'هل يجوز النوم في ليلة القدر؟',
      'description':
          'نعم، لا بأس أن ينام بعض الليل، مادام أنه قد قام أغلبه. عائشة رضي الله عنها قالت: «ما قام ليلة حتى أصبح» صلوات الله وسلامه عليه',
    },
    {
      'title': 'متى يبدأ وقت ليلة القدر ومتى تنتهي؟',
      'description':
          'ليلة القدر متنقلة في العشر الأواخر من رمضان، وقد تكون في ليلة إحدى وعشرين، أو ثلاث وعشرين، أو خمس وعشرين، أو سبع وعشرين (وهي أحرى الليالي)، أو تسع وعشرين',
    },
    {
      'title': 'ما هو أفضل وقت لصلاة ليلة القدر؟',
      'description':
          'أفضل وقت لصلاة ليلة القدر هو بعد منتصف الليل، خاصة في الساعات الأخيرة قبل الفجر (1:30 صباحًا – 2:00 صباحًا)',
    },
    {
      'title': 'هل يعتق الله في آخر ليلة من رمضان؟',
      'description':
          'نعم، في آخر ليلة من رمضان، يعتق الله بعدد ما أعتق من أول الشهر إلى آخره، كما جاء في حديث ابن عباس المرفوع',
    },
    {
      'title': 'هل ليلة القدر تأتي زوجية؟',
      'description':
          'ليلة القدر يمكن أن تكون في الليالي الزوجية أو الفردية، ولكنها تكون في العشر الأواخر من رمضان',
    },
    {
      'title': 'ما هو أفضل دعاء ليلة القدر؟',
      'description':
          'اللهم يا رب السماوات والأرض في ليلة القدر أن ترفع درجات أمي وأبي وأن تحرم عليهما عذاب النار وعذاب القبر وأن تجعلهما ممن لا خوف عليهم ولا هم يحزنون',
    },
    {
      'title': 'ما سبب عدم معرفة ليلة القدر؟',
      'description':
          'تم إخفاء موعد ليلة القدر حتى يداوم المسلمون على العبادات والطاعات في جميع الليالي، وليس فقط في ليلة واحدة',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
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

                /// ================= HEADER =================
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 16),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/animations/wired-lineal-1821-night-sky-moon-stars-hover-pinch.json',
                              width: 55,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'ليلة القدر',
                              style: GoogleFonts.amiri(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
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

                /// ================= CONTENT =================
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: laylatAlQadrInfo.length,
                    itemBuilder: (context, index) {
                      final animation = CurvedAnimation(
                        parent: _controller,
                        curve: Interval(
                          (index / laylatAlQadrInfo.length),
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
                          child: _buildExpansionTile(
                            question:
                                laylatAlQadrInfo[index]['title']!,
                            answer:
                                laylatAlQadrInfo[index]['description']!,
                          ),
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

  Widget _buildExpansionTile({
    required String question,
    required String answer,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white.withOpacity(0.08),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          childrenPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          iconColor: Colors.white,
          collapsedIconColor: Colors.white70,
          title: Text(
            question,
            style: GoogleFonts.amiri(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          children: [
            Text(
              answer,
              style: GoogleFonts.amiri(
                fontSize: 18,
                height: 1.8,
                color: Colors.white.withOpacity(0.95),
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}