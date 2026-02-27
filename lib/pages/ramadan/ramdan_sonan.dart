import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RamadanSunnahsPage extends StatefulWidget {
  const RamadanSunnahsPage({super.key});

  @override
  State<RamadanSunnahsPage> createState() => _RamadanSunnahsPageState();
}

class _RamadanSunnahsPageState extends State<RamadanSunnahsPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  final List<Map<String, String>> sunnahs = const [
  {
    'title': 'التهنئة بقدوم شهر رمضان',
    'description':
        'عن أبي هريرة رضي الله عنه قال: كان رسول الله صلى الله عليه وسلم يبشر أصحابه بقدوم رمضان...',
  },
  {
    'title': 'تعجيل الفطر',
    'description':
        'قال صلى الله عليه وسلم: "لا يزال الناس بخير ما عجلوا الفطر" رواه البخاري ومسلم.',
  },
  {
    'title': 'تفطير الصائمين',
    'description':
        'قال صلى الله عليه وسلم: "من فطر صائماً كتب له مثل أجره" رواه النسائي والترمذي.',
  },
  {
    'title': 'الفطر على تمر أو ماء',
    'description':
        'قال صلى الله عليه وسلم: "إذا كان أحدكم صائماً فليفطر على التمر، فإن لم يجد فعلى الماء" رواه الخمسة.',
  },
  {
    'title': 'السحور',
    'description':
        'قال صلى الله عليه وسلم: "تسحروا فإن في السحور بركة" رواه البخاري ومسلم.',
  },
  {
    'title': 'تأخير السحور',
    'description':
        'كان النبي صلى الله عليه وسلم يؤخر السحور إلى قبيل الفجر، كما جاء في حديث زيد بن ثابت رضي الله عنه رواه البخاري ومسلم.',
  },
  {
    'title': 'الدعاء عند الإفطار',
    'description':
        'كان صلى الله عليه وسلم إذا أفطر قال: "ذهب الظمأ وابتلت العروق وثبت الأجر إن شاء الله" رواه أبو داود.',
  },
  {
    'title': 'قيام رمضان',
    'description':
        'قال صلى الله عليه وسلم: "من قام رمضان إيماناً واحتساباً غفر له ما تقدم من ذنبه" رواه البخاري ومسلم.',
  },
  {
    'title': 'الإكثار من قراءة القرآن',
    'description':
        'قال تعالى: "شهر رمضان الذي أنزل فيه القرآن هدىً للناس وبينات من الهدى والفرقان".',
  },
  {
    'title': 'مدارسة القرآن',
    'description':
        'كان جبريل عليه السلام يدارس النبي صلى الله عليه وسلم القرآن في رمضان، رواه البخاري.',
  },
  {
    'title': 'الاعتكاف في العشر الأواخر',
    'description':
        'قال ابن عمر رضي الله عنهما: "كان رسول الله صلى الله عليه وسلم يعتكف العشر الأواخر من رمضان" رواه البخاري.',
  },
  {
    'title': 'تحري ليلة القدر',
    'description':
        'قال صلى الله عليه وسلم: "تحروا ليلة القدر في العشر الأواخر من رمضان" رواه البخاري ومسلم.',
  },
  {
    'title': 'الإكثار من الدعاء',
    'description':
        'قال تعالى: "وإذا سألك عبادي عني فإني قريب أجيب دعوة الداع إذا دعان".',
  },
  {
    'title': 'الاجتهاد في العبادات',
    'description':
        'كان النبي صلى الله عليه وسلم إذا دخلت العشر شد مئزره وأحيا ليله وأيقظ أهله، رواه البخاري ومسلم.',
  },
  {
    'title': 'الصدقة في رمضان',
    'description':
        'كان رسول الله صلى الله عليه وسلم أجود الناس، وكان أجود ما يكون في رمضان، رواه البخاري.',
  },
  {
    'title': 'الرد على الإساءة بالصيام',
    'description':
        'قال صلى الله عليه وسلم: "فإن سابه أحد أو قاتله فليقل إني صائم" رواه البخاري.',
  },
  {
    'title': 'العمرة في رمضان',
    'description':
        'قال صلى الله عليه وسلم: "عمرة في رمضان تعدل حجة" رواه البخاري ومسلم.',
  },
];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
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
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                            "سنن رمضانية",
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
                    itemCount: sunnahs.length,
                    itemBuilder: (context, index) {
                      final animation = CurvedAnimation(
                        parent: _controller,
                        curve: Interval(
                          (index / sunnahs.length),
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
                            title: sunnahs[index]['title']!,
                            description:
                                sunnahs[index]['description']!,
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
    required String title,
    required String description,
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
            title,
            style: GoogleFonts.amiri(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          children: [
            Text(
              description,
              style: GoogleFonts.amiri(
                fontSize: 18,
                height: 1.9,
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