import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClothingAndEatingSunnahsScreen extends StatefulWidget {
  const ClothingAndEatingSunnahsScreen({super.key});

  @override
  State<ClothingAndEatingSunnahsScreen> createState() =>
      _ClothingAndEatingSunnahsScreenState();
}

class _ClothingAndEatingSunnahsScreenState
    extends State<ClothingAndEatingSunnahsScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  final List<Map<String, String>> clothingAndEatingSunnahs = const [
  {
    'title': 'الدعاء عند لبس ثوب جديد',
    'description':
        'عن أبي سعيد الخدري رضي الله عنه قال: كان رسول الله ﷺ إذا استجد ثوبًا سماه باسمه، إما قميصًا أو عمامة، ثم يقول: "اللهم لك الحمد، أنت كسوتنيه، أسألك من خيره وخير ما صنع له، وأعوذ بك من شره وشر ما صنع له" [رواه أبو داود: 4020].',
  },
  {
    'title': 'لبس الثوب باليمين',
    'description':
        'كان النبي ﷺ يحب التيامن في شأنه كله، في طهوره وترجله وتنعله [متفق عليه].',
  },
  {
    'title': 'لبس النعل باليمين وخلعه بالشمال',
    'description':
        'قال رسول الله ﷺ: "إذا انتعل أحدكم فليبدأ باليمنى، وإذا خلع فليبدأ بالشمال، ولينعلهما جميعًا أو ليخلعهما جميعًا" [متفق عليه].',
  },
  {
    'title': 'الدعاء عند خلع الثوب',
    'description':
        'كان من هدي النبي ﷺ ذكر الله عند كل حال، ويستحب أن يقول عند خلع الثوب: بسم الله، لما فيه من الستر عن الشيطان.',
  },
  {
    'title': 'التسمية عند الأكل',
    'description':
        'قال رسول الله ﷺ: "يا غلام سم الله، وكل بيمينك، وكل مما يليك" [متفق عليه].',
  },
  {
    'title': 'الأكل باليمين',
    'description':
        'قال رسول الله ﷺ: "إذا أكل أحدكم فليأكل بيمينه، وإذا شرب فليشرب بيمينه، فإن الشيطان يأكل بشماله ويشرب بشماله" [رواه مسلم].',
  },
  {
    'title': 'الأكل مما يليه',
    'description':
        'قال النبي ﷺ: "وكل مما يليك" [متفق عليه].',
  },
  {
    'title': 'حمد الله بعد الأكل والشرب',
    'description':
        'قال رسول الله ﷺ: "إن الله ليرضى عن العبد أن يأكل الأكلة فيحمده عليها، أو يشرب الشربة فيحمده عليها" [رواه مسلم].',
  },
  {
    'title': 'الجلوس عند الشرب',
    'description':
        'نهى رسول الله ﷺ أن يشرب الرجل قائمًا [رواه مسلم].',
  },
  {
    'title': 'الشرب على ثلاث دفعات',
    'description':
        'كان النبي ﷺ يتنفس في الشراب ثلاثًا، ويقول: "إنه أروى وأبرأ وأمرأ" [رواه مسلم].',
  },
  {
    'title': 'عدم التنفس في الإناء',
    'description':
        'نهى رسول الله ﷺ أن يتنفس في الإناء أو ينفخ فيه [متفق عليه].',
  },
  {
    'title': 'المضمضة من اللبن',
    'description':
        'شرب رسول الله ﷺ لبنًا فمضمض، وقال: "إن له دسمًا" [متفق عليه].',
  },
  {
    'title': 'عدم عيب الطعام',
    'description':
        'ما عاب رسول الله ﷺ طعامًا قط، كان إذا اشتهاه أكله، وإن كرهه تركه [متفق عليه].',
  },
  {
    'title': 'الأكل بثلاثة أصابع',
    'description':
        'كان رسول الله ﷺ يأكل بثلاث أصابع، ويلعق يده قبل أن يمسحها [رواه مسلم].',
  },
  {
    'title': 'لعق الأصابع والصحفة',
    'description':
        'قال رسول الله ﷺ: "إذا أكل أحدكم فليلعق أصابعه، فإنه لا يدري في أي طعامه البركة" [رواه مسلم].',
  },
  {
    'title': 'تغطية الإناء عند الليل',
    'description':
        'قال رسول الله ﷺ: "غطوا الإناء وأوكوا السقاء، فإن في السنة ليلة ينزل فيها وباء" [رواه مسلم].',
  },
  {
    'title': 'الشرب من ماء زمزم بنية صالحة',
    'description':
        'قال رسول الله ﷺ: "ماء زمزم لما شرب له" [رواه ابن ماجه].',
  },
  {
    'title': 'الأكل يوم عيد الفطر قبل الخروج',
    'description':
        'كان رسول الله ﷺ لا يغدو يوم الفطر حتى يأكل تمرات، ويأكلهن وترًا [رواه البخاري: 953].',
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
                            'سنن اللباس والطعام',
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
                    itemCount: clothingAndEatingSunnahs.length,
                    itemBuilder: (context, index) {
                      final animation = CurvedAnimation(
                        parent: _controller,
                        curve: Interval(
                          (index / clothingAndEatingSunnahs.length),
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
                            title: clothingAndEatingSunnahs[index]['title']!,
                            description: clothingAndEatingSunnahs[index]
                                ['description']!,
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