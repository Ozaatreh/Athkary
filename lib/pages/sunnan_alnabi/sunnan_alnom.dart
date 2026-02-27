import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SleepSunnahsPage extends StatefulWidget {
  const SleepSunnahsPage({super.key});

  @override
  State<SleepSunnahsPage> createState() => _SleepSunnahsPageState();
}

class _SleepSunnahsPageState extends State<SleepSunnahsPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;

 final List<Map<String, String>> sleepSunnahs = const [
  {
    'title': 'النوم على وضوء',
    'description':
        'قال النبي ﷺ للبراء بن عازب رضي الله عنه: "إذا أتيت مضجعك فتوضأ وضوءك للصلاة، ثم اضطجع على شقك الأيمن، ثم قل: اللهم أسلمت نفسي إليك، ووجهت وجهي إليك، وفوضت أمري إليك، وألجأت ظهري إليك، رغبة ورهبة إليك، لا ملجأ ولا منجا منك إلا إليك، آمنت بكتابك الذي أنزلت وبنبيك الذي أرسلت، فإن مت من ليلتك فأنت على الفطرة" [متفق عليه]',
  },
  {
    'title': 'النوم على الشق الأيمن',
    'description':
        'كان النبي ﷺ إذا أوى إلى فراشه نام على شقه الأيمن، وكان يحب التيامن في شأنه كله. [رواه البخاري ومسلم]',
  },
  {
    'title': 'قراءة آية الكرسي قبل النوم',
    'description':
        'قال ﷺ: "إذا أويت إلى فراشك فاقرأ آية الكرسي، فإنه لن يزال عليك من الله حافظ، ولا يقربك شيطان حتى تصبح" [رواه البخاري]',
  },
  {
    'title': 'قراءة سورة الإخلاص والمعوذتين',
    'description':
        'عن عائشة رضي الله عنها أن النبي ﷺ كان إذا أوى إلى فراشه جمع كفيه ثم نفث فيهما، فقرأ فيهما: قل هو الله أحد، وقل أعوذ برب الفلق، وقل أعوذ برب الناس، ثم مسح بهما ما استطاع من جسده، يبدأ بهما على رأسه ووجهه وما أقبل من جسده، يفعل ذلك ثلاث مرات. [رواه البخاري]',
  },
  {
    'title': 'قراءة آخر آيتين من سورة البقرة',
    'description':
        'قال رسول الله ﷺ: "من قرأ بالآيتين من آخر سورة البقرة في ليلة كفتاه" [متفق عليه]',
  },
  {
    'title': 'التكبير والتسبيح والتحميد عند المنام',
    'description':
        'قال ﷺ لعلي وفاطمة رضي الله عنهما: "إذا أويتما إلى فراشكما فكبرا أربعًا وثلاثين، وسبحا ثلاثًا وثلاثين، واحمدا ثلاثًا وثلاثين، فهو خير لكما من خادم" [متفق عليه]',
  },
  {
    'title': 'دعاء النوم',
    'description':
        'كان النبي ﷺ إذا أوى إلى فراشه قال: "باسمك اللهم أموت وأحيا" [رواه البخاري]',
  },
  {
    'title': 'نفض الفراش قبل النوم',
    'description':
        'قال رسول الله ﷺ: "إذا أوى أحدكم إلى فراشه فلينفضه بداخلة إزاره، فإنه لا يدري ما خلفه عليه، ثم ليقل: باسمك ربي وضعت جنبي وبك أرفعه، إن أمسكت نفسي فارحمها، وإن أرسلتها فاحفظها بما تحفظ به عبادك الصالحين" [متفق عليه]',
  },
  {
    'title': 'الدعاء عند الاستيقاظ أثناء الليل',
    'description':
        'قال رسول الله ﷺ: "من تعارَّ من الليل فقال: لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير، الحمد لله، وسبحان الله، ولا إله إلا الله، والله أكبر، ولا حول ولا قوة إلا بالله، ثم قال: اللهم اغفر لي، أو دعا؛ استجيب له، فإن توضأ وصلى قُبلت صلاته" [رواه البخاري]',
  },
  {
    'title': 'الدعاء عند الاستيقاظ من النوم',
    'description':
        'كان النبي ﷺ إذا استيقظ قال: "الحمد لله الذي أحيانا بعدما أماتنا وإليه النشور" [رواه البخاري]',
  },
  {
    'title': 'الدعاء عند رؤية رؤيا صالحة',
    'description':
        'قال رسول الله ﷺ: "الرؤيا الصالحة من الله، فإذا رأى أحدكم ما يحب فليحمد الله عليها وليحدث بها من يحب" [متفق عليه]',
  },
  {
    'title': 'الاستعاذة عند رؤية رؤيا سيئة',
    'description':
        'قال رسول الله ﷺ: "وإذا رأى ما يكره فليتعوذ بالله من شرها ومن شر الشيطان، وليتفل عن يساره ثلاثًا، ولا يحدث بها أحدًا، فإنها لا تضره" [متفق عليه]',
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
                            'سنن النوم',
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
                    itemCount: sleepSunnahs.length,
                    itemBuilder: (context, index) {
                      final animation = CurvedAnimation(
                        parent: _controller,
                        curve: Interval(
                          (index / sleepSunnahs.length),
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
                          child: _buildSunnahTile(
                            title: sleepSunnahs[index]['title']!,
                            description:
                                sleepSunnahs[index]['description']!,
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

  Widget _buildSunnahTile({
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