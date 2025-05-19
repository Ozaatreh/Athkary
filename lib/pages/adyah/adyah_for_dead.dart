import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdyahForDead extends StatefulWidget {
  const AdyahForDead({super.key});

  @override
  State<AdyahForDead> createState() => _AdyahForDeadState();
}

class _AdyahForDeadState extends State<AdyahForDead> {
    
      final List adyahfordead = [
    "اللَّهُمَّ أبدله داراً خيراً من داره، وأهلاً خيراً من أهله، وأدخله الجنّة، وأعذه من عذاب القبر ومن عذاب النّار",
    "اللَّهُمَّ عامله بما أنت أهله، ولا تعامله بما هو أهله",
    "اللَّهُمَّ اجزه عن الإحسان إحساناً وعن الإساءة عفواً وغفراناً",
    "اللَّهُمَّ إن كان محسناً فزد من حسناته، وإن كان مسيئاً فتجاوز عن سيّئاته",
    "اللَّهُمَّ أدخله الجنّة من غير مناقشة حساب ولا سابقة عذاب",
    "اللَّهُمَّ آنسه في وحدته وفي وحشته وفي غربته",
    "اللَّهُمَّ أنزله منزلاً مباركاً وأنت خير المنزلين",
    "اللَّهُمَّ أنزله منازل الصدّيقين والشّهداء والصّالحين، وحسن أولئك رفيقاً",
    "اللَّهُمَّ اجعل قبره روضةً من رياض الجنّة، ولا تجعله حفرةً من حفر النّار",
    "اللَّهُمَّ افسح له في قبره مدّ بصره، وافرش قبره من فراش الجنّة",
    "اللَّهُمَّ أعذه من عذاب القبر، وجفاف ِالأرض عن جنبيها",
    "اللَّهُمَّ املأ قبره بالرّضا والنّور والفسحة والسّرور",
    "اللَّهُمَّ إنّه في ذمّتك وحبل جوارك، فقِهِِ فتنة القبر، وعذاب النّار، وأنت أهل الوفاء والحقّ، فاغفر له وارحمه إنّك أنت الغفور الرّحيم.",
    "اللَّهُمَّ إنّه عبدك وابن عبدك خرج من الدّنيا وسعتها ومحبوبها وأحبّائه فيها إلى ظلمة القبر وما هو لاقيه",
    "اللَّهُمَّ إنّه كان يشهد أنّك لا إله إلّا أنت وأنّ محمّداً عبدك ورسولك وأنت أعلم به",
    "اللَّهُمَّ إنّا نتوسّل بك إليك، ونقسم بك عليك أن ترحمه ولا تعذّبه، وأن تثبّته عند السؤال",
    "اللَّهُمَّ إنّه نَزَل بك وأنت خير منزولٍ به، وأصبح فقيراً إلى رحمتك وأنت غنيٌّ عن عذابه",
    "اللَّهُمَّ آته برحمتك ورضاك، وقهِ فتنة القبر وعذابه، وآته برحمتك الأمن من عذابك حتّى تبعثه إلى جنّتك يا أرحم الرّاحمين",
    "اللَّهُمَّ انقله من مواطن الدّود وضيق اللحود إلى جنّات الخلود",
    "اللَّهُمَّ احمه تحت الأرض، واستره يوم العرض، ولا تخزه يوم يبعثون يوم لا ينفع مالٌ ولا بنون إلّا من أتى الله بقلبٍ سليم",
    "اللَّهُمَّ يمّن كتابه، ويسّر حسابه، وثقّل بالحسنات ميزانه، وثبّت على الصّراط أقدامه، وأسكنه في أعلى الجنّات بجوار حبيبك ومصطفاك (صلّى الله عليه وسلّم)",
    "اللَّهُمَّ أمّنه من فزع يوم القيامة، ومن هول يوم القيامة، واجعل نفسه آمنة مطمئنّة، ولقّنه حجّته",
    "اللَّهُمَّ اجعله في بطن القبر مطمئنّاً وعند قيام الأشهاد آمن، وبجود رضوانك واثق، وإلى أعلى درجاتك سابق",
    "اللَّهُمَّ اجعل عن يمينه نوراً حتّى تبعثه آمناً مطمئنّاً في نورٍ من نورك",
    "اللَّهُمَّ انظر إليه نظرة رضا، فإنّ من تنظر إليه نظرة رضا لا تعذّبه أبداً",
    "اللَّهُمَّ أسكنه فسيح الجنان، واغفر له يا رحمن، وارحمه يا رحيم، وتجاوز عمّا تعلم يا عليم",
    "اللَّهُمَّ اعف عنه فإنّك القائل ويعفو عن كثير",
    "اللَّهُمَّ إنّه جاء ببابك، وأناخ بجنابك، فَجد عليه بعفوك وإكرامك وجود إحسانك",
    "اللَّهُمَّ إنّ رحمتك وسعت كلّ شيء فارحمه رحمةً تطمئنّ بها نفسه، وتقرّ بها عينه",
    "اللَّهُمَّ احشره مع المتّقين إلى الرّحمن وفداً",
    "اللَّهُمَّ احشره مع أصحاب اليمين، واجعل تحيّته سلامٌ لك من أصحاب اليمين",
    "اللَّهُمَّ بشّره بقولك كلوا واشربوا هنيئاً بما أسلفتم في الأيّام الخالية",
    "اللَّهُمَّ اجعله من الّذين سعدوا في الجنّة خالدين فيها ما دامت السموات والأرض",
    "اللَّهُمَّ لا نزكّيه عليك، ولكنّا نحسبه أنّه أمن وعمل صالحاً، فاجعل له جنّتين ذواتي أفنان بحقّ قولك: ولمن خاف مقام ربّه جنّتان",
    "اللَّهُمَّ شفع فيه نبيّنا ومصطفاك، واحشره تحت لوائه، واسقه من يده الشّريفة شربةً هنيئةً لا يظمأ بعدها أبداً",
    "اللَّهُمَّ اجعله في جنّة الخلد الَّتِي وُعِدَ الْمُتَّقُونَ كَانَتْ لَهُمْ جَزَاء وَمَصِيرًا. لَهُمْ فِيهَا مَا يَشَاؤُونَ خَالِدِينَ كَانَ عَلَى رَبِّكَ وَعْدًا مَسؤُولا",
    "اللَّهُمَّ إنّه صبر على البلاء فلم يجزع، فامنحه درجة الصّابرين الّذين يوفون أجورهم بغير حساب",
    "اللَّهُمَّ إنّه كان مصلّ لك، فثبّته على الصّراط يوم تزل الأقدام",
    "اللَّهُمَّ إنّه كان صائماً لك، فأدخله الجنّة من باب الريّان",
    "اللَّهُمَّ إنّه كان لكتابك تالٍ وسامع، فشفّع فيه القرآن، وارحمه من النّيران",
    "اللَّهُمَّ ارحمه فإنّه كان مسلماً، واغفر له فإنّه كان مؤمناً، وأدخله الجنّة فإنّه كان بنبيّك مصدّقاً، وسامحه فإنّه كان لكتابك مرتّلاً",
    "اللَّهُمَّ اغفر لحيّنا وميّتنا، وشاهدنا وغائبنا، وصغيرنا وكبيرنا، وذَكرنَا وأنثانا",
    "اللَّهُمَّ من أحييته منّا فأحيه على الإسلام، ومن توفّيته منّا فتوفّه على الإيمان",
    "اللَّهُمَّ لا تحرمنا أجره ولا تضللنا بعده",
    "اللَّهُمَّ أنزل على أهله الصّبر والسلوان وارضهم بقضائك",
    "اللَّهُمَّ ثبّتنا على القول الثّابت في الحياة الدّنيا، وفي الآخرة، ويوم يقوم الأشهاد",
    "اللَّهُمَّ صلّ وسلّم وبارك على سيّدنا محمّد، وعلى اّله وصحبه وسلّم إلى يوم الدّين"
];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateItems());
  }

  void _animateItems() async {
    for (int i = 0; i < adyahfordead.length; i++) {
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
          "أدعية للميّت",
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
                child: _buildDuaCard(context, index),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDuaCard(BuildContext context, int index) {
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
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          title: Text(
            adyahfordead[index],
            textAlign: TextAlign.right,
            style: GoogleFonts.tajawal(
              fontSize: 20,
              height: 1.6,
              color: isDarkMode ? Colors.white : theme.colorScheme.surface,
            ),
          ),
        ),
      ),
    );
  }
}

