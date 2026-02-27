import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuranCompletionMethodsScreen extends StatefulWidget {
  const QuranCompletionMethodsScreen({super.key});

  @override
  State<QuranCompletionMethodsScreen> createState() =>
      _QuranCompletionMethodsScreenState();
}

class _QuranCompletionMethodsScreenState
    extends State<QuranCompletionMethodsScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
final List<Map<String, String>> quranCompletionMethods = const [
  {
    'title': 'الطريقة الأولى: ختم القرآن كل شهر',
    'description':
        'يتناسب عدد أجزاء القرآن الكريم الثلاثين مع عدد أيّام الشهر، بمُعدَّل جزء في كلّ يومٍ. يمكن تخصيص وقت مُحدَّد للقراءة في اليوم الواحد، مثل قراءة صفحتَين من القرآن الكريم عند كلّ صلاةٍ مفروضةٍ؛ أي ما يساوي أربعة أوجه. وبهذه الطريقة يُنهي المسلم قراءة جزء كامل في اليوم الواحد، وثلاثين جزءاً في الشهر.',
  },
  {
    'title': 'الطريقة الثانية: ختم القرآن كل أسبوع',
    'description':
        'كان الصحابة -رضوان الله عليهم- يقسّمون القرآن الكريم إلى سبعة أحزاب، وهو ما يُسمّى (تحزيب القرآن الكريم). فيقرؤون كلّ يومٍ حِزباً منه. هذا التحزيب يعتمد على تقسيم القرآن إلى سبعة أقسام متوازنة، مما يساعد على المحافظة على السياق العام للآيات.',
  },
  {
    'title': 'الطريقة الثالثة: ختم القرآن كل عشرة أيام',
    'description':
        'يمكن قراءة ثلاثة أجزاء يوميّاً (حوالي ساعة ونصف يومياً). ولمن أراد تسريع الختمة يمكن قراءة أربعة أجزاء يومياً لختمه في ثمانية أيام، أو ستة أجزاء يومياً لختمه في خمسة أيام.',
  },
  {
    'title': 'الطريقة الرابعة: ختم القرآن كل ثلاثة أيام',
    'description':
        'تعتمد هذه الطريقة على القراءة السريعة مع مراعاة أحكام التلاوة. يتم قراءة عشرة أجزاء يومياً موزعة بعد الصلوات، وبذلك يُختم القرآن كاملاً خلال ثلاثة أيام.',
  },
  {
    'title': 'الطريقة الخامسة: ختم القرآن في يوم واحد',
    'description':
        'يمكن تخصيص خمس إلى ست ساعات لقراءة القرآن قراءة حَدر، بمعدل عشرة إلى اثنتي عشرة دقيقة لكل جزء. هذه الطريقة تحتاج إلى تركيز عالٍ وتفرغ كامل.',
  },

  // ✨ إضافات جديدة

  {
    'title': 'الطريقة السادسة: صفحة بعد كل صلاة',
    'description':
        'قراءة أربع صفحات بعد كل صلاة مفروضة (20 صفحة يومياً) تعني ختم القرآن كاملاً في شهر تقريباً دون شعور بضغط أو إرهاق.',
  },
  {
    'title': 'الطريقة السابعة: نصف جزء يومياً',
    'description':
        'قراءة نصف جزء يومياً (10 صفحات تقريباً) تساعد على ختم القرآن خلال شهرين، وهي مناسبة للمبتدئين أو أصحاب الانشغال الكبير.',
  },
  {
    'title': 'الطريقة الثامنة: قراءة ثابتة بعد الفجر',
    'description':
        'تخصيص 20 إلى 30 دقيقة بعد صلاة الفجر يومياً لقراءة جزء كامل يسهّل ختم القرآن في شهر، مع بركة الوقت في ساعات الصباح.',
  },
  {
    'title': 'الطريقة التاسعة: تقسيم الجزء على مدار اليوم',
    'description':
        'تقسيم الجزء الواحد إلى أربعة أقسام صغيرة تُقرأ في أوقات متفرقة (بعد الفجر، الظهر، العصر، العشاء)، مما يجعل الالتزام أسهل وأكثر انتظاماً.',
  },
  {
    'title': 'الطريقة العاشرة: ختمة تدبر',
    'description':
        'يمكن قراءة نصف جزء يومياً مع تخصيص وقت للتفسير والتأمل، مما يؤدي إلى ختم القرآن في شهرين تقريباً مع فهم أعمق للمعاني.',
  },
  {
    'title': 'الطريقة الحادية عشرة: ختمة سماع',
    'description':
        'الاستماع إلى جزء يومياً عبر تلاوات مسجلة أثناء القيادة أو المشي يساعد على إتمام ختمة كاملة خلال شهر مع تعزيز الحفظ والتركيز.',
  },
  {
    'title': 'الطريقة الثانية عشرة: ختمة العشر الأواخر',
    'description':
        'يمكن تكثيف القراءة في العشر الأواخر بقراءة ثلاثة أجزاء يومياً لإتمام ختمة كاملة خلال هذه الأيام المباركة.',
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
                            'كيفية ختم القرآن الكريم',
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
                    itemCount: quranCompletionMethods.length,
                    itemBuilder: (context, index) {
                      final animation = CurvedAnimation(
                        parent: _controller,
                        curve: Interval(
                          (index / quranCompletionMethods.length),
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
                                quranCompletionMethods[index]['title']!,
                            description:
                                quranCompletionMethods[index]['description']!,
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