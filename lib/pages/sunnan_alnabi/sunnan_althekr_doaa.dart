import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThikrAndDuaSunnahsScreen extends StatefulWidget {
  const ThikrAndDuaSunnahsScreen({super.key});

  @override
  State<ThikrAndDuaSunnahsScreen> createState() =>
      _ThikrAndDuaSunnahsScreenState();
}

class _ThikrAndDuaSunnahsScreenState extends State<ThikrAndDuaSunnahsScreen> {
  
   final List<Map<String, String>> dhikrAndDuaSunnahs = const [
    {
      'title': 'الإكثار من قراءة القرآن',
      'description':
          'عن أبي أمامة الباهلي ـ رضي الله عنه ـ قال: سمعت رسول الله ـ صلى الله عليه وسلم ـ يقول: (( اقرؤوا القرآن ، فإنه يأتي يوم القيامة شفيعًا لأصحابه )) [ رواه مسلم: 1874 ].',
    },
    {
      'title': 'تحسين الصوت بقراءة القرآن',
      'description':
          'عن أبي هريرة رضي الله عنه ، أنه سمع رسول الله ـ صلى الله عليه وسلم ـ يقول: (( ما أَذِنَ الله لشيء ما أَذِنَ لنبي حسن الصوت ، يتغنى بالقرآن يجهر به )) [ متفق عليه:5024 - 1847 ].',
    },
    {
      'title': 'ذكر الله على كل حال',
      'description':
          'عن عائشة ـ رضي الله عنها ـ قالت: (( كان رسول الله ـ صلى الله عليه وسلم ـ يذكر الله على كل أحيانه )) [ رواه مسلم: 826 ].',
    },
    {
      'title': 'التسبيح',
      'description':
          'عن جويرية رضي الله عنها ، أن رسول الله ـ صلى الله عليه وسلم ـ خرج من عندها بُكرة حين صلى الصبح، وهي في مسجدها، ثم رجع بعد أنْ أضحى ، وهي جالسة ، فقال: (( ما زلتِ على الحال التي فارقتك عليها ؟ )) قالت: نعم ، قال النبي صلى الله عليه وسلم : (( لقد قُلتُ بعدك أربَعَ كلماتٍ ، ثلاث مراتٍ ، لو وُزِنَت بما قلتِ مُنذ اليوم لَوَزَنتهُن: سبحان الله وبحمده ، عدد خلقه، ورضا نفسهِ ، وزِنةَ عرشهِ ، ومِدادَ كلماته )) [رواه مسلم: 2726].',
    },
    {
      'title': 'تشميت العاطس',
      'description':
          'عن أبي هريرة رضي الله عنه ، عن النبي ـ صلى الله عليه وسلم ـ قال: (( إذا عطس أحدُكُم فليقل: الحمد لله ، وليقل له أخوه أو صاحبه : يرحمك الله. فإذا قال له: يرحمك الله ، فليقل: يهديكم اللهُ ويُصْلِحُ بالكم )) [ رواه البخاري: 6224 ].',
    },
    {
      'title': 'الدعاء للمريض',
      'description':
          'عن ابن عباس رضي الله عنهما، أن رسول الله ـ صلى الله عليه وسلم ـ دخل على رجل يعوده ، فقال صلى الله عليه وسلم : (( لا بأس طهور ، إن شاء الله )) [ رواه البخاري: 5662].',
    },
    {
      'title': 'وضع اليد على موضع الألم ، مع الدعاء',
      'description':
          'عن عثمان بن أبي العاص رضي الله عنه ، أنه شكا إلى رسول الله ـ صلى الله عليه وسلم ـ وجعًا، يجده في جسده مُنذ أسلم ، فقال له رسول الله صلى الله عليه وسلم : (( ضع يدك على الذي يألم من جسدك، وقل: باسم الله ، ثلاثًا ، وقل سبع مرات: أعوذُ بالله وقدرتهِ من شَر ما أجد وأُحَاذر )) [ رواه مسلم: 5737 ].',
    },
    {
      'title': 'الدعاء عند سماع صياح الديك ، والتعوذ عند سماع نهيق الحمار',
      'description':
          'عن أبي هريرة رضي الله عنه ، أن النبي ـ صلى الله عليه وسلم ـ قال: (( إذا سمعتم صياح الديكة فاسألوا الله من فضله، فإنها رأت مَلَكًا ، وإذا سمعتم نهيق الحمار فتعوذوا بالله من الشيطان ، فإنها رأت شيطانًا )) [ متفق عليه:3303 - 6920 ].',
    },
    {
      'title': 'الدعاء عند نزول المطر',
      'description':
          'عن عـائشة رضي الله عنها ، أن رسول الله ـ صلى الله عليه وسلم ـ كان إذا رأى المطر قال: (( اللهم صيبًا نافعًا )) [ رواه البخاري: 1032 ].',
    },
    {
      'title': 'ذكر الله عند دخول المنزل',
      'description':
          'عن جابر بن عبدالله ـ رضي الله عنه ـ قال : سمعت النبي ـ صلى الله عليه وسلم ـ يقول: (( إذا دخل الرجل بيته فذكر الله ـ عز وجل ـ عند دخوله ، وعند طعامه، قال الشيطان : لا مبيت لكم ولا عشاء. وإذا دخل فلم يذكر الله عند دخوله ، قال الشيطان : أدركتم المبيت، وإذا لم يذكر الله عند طعامه ، قال : أدركتم المبيت والعشاء)) [ رواه مسلم: 5262 ].',
    },
    {
      'title': 'ذكر الله في المجلس',
      'description':
          'عن أبي هريرة رضي الله عنه ، عن النبي ـ صلى الله عليه وسلم ـ قال: (( ما جلس قوم مجلسًا لم يذكروا الله فيه ، ولم يُصَلوا على نبيهم،إلا كان عليهم تِرَة (أي: حسرة) فإن شاء عذبهم، وإن شاء غفر لهم )) [ رواه الترمذي: 3380 ].',
    },
    {
      'title': 'الدعاء عند دخول الخلاء',
      'description':
          'عن أنس بن مالك ـ رضي الله عنه ـ قال: كان النبي ـ صلى الله عليه وسلم ـ إذا دخل (أي: أراد دخول) الخلاء قال: (( اللهم إني أعوذ بك من الخبث والخبائث )) [متفق عليه: 6322-831].',
    },
    {
      'title': 'الدعاء عندما تعصف الريح',
      'description':
          'عن عائشة ـ رضي الله عنه ـ قالت: كان النبي ـ صلى الله عليه وسلم ـ إذا عصفت الريح قال: (( اللهم إني أسألك خيرها ، وخير ما فيها ، وخير ما أُرسلت به، وأعوذ بك من شرها ، وشر ما فيها ، وشر ما أُرسلت به )) [ رواه مسلم: 2085 ].',
    },
    {
      'title': 'الدعاء للمسلمين بظهر الغيب',
      'description':
          'عن أبي الدرداء رضي الله عنه ، أنه سمع رسول الله ـ صلى الله عليه وسلم ـ يقول: (( من دعا لأخيه بظهر الغيب، قال المَلَكُ المُوَكَّلُ به: آمين ، ولك بمثل)) [ رواه مسلم: 6928 ].',
    },
    {
      'title': 'الدعاء عند المصيبة',
      'description':
          'عن أم سلمة ـ رضي الله عنها ـ أنها قالت ، سمعت رسول الله ـ صلى الله عليه وسلم ـ يقول: (( ما من مسلم تصيبه مصيبة فيقول ما أمره الله: إنا لله وإنا إليه راجعون ، اللهم أُجُرني في مُصيبتي وأَخلِف لي خيرًا منها ـ إلا أخلف الله له خيرًا منها )) [ رواه مسلم: 2126].',
    },
    {
      'title': 'إفشاء السلام',
      'description':
          'عن البَراءِ بن عازِب ـ رضي الله عنه ـ قال: (( أمَرنا النبي ـ صلى الله عليه وسلم ـ بسبع ، ونهانا عن سَبع: أمرنا بعِيادة المريض، ... وإفشَاء السلام ،... الحديث )) [ متفق عليه: 5175 - 5388 ].',
    },
  ];

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateItems());
  }

  void _animateItems() async {
    for (int i = 0; i < dhikrAndDuaSunnahs.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      _listKey.currentState?.insertItem(i);
      // await _scrollController.animateTo(
      //   _scrollController.position.maxScrollExtent,
      //   duration: const Duration(milliseconds: 300),
      //   curve: Curves.easeOut,
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'الذكر والدعاء',
          style: GoogleFonts.tajawal(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : theme.colorScheme.inversePrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDarkMode ? Colors.white : theme.colorScheme.inversePrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.colorScheme.surface.withOpacity(0.8),
                    theme.colorScheme.surface,
                    theme.colorScheme.surface,
                  ],
                )
              : null,
          color: isDarkMode ? theme.colorScheme.surface : theme.colorScheme.surface,
        ),
        child: AnimatedList(
          key: _listKey,
          controller: _scrollController,
          initialItemCount: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          itemBuilder: (context, index, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.5),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutQuart,
                )),
                child: _buildSunnahCard(context, index),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSunnahCard(BuildContext context, int index) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color.fromARGB(255, 90, 90, 90) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isDarkMode
            ? null
            : [
                BoxShadow(
                  color: theme.colorScheme.primary,
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          dhikrAndDuaSunnahs[index]['title']!,
          textAlign: TextAlign.right,
          style: GoogleFonts.tajawal(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : theme.colorScheme.surface,
          ),
        ),
        children: [
          Divider(
            height: 1,
            thickness: 1,
            color: theme.colorScheme.primary.withOpacity(0.1),
            indent: 16,
            endIndent: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                dhikrAndDuaSunnahs[index]['description']!,
                textAlign: TextAlign.start,
                style: GoogleFonts.tajawal(
                  fontSize: 16,
                  height: 1.5,
                  color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                ),
              ),
            ),
          ),
        ],
        iconColor: theme.colorScheme.primary,
        collapsedIconColor: theme.colorScheme.primary,
      ),
    );
  }
}