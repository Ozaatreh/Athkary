import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RamadanHealthBenefits extends StatefulWidget {
  const RamadanHealthBenefits({super.key});

  @override
  State<RamadanHealthBenefits> createState() =>
      _RamadanHealthBenefitsState();
}

class _RamadanHealthBenefitsState
    extends State<RamadanHealthBenefits>
    with TickerProviderStateMixin {
  late AnimationController _controller;
final List<Map<String, String>> healthPoints = const [
  {
    "title": "الصوم والصحة النفسية",
    "description":
        "يساعد الصوم على تهدئة الجهاز العصبي وتقليل التوتر والقلق، كما يعزز الشعور بالسكينة والانضباط الداخلي، ويقوي الإرادة والتحكم في النفس."
  },
  {
    "title": "الصوم والتخلص من سموم الجسم",
    "description":
        "يمنح الصوم الجهاز الهضمي فرصة للراحة، مما يساعد الجسم على التخلص من السموم المتراكمة وتحسين كفاءة الأعضاء الحيوية."
  },
  {
    "title": "تنظيم مستوى السكر في الدم",
    "description":
        "يساعد الصوم على تحسين حساسية الإنسولين وتنظيم مستويات السكر في الدم، مما يقلل من خطر الإصابة بمرض السكري من النوع الثاني."
  },
  {
    "title": "تعزيز صحة القلب",
    "description":
        "يساهم الصوم في خفض ضغط الدم وتقليل مستويات الكوليسترول الضار، مما يعزز صحة القلب ويقلل من احتمالية الإصابة بأمراض القلب."
  },
  {
    "title": "تحسين عملية الهضم",
    "description":
        "إراحة المعدة والأمعاء خلال الصوم يساعد على تحسين كفاءة الهضم وتقليل مشاكل الانتفاخ وعسر الهضم."
  },
  {
    "title": "تقوية جهاز المناعة",
    "description":
        "تشير بعض الدراسات إلى أن الصوم قد يحفز عملية تجديد الخلايا المناعية، مما يعزز مقاومة الجسم للأمراض."
  },
  {
    "title": "تحفيز حرق الدهون",
    "description":
        "عند انخفاض مخزون الجلوكوز يبدأ الجسم باستخدام الدهون كمصدر للطاقة، مما يساعد على إنقاص الوزن وتحسين التمثيل الغذائي."
  },
  {
    "title": "تنشيط عمليات تجديد الخلايا",
    "description":
        "يساهم الصوم في تحفيز عملية الالتهام الذاتي (Autophagy)، وهي عملية طبيعية يقوم فيها الجسم بتنظيف الخلايا من المكونات التالفة."
  },
  {
    "title": "تحسين جودة النوم",
    "description":
        "يساعد تنظيم مواعيد الطعام خلال الصوم على ضبط الساعة البيولوجية للجسم وتحسين جودة النوم."
  },
  {
    "title": "تعزيز قوة الإرادة والانضباط",
    "description":
        "يساهم الصوم في تدريب النفس على الصبر والتحكم في الشهوات، مما ينعكس إيجابًا على السلوك اليومي واتخاذ القرارات."
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

                /// ========= HEADER =========
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
                        child: Center(
                          child: Text(
                            "فوائد الصوم الصحية",
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

                /// ========= CONTENT =========
                Expanded(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: healthPoints.length,
                    itemBuilder: (context, index) {
                      final animation = CurvedAnimation(
                        parent: _controller,
                        curve: Interval(
                          (index / healthPoints.length),
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
                            title:
                                healthPoints[index]["title"]!,
                            description:
                                healthPoints[index]["description"]!,
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