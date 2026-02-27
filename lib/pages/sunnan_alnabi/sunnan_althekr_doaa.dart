import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThikrAndDuaSunnahsScreen extends StatefulWidget {
  const ThikrAndDuaSunnahsScreen({super.key});

  @override
  State<ThikrAndDuaSunnahsScreen> createState() =>
      _ThikrAndDuaSunnahsScreenState();
}

class _ThikrAndDuaSunnahsScreenState
    extends State<ThikrAndDuaSunnahsScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

 final List<Map<String, String>> dhikrAndDuaSunnahs = const [
  {
    'title': 'الإكثار من قراءة القرآن',
    'description':
        'قال رسول الله ﷺ: "اقرؤوا القرآن فإنه يأتي يوم القيامة شفيعًا لأصحابه" [رواه مسلم].',
  },
  {
    'title': 'ذكر الله على كل حال',
    'description':
        'كان رسول الله ﷺ يذكر الله على كل أحيانه [رواه مسلم].',
  },
  {
    'title': 'التسبيح والتحميد والتكبير بعد الصلاة',
    'description':
        'قال رسول الله ﷺ: "من سبح الله دبر كل صلاة ثلاثًا وثلاثين، وحمد الله ثلاثًا وثلاثين، وكبر الله ثلاثًا وثلاثين، فتلك تسعة وتسعون، وقال تمام المائة: لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير، غفرت خطاياه وإن كانت مثل زبد البحر" [رواه مسلم].',
  },
  {
    'title': 'سيد الاستغفار',
    'description':
        'قال رسول الله ﷺ: "سيد الاستغفار أن تقول: اللهم أنت ربي لا إله إلا أنت خلقتني وأنا عبدك... من قالها موقنًا بها حين يمسي فمات دخل الجنة، وكذلك إذا أصبح" [رواه البخاري].',
  },
  {
    'title': 'التسبيح العظيم',
    'description':
        'قال رسول الله ﷺ: "كلمتان خفيفتان على اللسان، ثقيلتان في الميزان، حبيبتان إلى الرحمن: سبحان الله وبحمده، سبحان الله العظيم" [متفق عليه].',
  },
  {
    'title': 'الدعاء عند نزول المطر',
    'description':
        'كان رسول الله ﷺ إذا رأى المطر قال: "اللهم صيبًا نافعًا" [رواه البخاري].',
  },
  {
    'title': 'الدعاء عند سماع الأذان',
    'description':
        'قال رسول الله ﷺ: "إذا سمعتم المؤذن فقولوا مثل ما يقول، ثم صلوا عليّ، فإنه من صلى عليّ صلاة صلى الله عليه بها عشرًا" [رواه مسلم].',
  },
  {
    'title': 'الدعاء بعد الأذان',
    'description':
        'قال رسول الله ﷺ: "من قال حين يسمع النداء: اللهم رب هذه الدعوة التامة والصلاة القائمة آت محمدًا الوسيلة والفضيلة وابعثه مقامًا محمودًا الذي وعدته، حلت له شفاعتي يوم القيامة" [رواه البخاري].',
  },
  {
    'title': 'الدعاء عند دخول المنزل',
    'description':
        'قال رسول الله ﷺ: "إذا دخل الرجل بيته فذكر الله عند دخوله وعند طعامه قال الشيطان: لا مبيت لكم ولا عشاء" [رواه مسلم].',
  },
  {
    'title': 'الدعاء عند الخروج من المنزل',
    'description':
        'قال رسول الله ﷺ: "من قال إذا خرج من بيته: بسم الله، توكلت على الله، لا حول ولا قوة إلا بالله، يقال له: كفيت ووقيت وهديت وتنحى عنه الشيطان" [رواه أبو داود والترمذي].',
  },
  {
    'title': 'الدعاء عند الكرب',
    'description':
        'كان رسول الله ﷺ إذا حزبه أمر قال: "لا إله إلا الله العظيم الحليم، لا إله إلا الله رب العرش العظيم، لا إله إلا الله رب السماوات ورب الأرض ورب العرش الكريم" [متفق عليه].',
  },
  {
    'title': 'الدعاء عند المصيبة',
    'description':
        'قال رسول الله ﷺ: "ما من مسلم تصيبه مصيبة فيقول: إنا لله وإنا إليه راجعون، اللهم أجرني في مصيبتي وأخلف لي خيرًا منها، إلا أجره الله في مصيبته وأخلف له خيرًا منها" [رواه مسلم].',
  },
  {
    'title': 'إفشاء السلام',
    'description':
        'قال رسول الله ﷺ: "أفشوا السلام بينكم" [رواه مسلم].',
  },
  {
    'title': 'الصلاة على النبي ﷺ',
    'description':
        'قال رسول الله ﷺ: "من صلى عليّ صلاة صلى الله عليه بها عشرًا" [رواه مسلم].',
  },
  {
    'title': 'الدعاء بين الأذان والإقامة',
    'description':
        'قال رسول الله ﷺ: "الدعاء بين الأذان والإقامة لا يرد" [رواه أبو داود والترمذي].',
  },
  {
    'title': 'الإكثار من لا حول ولا قوة إلا بالله',
    'description':
        'قال رسول الله ﷺ: "ألا أدلك على كنز من كنوز الجنة؟ لا حول ولا قوة إلا بالله" [متفق عليه].',
  },
  {
    'title': 'الإكثار من قول لا إله إلا الله وحده لا شريك له',
    'description':
        'قال رسول الله ﷺ: "من قال لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير، في يوم مائة مرة، كانت له عدل عشر رقاب، وكتبت له مائة حسنة..." [متفق عليه].',
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
                            'الذكر والدعاء',
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
                    itemCount: dhikrAndDuaSunnahs.length,
                    itemBuilder: (context, index) {
                      final animation = CurvedAnimation(
                        parent: _controller,
                        curve: Interval(
                          (index / dhikrAndDuaSunnahs.length),
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
                            title: dhikrAndDuaSunnahs[index]['title']!,
                            description:
                                dhikrAndDuaSunnahs[index]['description']!,
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