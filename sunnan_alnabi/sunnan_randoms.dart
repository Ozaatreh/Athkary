import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RandomsSunnahsScreen extends StatefulWidget {
  const RandomsSunnahsScreen({super.key});

  @override
  State<RandomsSunnahsScreen> createState() => _RandomsSunnahsScreenState();
}

class _RandomsSunnahsScreenState extends State<RandomsSunnahsScreen> {
  final List<Map<String, String>> miscellaneousSunnahs = const [
    {
      'title': 'طلب العلم',
      'description':
          'عن أبي هريرة ـ رضي الله عنه ـ قال: قال رسول الله صلى الله عليه وسلم : (( من سلك طريقًا يلتمس فيه علمًا سهل الله له به طريقًا إلى الجنة )) [ رواه مسلم: 6853 ].',
    },
    {
      'title': 'الاستئذان قبل الدخول ثلاثاً',
      'description':
          'عن أبي موسى الأشعري رضي الله عنه ، أن رسول الله صلى الله عليه وسلم قال: (( الاستئذان ثلاثٌ، فإن أُذن لك، و إلا فارجع )) [ متفق عليه:6245- 5633 ].',
    },
    {
      'title': 'تحنيك المولود',
      'description':
          'عن أبي موسى الأشعري ـ رضي الله عنه ـ قال: (( وُلد لي غلام ، فأتيت به النبي ـ صلى الله عليه وسلم ـ فسماه إبراهيم ، فحنكه بتمرة ودعا له بالبركة ... الحديث )) [متفق عليه: 5467 - 5615]. * التحنيك: هو مضغ طعام حلو ، وتحريكه في فم المولود ، والأفضل أن يكون التحنيك بالتمر.',
    },
    {
      'title': 'العقيقة عن المولود',
      'description':
          'عن عائشة ـ رضي الله عنها ـ قالت : (( أمرنا رسول الله ـ صلى الله عليه وسلم ـ أن نعق عن الجارية شاة ، وعن الغلام شاتين )) [ رواه أحمد: 25764 ].',
    },
    {
      'title': 'كشف بعض البدن ليصيبه المطر',
      'description':
          'عن أنس ـ رضي الله عنه ـ قال: أصابنا مع رسول الله ـ صلى الله عليه وسلم ـ مطر . قال: فحسر رسول الله ـ صلى الله عليه وسلم ـ عن ثوبه حتى أصابه من المطر ، فقلنا: يا رسول الله! لم صنعت هذا؟ قال: (( لأنه حديث عهد بربه)) [ رواه مسلم: 2083 ]. * حسر عن ثوبه أي: كشف بعض بدنه.',
    },
    {
      'title': 'عيادة المريض',
      'description':
          'عن ثوبان ، مولى رسول الله صلى الله عليه وسلم ، عن رسول الله ـ صلى الله عليه وسلم ـ قال: (( من عاد مريضا ، لم يزل في خُرفَة الجنة )) قيل : يا رسول الله! وما خُرفة الجنة؟ قال: (( جناها )) [ رواه مسلم: 6554 ].',
    },
    {
      'title': 'التبسم',
      'description':
          'عن أبي ذر ـ رضي الله عنه ـ قال: قال لي النبي صلى الله عليه وسلم : (( لا تحقرن من المعروف شيئا ، ولو أن تلقى أخاك بوجه طلق )) [ رواه مسلم: 6690 ].',
    },
    {
      'title': 'التزاور في الله',
      'description':
          'عن أبي هريرة رضي الله عنه ، عن النبي صلى الله عليه وسلم : (( أن رجلاً زار أخاً له في قرية أخرى ، فأرصد الله له على مدرجته ملكًا ( أي: أقعده على الطريق يرقبه ) فلما أتى عليه قال: أين تريد؟ قال: أريد أخاً لي في هذه القرية. قال: هل لك عليه من نعمة تربها؟ قال: لا ، غير أني أحببته في الله عز وجل ، قال: فإني رسول الله إليك ، بأن الله قد أحبك كما أحببته فيه )) [ رواه مسلم: 6549 ].',
    },
    {
      'title': 'إعلام الرجل أخيه أنه يحبه',
      'description':
          'عن المقدام بن معدي كرب رضي الله عنه ، أنَّ النبي ـ صلى الله عليه وسلم ـ قال: (( إذا أحب أحدكم أخاه ، فليُعْلِمه أنه يحبه )) [ رواه أحمد: 16303 ].',
    },
    {
      'title': 'رد التثاؤب',
      'description':
          'عن أبي هريرة ـ رضي الله عنه ـ قال : قال رسول الله صلى الله عليه وسلم : (( التثاؤب من الشيطان ، فإذا تثاءب أحدكم فليرده ما استطاع ، فإن أحدكم إذا قال: ها ، ضحك الشيطان )) [ متفق عليه:3289 - 7490 ].',
    },
    {
      'title': 'إحسان الظن بالناس',
      'description':
          'عن أبي هــريرة رضي الله عنه ، أنَّ رســول الله ـ صلى الله عليه وسلم ـ قال: (( إياكم والظن، فإنَّ الظن أكذب الحديث )) [ متفق عليه: 6067-6536 ].',
    },
    {
      'title': 'معاونة الأهل في أعمال المنزل',
      'description':
          'عن الأسود قال: سَألتُ عائشة ـ رضي الله عنها ـ ما كان النبي ـ صلى الله عليه وسلم ـ يصنع في بيته؟ قالت: (( كان يكون في مهنة أهله (أي: خدمتهم) ، فإذا حضرت الصلاة خرج إلى الصلاة )) [ رواه البخاري: 676 ].',
    },
    {
      'title': 'سُنن الفطرة',
      'description':
          'عن أبي هريرة ـ رضي الله عنه ـ قال: قال رسول الله صلى الله عليه وسلم : (( الفطرة خمس، أو خمس من الفطرة: الختان ، والاستحداد (حلق شعر العانة)، ونتف الإبط، وتقليم الأظفار ، وقص الشارب )) [ متفق عليه: 5889 - 597 ].',
    },
    {
      'title': 'كفالة اليتيم',
      'description':
          'عن سهل بن سعد رضي الله عنه ، عن النبي صلى الله عليه وسلم قال: (( أنا وكافل اليتيم في الجنة هكذا )) . و قال بإصبعيه السبابة والوسطى.[ رواه البخاري: 6005 ].',
    },
    {
      'title': 'تجنب الغضب',
      'description':
          'عن أبي هريرة رضي الله عنه ، أن رجلاً قال للنبي صلى الله عليه وسلم : أوصني ، قال: (( لا تغضب )) . فردد مرارًا ، قال: (( لا تغضب )) [ رواه البخاري: 6116 ].',
    },
    {
      'title': 'البكاء من خشية الله',
      'description':
          'عن أبي هريرة رضي الله عنه ، عن النبي ـ صلى الله عليه وسلم ـ قال: (( سبعة يظلهم الله في ظله ، يوم لا ظل إلا ظله ... وذكر منهم : ورجل ذكر الله خاليًا ففاضت عيناه )) [ متفق عليه: 660-1031 ].',
    },
    {
      'title': 'الصدقة الجارية',
      'description':
          'عن أبي هريرة رضي الله عنه، أن رسول الله ـ صلى الله عليه وسلم ـ قال: (( إذا مات الإنسان انقطع عمله إلا من ثلاث: إلا من صدقة جارية ، أو علم ينتفع به ، أو ولد صالح يدعو له )) [رواه مسلم: 4223].',
    },
    {
      'title': 'بناء المساجد',
      'description':
          'عن عثمان بن عفان ـ رضي الله عنه ـ قال عند قول الناس فيه حين بنى مسجد رسول الله صلى الله عليه وسلم : إنكم أكثرتم وإني سمعت النبي ـ صلى الله عليه وسلم ـ يقول: (( من بنى مسجدًا ـ قال بُكير: حسبت أنه قال: يبتغي به وجه الله ـ بنى الله له مثله في الجنة )) [ متفق عليه: 450- 533].',
    },
    {
      'title': 'السماحة في البيع والشراء',
      'description':
          'عن جابر بن عبدالله رضي الله عنهما ، أن رسول الله ـ صلى الله عليه وسلم ـ قال: (( رحم الله رجلاً سمحًا إذا باع ، و إذا اشترى ، وإذا اقتضى )) [رواه البخاري: 2076].',
    },
    {
      'title': 'إزالة الأذى عن الطريق',
      'description':
          'عن أبي هريرة رضي الله عنه ، أن رسول الله ـ صلى الله عليه وسلم ـ قال: (( بينما رجل يمشي بطريق ، وجد غُصن شوك على الطريق ، فأخره ، فشكر الله له ، فغفر له )) [ رواه مسلم: 4940].',
    },
    {
      'title': 'الصدقة',
      'description':
          'عن أبي هريرة ـ رضي الله عنه ـ قال ، قال رسول الله صلى الله عليه وسلم : (( من تصدق بعدل تمرة من كسب طيب ، ولا يقبل الله إلا الطيب ، فإن الله يتقبلها بيمينه ، ثم يربيها لصاحبه كما يربي أحدكم فَلُوة حتى تكون مثل الجبل )) [متفق عليه: 1410-1014].',
    },
    {
      'title': 'الإكثار من الأعمال الصالحة في عشر ذي الحجة',
      'description':
          'عن بن عباس رضي الله عنه ، عن النبي صلى الله عليه وسلم ، أنه قال: (( ما العمل في أيام أفضل منها في هذه ( يعني أيام العشر) )) قالوا: ولا الجهاد؟ قال: (( ولا الجهاد ، إلا رجل خرج يخاطر بنفسه وماله فلم يرجع بشيء )) [رواه البخاري: 969].',
    },
    {
      'title': 'قتل الوزغ',
      'description':
          'عن أبي هريرة ـ رضي الله عنه ـ قال: قال رسول الله صلى الله عليه وسلم : (( من قتل وزغا في أول ضربة كتبت له مئة حسنة ، وفي الثانية دون ذلك ، وفي الثالثة دون ذلك )) [ رواه مسلم 8547 ].',
    },
    {
      'title': 'النهي عن أن يُحَدِّث المرء بكل ما سمع',
      'description':
          'عن حفص بن عاصم ـ رضي الله عنه ـ قال: قال رسول الله صلى الله عليه وسلم : (( كفى بالمرء إثمًأ أن يُحَدِّث بكل ما سمع )) [رواه مسلم: 7 ].',
    },
    {
      'title': 'احتساب النفقة على الأهل',
      'description':
          'عن أبي مسعود البدري رضي الله عنه ، عن النبي ـ صلى الله عليه وسلم ـ قال: (( إن المسلم إذا أنفق على أهله نفقة ، وهو يحتسبُها، كانت له صدقة )) [ رواه مسلم: 2322].',
    },
    {
      'title': 'الرَّمَل في الطواف',
      'description':
          'عن ابن عمر ـ رضي الله عنهما ـ قال: (( كان رسول الله ـ صلى الله عليه وسلم ـ إذا طاف الطواف الأول، خبَّ (أي:رَمَلَ) ثلاثًا ومشى أربعًا ... الحديث )) [ متفق عليه :1644- 3048 ]. الرَّمَل: هو الإسراع بالمشي مع مقاربة الخطى. ويكون في الأشواط الثلاثة من الطواف الذي يأتي به المسلم أول ما يقدم إلى مكة ، سواء كان حاجًا أو معتمرًا.',
    },
    {
      'title': 'المداومة على العمل الصالح وإن قل',
      'description':
          'عن عائشة رضي الله عنها ، أنها قالت: سُئل رسول الله صلى الله عليه وسلم : أي الأعمال أحب إلى الله؟ قال: (( أدوَمها وإن قلَّ )) [ متفق عليه:6465- 1828 ].',
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
    for (int i = 0; i < miscellaneousSunnahs.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      _listKey.currentState?.insertItem(i);
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
          'سنن متنوعة',
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
          miscellaneousSunnahs[index]['title']!,
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
            child: Text(
              miscellaneousSunnahs[index]['description']!,
              textAlign: TextAlign.right,
              style: GoogleFonts.amiri(
                fontSize: 16,
                height: 1.5,
                color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
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