import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FastingSunnahsPage extends StatefulWidget {
  const FastingSunnahsPage({super.key});

  @override
  State<FastingSunnahsPage> createState() => _FastingSunnahsPageState();
}

class _FastingSunnahsPageState extends State<FastingSunnahsPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  final List<Map<String, String>> fastingSunnahs = const [
  {
    'title': 'السحور',
    'description':
        'قال رسول الله ﷺ: "تسحروا فإن في السحور بركة" [متفق عليه].',
  },
  {
    'title': 'تأخير السحور',
    'description':
        'كان بين سحور النبي ﷺ وصلاته قدر خمسين آية، مما يدل على استحباب تأخير السحور إلى قبيل الفجر [متفق عليه].',
  },
  {
    'title': 'تعجيل الفطر',
    'description':
        'قال رسول الله ﷺ: "لا يزال الناس بخير ما عجلوا الفطر" [متفق عليه].',
  },
  {
    'title': 'الفطر على تمر أو ماء',
    'description':
        'كان رسول الله ﷺ يفطر قبل أن يصلي على رطبات، فإن لم تكن رطبات فتمرات، فإن لم تكن تمرات حسا حسوات من ماء [رواه أبو داود والترمذي].',
  },
  {
    'title': 'الدعاء عند الإفطار',
    'description':
        'كان النبي ﷺ إذا أفطر قال: "ذهب الظمأ وابتلت العروق وثبت الأجر إن شاء الله" [رواه أبو داود].',
  },
  {
    'title': 'حفظ اللسان والجوارح',
    'description':
        'قال رسول الله ﷺ: "إذا كان يوم صوم أحدكم فلا يرفث ولا يصخب، فإن سابه أحد أو قاتله فليقل إني صائم" [متفق عليه].',
  },
  {
    'title': 'قيام رمضان',
    'description':
        'قال رسول الله ﷺ: "من قام رمضان إيمانًا واحتسابًا غفر له ما تقدم من ذنبه" [متفق عليه].',
  },
  {
    'title': 'الاجتهاد في العشر الأواخر',
    'description':
        'كان النبي ﷺ إذا دخلت العشر الأواخر شد مئزره وأحيا ليله وأيقظ أهله [متفق عليه].',
  },
  {
    'title': 'الاعتكاف في رمضان',
    'description':
        'كان رسول الله ﷺ يعتكف العشر الأواخر من رمضان حتى توفاه الله [رواه البخاري].',
  },
  {
    'title': 'تحري ليلة القدر',
    'description':
        'قال رسول الله ﷺ: "تحروا ليلة القدر في العشر الأواخر من رمضان" [متفق عليه].',
  },
  {
    'title': 'صوم ستة أيام من شوال',
    'description':
        'قال رسول الله ﷺ: "من صام رمضان ثم أتبعه ستًا من شوال كان كصيام الدهر" [رواه مسلم].',
  },
  {
    'title': 'صوم ثلاثة أيام من كل شهر',
    'description':
        'أوصى النبي ﷺ أبا هريرة رضي الله عنه بصيام ثلاثة أيام من كل شهر [متفق عليه].',
  },
  {
    'title': 'صوم يومي الاثنين والخميس',
    'description':
        'كان النبي ﷺ يتحرى صيام يومي الاثنين والخميس، وقال: "تعرض الأعمال يوم الاثنين والخميس فأحب أن يعرض عملي وأنا صائم" [رواه الترمذي].',
  },
  {
    'title': 'صوم يوم عرفة',
    'description':
        'قال رسول الله ﷺ: "صيام يوم عرفة أحتسب على الله أن يكفر السنة التي قبله والسنة التي بعده" [رواه مسلم].',
  },
  {
    'title': 'صوم يوم عاشوراء',
    'description':
        'قال رسول الله ﷺ: "صيام يوم عاشوراء أحتسب على الله أن يكفر السنة التي قبله" [رواه مسلم].',
  },
  {
    'title': 'صوم يوم قبله أو بعده مع عاشوراء',
    'description':
        'قال رسول الله ﷺ: "لئن بقيت إلى قابل لأصومن التاسع" [رواه مسلم]، استحبابًا لمخالفة اليهود.',
  },
  {
    'title': 'الإكثار من الصدقة في رمضان',
    'description':
        'كان رسول الله ﷺ أجود الناس، وكان أجود ما يكون في رمضان حين يلقاه جبريل [متفق عليه].',
  },
  {
    'title': 'الإكثار من تلاوة القرآن في رمضان',
    'description':
        'كان جبريل عليه السلام يدارس النبي ﷺ القرآن في رمضان، مما يدل على استحباب الإكثار من تلاوته في هذا الشهر [متفق عليه].',
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
                            'سنن الصيام',
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
                    itemCount: fastingSunnahs.length,
                    itemBuilder: (context, index) {
                      final animation = CurvedAnimation(
                        parent: _controller,
                        curve: Interval(
                          (index / fastingSunnahs.length),
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
                          child: _buildTile(
                            title: fastingSunnahs[index]['title']!,
                            description:
                                fastingSunnahs[index]['description']!,
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

  Widget _buildTile({
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