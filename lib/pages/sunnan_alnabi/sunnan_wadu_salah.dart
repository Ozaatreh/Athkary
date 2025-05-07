import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WuduAndSalahSunnahsScreen extends StatefulWidget {
  const WuduAndSalahSunnahsScreen({super.key});

  @override
  State<WuduAndSalahSunnahsScreen> createState() =>
      _WuduAndSalahSunnahsScreenState();
}

class _WuduAndSalahSunnahsScreenState extends State<WuduAndSalahSunnahsScreen> {
  final List<Map<String, String>> wuduAndSalahSunnahs = const [
    {
      'title': 'المضمضة والاستنشاق من غرفة واحدة',
      'description':
          'عن عبدالله بن زيد رضي الله عنه ، أنَّ رسول الله صلى الله عليه وسلم : (( تمضمض ، واستنشق من كف واحدة )) [ رواه مسلم: 555 ].',
    },
    {
      'title': 'الوضوء قبل الغُسل',
      'description':
          'عن عائشة رضي الله عنها ، أنَّ النبي صلى الله عليه وسلم : (( كان إذا اغتسل من الجنابة ، بدأ فغسل يديه ، ثم توضأ كما يتوضأ للصلاة ، ثم يُدخل أصابعه في الماء ، فيخلل بها أصول الشعر ، ثم يَصُب على رأسه ثلاث غُرف بيديه ، ثم يُفيض الماء على جلده كله )) [ رواه البخاري :248 ].',
    },
    {
      'title': 'التشهد بعد الوضوء',
      'description':
          'عن عمر بن الخطاب ـ رضي الله عنه ـ قال: قال رسول الله صلى الله عليه وسلم : (( ما منكم من أحد يتوضأ فيسبغ الوضوء ثم يقول : أشهد أنَّ لا إله إلا الله ، وأنَّ محمدًا عبده ورسوله إلاَّ فتحت له أبواب الجنة الثمانية ، يدخل من أيها شاء )) [ رواه مسلم: 553 ].',
    },
    {
      'title': 'الاقتصاد في الماء',
      'description':
          'عن أنس ـ رضي الله عنه ـ قال: (( كان النبي ـ صلى الله عليه وسلم ـ يغتسل بالصاع إلى خمسة أمداد ، ويتوضأ بالـمُد )) [ متفق عليه: 201- 737 ].',
    },
    {
      'title': 'صلاة ركعتين بعد الوضوء',
      'description':
          'قال النبي صلى الله عليه وسلم : (( من توضأ نحو وضوئي هذا ، ثم صلى ركعتين لا يُحَدِّثُ فيهما نفسه ، غُفر له ما تقدم من ذنبه )) [ متفق عليه من حديث حُمران مولى عثمان رضي الله عنهما:159- 539 ].',
    },
    {
      'title': 'الترديد مع المؤذن ثم الصلاة على النبي صلى الله عليه وسلم',
      'description':
          'عن عبدالله بن عمرو رضي الله عنهما ، أنه سمـع النبي ـ صلى الله عليه وسلم ـ يقــول: (( إذا سمعتم المؤذن فقولوا مثل ما يقول، ثم صلوا عليَّ، فإنه من صلى عليَّ صلاة ، صلى الله عليه بها عشرًا ... الحديث)) [ رواه مسلم: 849 ]. ثم يقول بعد الصلاة على النبي صلى الله عليه وسلم اللهم رب هذه الدعوة التامة ، والصلاة القائمة ، آت محمدًا الوسيلة والفضيلة ، وابعثه مقامًا محمودًا الذي وعدته ) رواه البخاري. من قال ذلك حلت له شفاعة النبي صلى الله عليه وسلم.',
    },
    {
      'title': 'الإكثار من السواك',
      'description':
          'عن أبي هريرة رضي الله عنه ، أن رسول الله ـ صلى الله عليه وسلم ـ قال: (( لولا أنْ أشق على أمتي ، لأمرتهم بالسواك عند كل صلاة )) [ متفق عليه:887 - 589 ]. ** كما أن من السنة، السواك عند الاستيقاظ من النوم ، وعند الوضوء ، وعند تغير رائحة الفم ، وعند قراءة القرآن ، وعند دخول المنزل.',
    },
    {
      'title': 'التبكير إلى المسجد',
      'description':
          'عن أبي هريرة ـ رضي الله عنه ـ قال: قال رسول الله صلى الله عليه وسلم : (( ... ولو يعلمون ما في التهجير ( التبكير ) لاستبقوا إليه ... الحديث )) [ متفق عليه: 615-981 ].',
    },
    {
      'title': 'الذهاب إلى المسجد ماشيا',
      'description':
          'عن أبي هريرة رضي الله عنه ، أن رسول الله ـ صلى الله عليه وسلم ـ قال: (( ألا أدلكم على ما يمحو الله به الخطايا ، ويرفع به الدرجات )) قالوا: بلى يا رسول الله. قال: (( إسباغ الوضوء على المكاره ، وكثرة الخطا إلى المساجد ، وانتظار الصلاة بعد الصلاة، فذلكم الرباط )) [ رواه مسلم: 587 ].',
    },
    {
      'title': 'إتيان الصلاة بسكينة ووقار',
      'description':
          'عن أبي هـريرة ـ رضي الله عنه ـ قال: سمعت رسول الله ـ صلى الله عليه وسلم ـ يقول: (( إذا أقيمت الصلاة فلا تأتوها تسعون ، وأتوها تمشون ، وعليكم السكينة، فما أدركتم فصلوا ، وما فاتكم فأتموا )) [ متفق عليه: 908 - 1359 ].',
    },
    {
      'title': 'الدعاء عند دخول المسجد ، و الخروج منه',
      'description':
          'عن أبي حُميد الساعدي ، أو عن أبي أُسيد ـ رضي الله عنهما ـ قال: قال رسول الله صلى الله عليه وسلم : (( إذا دخل أحدكم المسجد فليقل: اللهم افتح لي أبواب رحمتك ، وإذا خرج فليقل: اللهم إني أسألك من فضلك )) [ رواه مسلم: 1652 ].',
    },
    {
      'title': 'الصلاة إلى سترة',
      'description':
          'عن موسى بن طلحة عن أبيه قال: قال رسول الله صلى الله عليه وسلم : (( إذا وضع أحدكم بين يديه مثل مؤخرة الرحل فليُصَلِّ ، ولا يبال مَنْ مر وراء ذلك)) [ رواه مسلم: 1111 ]. * السترة هي: ما يجعله المصلي أمامه حين الصلاة ، مثل: الجدار ، أو العمود ، أو غيره. ومؤخرة الرحل: ارتفاع ثُلثي ذراع تقريبا.',
    },
    {
      'title': 'الإقعاء بين السجدتين',
      'description':
          'عن أبي الزبير أنه سمع طاووسا يقول: قلنا لابن عباس ـ رضي الله عنه ـ في الإقعاء على القدمين ، فقال : (( هي السنة ))، فقلنا له: إنا لنراه جفاء بالرجل ، فقال ابن عباس: (( بل هي سنة نبيك صلى الله عليه وسلم )) [ رواه مسلم: 1198 ]. * الإقعاء هو: نصب القدمين والجلوس على العقبين ، ويكون ذلك حين الجلوس بين السجدتين.',
    },
    {
      'title': 'التورك في التشهد الثاني',
      'description':
          'عن أبي حميد الساعدي ـ رضي الله عنه ـ قال: (( كان رسول الله ـ صلى الله عليه وسلم ـ إذا جلس في الركعة الآخرة ، قدم رجله اليسرى ، ونصب الأخرى ، وقعد على مقعدته )) [ رواه البخاري: 828 ].',
    },
    {
      'title': 'الإكثار من الدعاء قبل التسليم',
      'description':
          'عن عبدالله بن عمر ـ رضي الله عنهما ـ قال: (( كنا إذا كنا مع النبي ـ صلى الله عليه وسلم ـ،إلى أن قال: ثم ليتخير من الدعاء أعجبه إليه فيدعو )) [ رواه البخاري: 835 ].',
    },
    {
      'title': 'أداء السنن الرواتب',
      'description':
          'عن أم حبيبة رضي الله عنها ، أنها سمعـت رسول الله ـ صلى الله عليه وسلم ـ يقول( ما من عبد مسلم يصلي لله كل يوم ثنتي عشرة ركعة تطوعًا غير الفريضة ، إلا بنى الله له بيتًا في الجنة )) [ رواه مسلم: 1696 ]. * السنن الرواتب: عددها اثنتا عشرة ركعة، في اليوم والليلة : أربع ركعات قبل الظهر ، وركعتان بعدها ، وركعتان بعد المغرب ، وركعتان بعد العشاء ، وركعتان قبل الفجر.',
    },
    {
      'title': 'صلاة الضحى',
      'description':
          'عن أبي ذر رضي الله عنه ، عن النبي ـ صلى الله عليه وسلم ـ أنه قال: (( يصبح على كل سلامى ( أي: مفصل) من أحدكم صدقة ، فكل تسبيحة صدقة ، وكل تحميدة صدقة ، وكل تهليلة صدقة ، وكل تكبيرة صدقة ، وأمر بالمعروف صدقة ، ونهي عن المنكر صدقة ، ويجزىء من ذلك ركعتان يركعهما من الضحى )) [ رواه مسلم: 1671 ]. * وأفضل وقتها حين ارتفاع النهار، واشتداد حرارة الشمس ، ويخرج وقتها بقيام قائم الظهيرة، وأقلها ركعتان ، ولا حدَّ لأكثرها.',
    },
    {
      'title': 'قيام الليل',
      'description':
          'عن أبي هريرة رضي الله عنه ، أن رسول الله ـ صلى الله عليه وسلم ـ سُئل : أي الصلاة أفضل بعد المكتوبة، فقال: (( أفضل الصلاة بعد الصلاة المكتوبة ، الصلاة في جوف الليل )) [ رواه مسلم: 2756 ].',
    },
    {
      'title': 'صلاة الوتر',
      'description':
          'عن ابن عمر رضي الله عنهما ، أنَّ النبي ـ صلى الله عليه وسلم ـ قال: (( اجعلوا آخر صلاتكم بالليل وترًا )) [متفق عليه:998 - 1755].',
    },
    {
      'title': 'الصلاة في النعلين إذا تحققت طهارتهما',
      'description':
          'سُئل أنس بن مالك رضي الله عنه : أكان النبي ـ صلى الله عليه وسلم ـ يصلي في نعليه؟ قال: (( نعم )) [ رواه البخاري: 386 ].',
    },
    {
      'title': 'الصـلاة في مسجد قباء',
      'description':
          'عن ابن عمر ـ رضي الله عنهما ـ قال: (( كان النبي ـ صلى الله عليه وسلم ـ يأتي قباء راكبًا وماشيًا )) زاد ابن نمير: حدثنا عبيدالله،عن نافع: (( فيصلي فيه ركعتين )) [متفق عليه: 1194 – 3390 ].',
    },
    {
      'title': 'أداء صلاة النافلة في البيت',
      'description':
          'عن جابر ـ رضي الله عنه ـ قال: قال رسول الله صلى الله عليه وسلم : (( إذا قضى أحدكم الصلاة في مسجده فليجعل لبيته نصيبًا من صلاته ، فإن الله جاعل في بيته من صلاته خيرا )) [ رواه مسلم: 1822 ].',
    },
    {
      'title': 'صلاة الاستخارة',
      'description':
          'عن جابر بن عبدالله ـ رضي الله عنه ـ قال: (( كان رسول الله ـ صلى الله عليه وسلم ـ يعلمنا الاستخارة في الأمور كما يعلمنا السورة من القرآن )) [ رواه البخاري: 1162 ]. * وصفتها كما ورد في الحديث السابق: أن يصلي المرء ركعتين ، ثم يقول : (( اللهم إني أستخيرك بعلمك، وأستقدرك بقدرتك، وأسألك من فضلك العظيم ، فإنك تقدر ولا أقدر ، وتعلم ولا أعلم ، وأنت علام الغيوب ، اللهم إن كنت تعلم أن هذا الأمر (ويسمي حاجته) خير لي في ديني ، ومعاشي ، وعاقبة أمري ، فاقدره لي ، ويسره لي ، ثم بارك لي فيه ، وإن كنت تعلم أن هذا الأمر شر لي في ديني ، و معاشي ، وعاقبة أمري ، فاصرفه عني ، واصرفني عنه ، واقدر لي الخير حيث كان ثم أرضني به )).',
    },
    {
      'title': 'الجلوس في المصلى بعد صلاة الفجر حتى تطلع الشمس',
      'description':
          'عن جابر بن سمرة رضي الله عنه : ( أن النبي ـ صلى الله عليه وسلم ـ كان إذا صلى الفجر جلس في مصلاه حتى تطلع الشمس حسنا ) [ رواه مسلم: 1526].',
    },
    {
      'title': 'الاغتسال يوم الجمعة',
      'description':
          'عن ابن عمر ـ رضي الله عنهما ـ قال: قال رسول الله صلى الله عليه وسلم : (( إذا جاء أحدكم الجمعة فليغتسل )) [ متفق عليه: 877 -1951 ].',
    },
    {
      'title': 'التبكير إلى صلاة الجمعة',
      'description':
          'عن أبي هريرة ـ رضي الله عنه ـ قال: قال رسول الله صلى الله عليه وسلم : (( إذا كان يوم الجمعة ، وقفت الملائكة على باب المسجد ، يكتبون الأول فالأول ، ومثل المُهَجِّر ( أي:المبكر) كمثل الذي يهدي بدنة ، ثم كالذي يهدي بقرة ، ثم كبشاً ، ثم دجاجة، ثم بيضة ، فإذا خرج الإمام طووا صحفهم ، ويستمعون الذكر )) [ متفق عليه: 929 - 1964 ].',
    },
    {
      'title': 'تحري ساعة الإجابة يوم الجمعة',
      'description':
          'عن أبي هريرة رضي الله عنه ، أن رسول الله ـ صلى الله عليه وسلم ـ ذَكَرَ يوم الجمعة فقال: (( فيه ساعة، لا يوافقها عبد مسلم ، وهو قائم يصلي ، يسأل الله تعالى شيئًا ، إلا أعطاه إياه )) وأشار بيده يقللها. [ متفق عليه: 935 - 1969 ].',
    },
    {
      'title': 'الذهاب إلى مصلى العيد من طريق، والعودة من طريق آخر',
      'description':
          'عن جابر ـ رضي الله عنه ـ قال: (( كان النبي ـ صلى الله عليه وسلم ـ إذا كان يوم عيد خالف الطريق )) [ رواه البخاري: 986 ].',
    },
    {
      'title': 'الصلاة على الجنازة',
      'description':
          'عن أبي هريرة ـ رضي الله عنه ـ قال: قال رسول الله صلى الله عليه وسلم : ((من شهد الجنازة حتى يصلى عليها فله قيراط ، ومن شهدها حتى تدفن فله قيراطان )) قيل: وما القيراطان؟ قال: (( مثل الجبلين العظيمين )) [ رواه مسلم: 2189 ].',
    },
    {
      'title': 'زيارة المقابر',
      'description':
          'عن بريدة ـ رضي الله عنه ـ قال: قال رسول الله صلى الله عليه وسلم : (( كنت نهيتكم عن زيارة القبور فزوروها ...الحديث)) [ رواه مسلم: 2260 ]. * ملحوظة: النساء محرم عليهن زيارة المقابر كما أفتى بذلك الشيخ ابن باز ـ رحمه الله ـ وجمع من العلماء.',
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
    for (int i = 0; i < wuduAndSalahSunnahs.length; i++) {
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
          'سنن الوضوء والصلاة',
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
          wuduAndSalahSunnahs[index]['title']!,
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
              wuduAndSalahSunnahs[index]['description']!,
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