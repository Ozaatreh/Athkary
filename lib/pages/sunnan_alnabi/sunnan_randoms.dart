import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RandomsSunnahsScreen extends StatefulWidget {
  const RandomsSunnahsScreen({super.key});

  @override
  State<RandomsSunnahsScreen> createState() =>
      _RandomsSunnahsScreenState();
}

class _RandomsSunnahsScreenState
    extends State<RandomsSunnahsScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  final List<Map<String, String>> miscellaneousSunnahs = const [
  {
    'title': 'طلب العلم',
    'description':
        'قال رسول الله ﷺ: "من سلك طريقًا يلتمس فيه علمًا سهل الله له به طريقًا إلى الجنة" [رواه مسلم].',
  },
  {
    'title': 'الاستئذان ثلاثًا',
    'description':
        'قال رسول الله ﷺ: "الاستئذان ثلاث، فإن أُذن لك وإلا فارجع" [متفق عليه].',
  },
  {
    'title': 'عيادة المريض',
    'description':
        'قال رسول الله ﷺ: "من عاد مريضًا لم يزل في خُرفة الجنة حتى يرجع" قيل: يا رسول الله وما خُرفة الجنة؟ قال: "جناها" [رواه مسلم].',
  },
  {
    'title': 'اتباع الجنائز',
    'description':
        'قال رسول الله ﷺ: "من شهد الجنازة حتى يصلى عليها فله قيراط، ومن شهدها حتى تدفن فله قيراطان" قيل: وما القيراطان؟ قال: "مثل الجبلين العظيمين" [متفق عليه].',
  },
  {
    'title': 'التبسم في وجه الناس',
    'description':
        'قال رسول الله ﷺ: "تبسمك في وجه أخيك صدقة" [رواه الترمذي].',
  },
  {
    'title': 'إفشاء السلام',
    'description':
        'قال رسول الله ﷺ: "أفشوا السلام بينكم" [رواه مسلم].',
  },
  {
    'title': 'إماطة الأذى عن الطريق',
    'description':
        'قال رسول الله ﷺ: "الإيمان بضع وسبعون شعبة... وأدناها إماطة الأذى عن الطريق" [رواه مسلم].',
  },
  {
    'title': 'الصدقة',
    'description':
        'قال رسول الله ﷺ: "من تصدق بعدل تمرة من كسب طيب فإن الله يتقبلها بيمينه ثم يربيها لصاحبها كما يربي أحدكم فلوه حتى تكون مثل الجبل" [متفق عليه].',
  },
  {
    'title': 'المداومة على العمل الصالح',
    'description':
        'قال رسول الله ﷺ: "أحب الأعمال إلى الله أدومها وإن قل" [متفق عليه].',
  },
  {
    'title': 'كفالة اليتيم',
    'description':
        'قال رسول الله ﷺ: "أنا وكافل اليتيم في الجنة هكذا" وأشار بالسبابة والوسطى وفرّج بينهما [رواه البخاري].',
  },
  {
    'title': 'الإصلاح بين الناس',
    'description':
        'قال رسول الله ﷺ: "ألا أخبركم بأفضل من درجة الصيام والصلاة والصدقة؟ إصلاح ذات البين" [رواه أبو داود والترمذي].',
  },
  {
    'title': 'الرفق في الأمور',
    'description':
        'قال رسول الله ﷺ: "إن الله رفيق يحب الرفق في الأمر كله" [متفق عليه].',
  },
  {
    'title': 'الحياء',
    'description':
        'قال رسول الله ﷺ: "الحياء لا يأتي إلا بخير" [متفق عليه].',
  },
  {
    'title': 'زيارة الإخوان في الله',
    'description':
        'قال رسول الله ﷺ: "أن رجلًا زار أخًا له في قرية أخرى، فأرصد الله له على مدرجته ملكًا..." وفيه أن الله قال: "قد أحببتك كما أحببته فيّ" [رواه مسلم].',
  },
  {
    'title': 'حسن الظن بالله',
    'description':
        'قال رسول الله ﷺ: "يقول الله تعالى: أنا عند ظن عبدي بي" [متفق عليه].',
  },
  {
    'title': 'الدعاء بظهر الغيب',
    'description':
        'قال رسول الله ﷺ: "دعوة المرء المسلم لأخيه بظهر الغيب مستجابة، عند رأسه ملك موكل كلما دعا لأخيه بخير قال الملك: آمين ولك بمثل" [رواه مسلم].',
  },
  {
    'title': 'كظم الغيظ',
    'description':
        'قال رسول الله ﷺ: "من كظم غيظًا وهو قادر على أن ينفذه دعاه الله على رؤوس الخلائق يوم القيامة حتى يخيره من الحور العين ما شاء" [رواه أبو داود والترمذي].',
  },
  {
    'title': 'بر الوالدين',
    'description':
        'قال رسول الله ﷺ حين سئل عن أحب الأعمال إلى الله: "الصلاة على وقتها" قيل ثم أي؟ قال: "بر الوالدين" [متفق عليه].',
  },
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
                            'سنن متنوعة',
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
                    itemCount: miscellaneousSunnahs.length,
                    itemBuilder: (context, index) {
                      final animation = CurvedAnimation(
                        parent: _controller,
                        curve: Interval(
                          (index / miscellaneousSunnahs.length),
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
                            title: miscellaneousSunnahs[index]['title']!,
                            description:
                                miscellaneousSunnahs[index]['description']!,
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