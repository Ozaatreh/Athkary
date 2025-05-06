import 'dart:async';
import 'dart:io';
import 'package:athkary/pages/quran/quran_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuranViewerScreen extends StatefulWidget {
  final String pdfPath;
  final int startPage;

  const QuranViewerScreen({Key? key, required this.pdfPath, this.startPage = 1}) : super(key: key);

  @override
  _QuranViewerScreenState createState() => _QuranViewerScreenState();
}

class _QuranViewerScreenState extends State<QuranViewerScreen> {
  late PDFViewController _pdfViewController;
  int pages = 0;
  int currentPage = 0;
  bool isReady = false;
  String? localPath;
  bool isNightMode = false;
  bool isReloading = false;
  bool isAppBarVisible = true;
  Timer? _appBarTimer;
  final TextEditingController _pageController = TextEditingController();
  bool isHorizontalScroll = true; // Track scroll direction

  // Map page index to Surah description
 final Map<int, String> surahDescriptions = {
  0: '''
بِسْمِ اللهِ الرَّحْمنِ الرَّحِيمِ (1)
سورة الفاتحة سميت هذه السورة بالفاتحة; لأنه يفتتح بها القرآن العظيم, وتسمى المثاني; لأنها تقرأ في كل ركعة, ولها أسماء أخر. أبتدئ قراءة القرآن باسم الله مستعينا به, (اللهِ) علم على الرب -تبارك وتعالى- المعبود بحق دون سواه, وهو أخص أسماء الله تعالى, ولا يسمى به غيره سبحانه. (الرَّحْمَنِ) ذي الرحمة العامة الذي وسعت رحمته جميع الخلق, (الرَّحِيمِ) بالمؤمنين, وهما اسمان من أسمائه تعالى، يتضمنان إثبات صفة الرحمة لله تعالى كما يليق بجلاله.
الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ (2)
(الحَمْدُ للهِ رَبِّ العَالَمِينَ) الثناء على الله بصفاته التي كلُّها أوصاف كمال, وبنعمه الظاهرة والباطنة، الدينية والدنيوية، وفي ضمنه أَمْرٌ لعباده أن يحمدوه, فهو المستحق له وحده, وهو سبحانه المنشئ للخلق, القائم بأمورهم, المربي لجميع خلقه بنعمه, ولأوليائه بالإيمان والعمل الصالح.
الرَّحْمَنِ الرَّحِيمِ (3)
(الرَّحْمَنِ) الذي وسعت رحمته جميع الخلق, (الرَّحِيمِ), بالمؤمنين, وهما اسمان من أسماء الله تعالى.
مَالِكِ يَوْمِ الدِّينِ (4)
وهو سبحانه وحده مالك يوم القيامة, وهو يوم الجزاء على الأعمال. وفي قراءة المسلم لهذه الآية في كل ركعة من صلواته تذكير له باليوم الآخر, وحثٌّ له على الاستعداد بالعمل الصالح, والكف عن المعاصي والسيئات.
إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ (5)
إنا نخصك وحدك بالعبادة, ونستعين بك وحدك في جميع أمورنا, فالأمر كله بيدك, لا يملك منه أحد مثقال ذرة. وفي هذه الآية دليل على أن العبد لا يجوز له أن يصرف شيئًا من أنواع العبادة كالدعاء والاستغاثة والذبح والطواف إلا لله وحده, وفيها شفاء القلوب من داء التعلق بغير اله, ومن أمراض الرياء والعجب, والكبرياء.
اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ (6)
دُلَّنا, وأرشدنا, ووفقنا إلى الطريق المستقيم, وثبتنا عليه حتى نلقاك, وهو الإسلام، الذي هو الطريق الواضح الموصل إلى رضوان الله وإلى جنته, الذي دلّ عليه خاتم رسله وأنبيائه محمد صلى الله عليه وسلم, فلا سبيل إلى سعادة العبد إلا بال الاستقامة عليه.
صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلا الضَّالِّينَ (7)
طريق الذين أنعمت عليهم من النبيين والصدِّيقين والشهداء والصالحين, فهم أهل الهداية والاستقامة, ولا تجعلنا ممن سلك طريق المغضوب عليهم, الذين عرفوا الحق ولم يعملوا به, وهم اليهود, ومن كان على شاكلتهم, والضالين, وهم الذين لم يهتدوا, فضلوا الطريق, وهم النصارى, ومن اتبع سنتهم. وفي هذا الدعاء شفاء لقلب المسلم من مرض الجحود والجهل والضلال, ودلالة على أن أعظم نعمة على الإطلاق هي نعمة الإسلام, فمن كان أعرف للحق وأتبع له, كان أولى بالصراط المستقيم, ولا ريب أن أصحاب رسول الله صلى الله عليه وسلم هم أولى الناس بذلك بعد الأنبياء عليهم السلام, فدلت الآية على فضلهم, وعظيم منزلتهم, رضي الله عنهم. ويستحب للقارئ أن يقول في الصلاة بعد قراءة الفاتحة: (آمين), ومعناها: اللهم استجب, وليست آية من سورة الفاتحة باتفاق العلماء; ولهذا أجمعوا على عدم كتابتها في المصاحف.
''',
  1: '''
الم (1)
هذه الحروف وغيرها من الحروف المقطَّعة في أوائل السور فيها إشارة إلى إعجاز القرآن; فقد وقع به تحدي المشركين, فعجزوا عن معارضته, وهو مركَّب من هذه الحروف التي تتكون منها لغة العرب. فدَلَّ عجز العرب عن الإتيان بمثله -مع أنهم أفصح الناس- على أن القرآن وحي من الله.
ذَلِكَ الْكِتَابُ لا رَيْبَ فِيهِ هُدًى لِلْمُتَّقِينَ (2)
ذلك القرآن هو الكتاب العظيم الذي لا شَكَّ أنه من عند الله, فلا يصح أن يرتاب فيه أحد لوضوحه, ينتفع به المتقون بالعلم النافع والعمل الصالح وهم الذين يخافون الله, ويتبعون أحكامه.
الَّذِينَ يُؤْمِنُونَ بِالْغَيْبِ وَيُقِيمُونَ الصَّلاة وَمِمَّا رَزَقْنَاهُمْ يُنفِقُونَ (3)
وهم الذين يُصَدِّقون بالغيب الذي لا تدركه حواسُّهم ولا عقولهم وحدها; لأنه لا يُعْرف إلا بوحي الله إلى رسله, مثل الإيمان بالملائكة, والجنة, والنار, وغير ذلك مما أخبر الله به أو أخبر به رسوله، (والإيمان: كلمة جامعة للإقرار بالله وملائكته وكتبه ورسله واليوم الآخر والقدر خيره وشره، وتصديق الإقرار بالقول والعمل بالقلب واللسان والجوارح) وهم مع تصديقهم بالغيب يحافظون على أداء الصلاة في مواقيتها أداءً صحيحًا وَفْق ما شرع الله لنبيه محمد صلى الله عليه وسلم, ومما أعطيناهم من المال يخرجون صدقة أموالهم الواجبة والمستحبة.
وَالَّذِينَ يُؤْمِنُونَ بِمَا أُنْزِلَ إِلَيْكَ وَمَا أُنْزِلَ مِنْ قَبْلِكَ وَبِالآخرَةِ هُمْ يُوقِنُونَ (4)
والذين يُصَدِّقون بما أُنزل إليك أيها الرسول من القرآن, وبما أنزل إليك من الحكمة, وهي السنة, وبكل ما أُنزل مِن قبلك على الرسل من كتب, كالتوراة والإنجيل وغيرهما, ويُصَدِّقون بدار الحياة بعد الموت وما فيها من الحساب والجزاء، تصديقا بقلوبهم يظهر على ألسنتهم وجوارحهم وخص يوم الآخرة; لأن الإيمان به من أعظم البواعث على فعل الطاعات, واجتناب المحرمات, ومحاسبة النفس.
أُوْلَئِكَ عَلَى هُدًى مِنْ رَبِّهِمْ وَأُوْلَئِكَ هُمْ الْمُفْلِحُونَ (5)
''',
  2: '''
إِنَّ الَّذِينَ كَفَرُوا سَوَاءٌ عَلَيْهِمْ ءأَنذَرْتَهُمْ أَمْ لَمْ تُنذِرْهُمْ لا يُؤْمِنُونَ (6)
إن الذين جحدوا ما أُنزل إليك من ربك استكبارًا وطغيانًا, لن يقع منهم الإيمان, سواء أخوَّفتهم وحذرتهم من عذاب الله, أم تركت ذلك؛ لإصرارهم على باطلهم.
خَتَمَ اللَّهُ عَلَى قُلُوبِهِمْ وَعَلَى سَمْعِهِمْ وَعَلَى أَبْصَارِهِمْ غِشَاوَةٌ وَلَهُمْ عَذَابٌ عَظِيمٌ (7)
طبع الله على قلوب هؤلاء وعلى سمعهم, وجعل على أبصارهم غطاء; بسبب كفرهم وعنادهم مِن بعد ما تبيَّن لهم الحق, فلم يوفقهم للهدى, ولهم عذاب شديد في نار جهنم.
وَمِنْ النَّاسِ مَنْ يَقُولُ آمَنَّا بِاللَّهِ وَبِالْيَوْمِ الآخِرِ وَمَا هُمْ بِمُؤْمِنِينَ (8)
ومن الناس فريق يتردد متحيِّرًا بين المؤمنين والكافرين, وهم المنافقون الذين يقولون بألسنتهم: صدَّقْنَا بالله وباليوم الآخر, وهم في باطنهم كاذبون لم يؤمنوا.
يُخَادِعُونَ اللَّهَ وَالَّذِينَ آمَنُوا وَمَا يَخْدَعُونَ إِلاَّ أَنفُسَهُمْ وَمَا يَشْعُرُونَ (9)
يعتقدون بجهلهم أنهم يخادعون الله والذين آمنوا بإظهارهم الإيمان وإضمارهم الكفر, وما يخدعون إلا أنفسهم; لأن عاقبة خداعهم تعود عليهم. ومِن فرط جهلهم لا يُحِسُّون بذلك; لفساد قلوبهم.
فِي قُلُوبِهِمْ مَرَضٌ فَزَادَهُمْ اللَّهُ مَرَضاً وَلَهُمْ عَذَابٌ أَلِيمٌ بِمَا كَانُوا يَكْذِبُونَ (10)
في قلوبهم شكٌّ وفساد فابْتُلوا بالمعاصي الموجبة لعقوبتهم, فزادهم الله شكًا, ولهم عقوبة موجعة بسبب كذبهم ونفاقهم.
وَإِذَا قِيلَ لَهُمْ لا تُفْسِدُوا فِي الأَرْضِ قَالُوا إِنَّمَا نَحْنُ مُصْلِحُونَ (11)
وإذا نُصحوا ليكفُّوا عن الإفساد في الأرض بالكفر والمعاصي, وإفشاء أسرار المؤمنين, وموالاة الكافرين, قالوا كذبًا وجدالا إنما نحن أهل الإصلاح.
أَلا إِنَّهُمْ هُمْ الْمُفْسِدُونَ وَلَكِنْ لا يَشْعُرُونَ (12)
إنَّ هذا الذي يفعلونه ويزعمون أنه إصلاح هو عين الفساد, لكنهم بسبب جهلهم وعنادهم لا يُحِسُّون.
وَإِذَا قِيلَ لَهُمْ آمِنُوا كَمَا آمَنَ النَّاسُ قَالُوا أَنُؤْمِنُ كَمَا آمَنَ السُّفَهَاءُ أَلا إِنَّهُمْ هُمْ السُّفَهَاءُ وَلَكِنْ لا يَعْلَمُونَ (13)
وإذا قيل للمنافقين: آمِنُوا -مثل إيمان الصحابة، وهو الإيمان بالقلب واللسان والجوارح-, جادَلوا وقالوا: أَنُصَدِّق مثل تصديق ضعاف العقل والرأي, فنكون نحن وهم في السَّفَهِ سواء؟ فردَّ الله عليهم بأن السَّفَهَ مقصور عليهم, وهم لا يعلمون أن ما هم فيه هو الضلال والخسران.
وَإِذَا لَقُوا الَّذِينَ آمَنُوا قَالُوا آمَنَّا وَإِذَا خَلَوْا إِلَى شَيَاطِينِهِمْ قَالُوا إِنَّا مَعَكُمْ إِنَّمَا نَحْنُ مُسْتَهْزِئُونَ (14)
هؤلاء المنافقون إذا قابلوا المؤمنين قالوا: صدَّقنا بالإسلام مثلكم, وإذا انصرفوا وذهبوا إلى زعمائهم الكفرة المتمردين على الله أكَّدوا لهم أنهم على ملة الكفر لم يتركوها, وإنما كانوا يَسْتَخِفُّون بالمؤمنين, ويسخرون منهم.
اللَّهُ يَسْتَهْزِئُ بِهِمْ وَيَمُدُّهُمْ فِي طُغْيَانِهِمْ يَعْمَهُونَ (15)
الله يستهزئ بهم ويُمهلهم; ليزدادوا ضلالا وحَيْرة وترددًا, ويجازيهم على استهزائهم بالمؤمنين.
أُوْلَئِكَ الَّذِينَ اشْتَرَوْا الضَّلالَةَ بِالْهُدَى فَمَا رَبِحَتْ تِجَارَتُهُمْ وَمَا كَانُوا مُهْتَدِينَ (16)
''',
3 : '''وَبَشِّرْ الَّذِينَ آمَنُوا وَعَمِلُوا الصَّالِحَاتِ أَنَّ لَهُمْ جَنَّاتٍ تَجْرِي مِنْ تَحْتِهَا الأَنْهَارُ كُلَّمَا رُزِقُوا مِنْهَا مِنْ ثَمَرَةٍ رِزْقاً قَالُوا هَذَا الَّذِي رُزِقْنَا مِنْ قَبْلُ وَأُتُوا بِهِ مُتَشَابِهاً وَلَهُمْ فِيهَا أَزْوَاجٌ مُطَهَّرَةٌ وَهُمْ فِيهَا خَالِدُونَ (25)
وأخبر -أيها الرسول- أهل الإيمان والعمل الصالح خبرًا يملؤهم سرورًا, بأن لهم في الآخرة حدائق عجيبة, تجري الأنهار تحت قصورها العالية وأشجارها الظليلة. كلَّما رزقهم الله فيها نوعًا من الفاكهة اللذيذة قالوا: قد رَزَقَنا الله هذا النوع من قبل, فإذا ذاقوه وجدوه شيئًا جديدًا في طعمه ولذته, وإن تشابه مع سابقه في اللون والمنظر والاسم. ولهم في الجنَّات زوجات مطهَّرات من كل ألوان الدنس الحسيِّ كالبول والحيض, والمعنوي كالكذب وسوء الخُلُق. وهم في الجنة ونعيمها دائمون, لا يموتون فيها ولا يخرجون منها.
إِنَّ اللَّهَ لا يَسْتَحْيِي أَنْ يَضْرِبَ مَثَلاً مَا بَعُوضَةً فَمَا فَوْقَهَا فَأَمَّا الَّذِينَ آمَنُوا فَيَعْلَمُونَ أَنَّهُ الْحَقُّ مِنْ رَبِّهِمْ وَأَمَّا الَّذِينَ كَفَرُوا فَيَقُولُونَ مَاذَا أَرَادَ اللَّهُ بِهَذَا مَثَلاً يُضِلُّ بِهِ كَثِيراً وَيَهْدِي بِهِ كَثِيراً وَمَا يُضِلُّ بِهِ إِلاَّ الْفَاسِقِينَ (26)
إن الله تعالى لا يستحيي من الحق أن يذكر شيئًا ما, قلَّ أو كثر, ولو كان تمثيلا بأصغر شيء, كالبعوضة والذباب ونحو ذلك, مما ضربه الله مثلا لِعَجْز كل ما يُعْبَد من دون الله. فأما المؤمنون فيعلمون حكمة الله في التمثيل بالصغير والكبير من خلقه, وأما الكفار فَيَسْخرون ويقولون: ما مراد الله مِن ضَرْب المثل بهذه الحشرات الحقيرة؟ ويجيبهم الله بأن المراد هو الاختبار, وتمييز المؤمن من الكافر; لذلك يصرف الله بهذا المثل ناسًا كثيرين عن الحق لسخريتهم منه, ويوفق به غيرهم إلى مزيد من الإيمان والهداية. والله تعالى لا يظلم أحدًا; لأنه لا يَصْرِف عن الحق إلا الخارجين عن طاعته.
الَّذِينَ يَنقُضُونَ عَهْدَ اللَّهِ مِنْ بَعْدِ مِيثَاقِهِ وَيَقْطَعُونَ مَا أَمَرَ اللَّهُ بِهِ أَنْ يُوصَلَ وَيُفْسِدُونَ فِي الأَرْضِ أُوْلَئِكَ هُمْ الْخَاسِرُونَ (27)
الذين ينكثون عهد الله الذي أخذه عليهم بالتوحيد والطاعة, وقد أكَّده بإرسال الرسل, وإنزال الكتب, ويخالفون دين الله كقطع الأرحام ونشر الفساد في الأرض, أولئك هم الخاسرون في الدنيا والآخرة.
كَيْفَ تَكْفُرُونَ بِاللَّهِ وَكُنتُمْ أَمْوَاتاً فَأَحْيَاكُمْ ثُمَّ يُمِيتُكُمْ ثُمَّ يُحْيِيكُمْ ثُمَّ إِلَيْهِ تُرْجَعُونَ (28)
كيف تنكرون -أيُّها المشركون- وحدانية الله تعالى, وتشركون به غيره في العبادة مع البرهان القاطع عليها في أنفسكم؟ فلقد كنتم أمواتًا فأوجدكم ونفخ فيكم الحياة, ثم يميتكم بعد انقضاء آجالكم التي حددها لكم, ثم يعيدكم أحياء يوم البعث, ثم إليه ترجعون للحساب والجزاء.
هُوَ الَّذِي خَلَقَ لَكُمْ مَا فِي الأَرْضِ جَمِيعاً ثُمَّ اسْتَوَى إِلَى السَّمَاءِ فَسَوَّاهُنَّ سَبْعَ سَمَاوَاتٍ وَهُوَ بِكُلِّ شَيْءٍ عَلِيمٌ (29)

اللهُ وحده الذي خَلَق لأجلكم كل ما في الأرض من النِّعم التي تنتفعون بها, ثم قصد إلى خلق السموات, فسوَّاهنَّ سبع سموات, وهو بكل شيء عليم. فعِلْمُه -سبحانه- محيط بجميع ما خلق''' 
,

};

  @override
  void initState() {
    super.initState();
    currentPage = widget.startPage - 1; // Initialize currentPage to the startPage
    loadPdf();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isNightMode = prefs.getBool('isNightMode') ?? false;
      isHorizontalScroll = prefs.getBool('isHorizontalScroll') ?? true;
    });
  }

  @override
  void dispose() {
    _appBarTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int? page, int? total) async {
    setState(() {
      currentPage = page!;
      _pageController.text = (page + 1).toString();
    });

    // Save the last viewed page
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastPage', page!);
  }

  Future<void> loadPdf() async {
    setState(() {
      isReloading = true;
    });

    final tempDir = await getTemporaryDirectory();
    final tempFilePath = '${tempDir.path}/Quraan_v0.pdf';
    final file = File(tempFilePath);

    if (!await file.exists()) {
      final assetPath = widget.pdfPath;
      final bytes = await rootBundle.load(assetPath);
      await file.writeAsBytes(bytes.buffer.asUint8List());
    }

    setState(() {
      localPath = tempFilePath;
      isReloading = false;
    });

    // Restore the current page after the PDF is reloaded
    _pdfViewController.setPage(currentPage);
  }

  void toggleNightMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isNightMode = !isNightMode;
      localPath = null; // Force reload the PDFView
    });
    await prefs.setBool('isNightMode', isNightMode);
    loadPdf();
  }

  void toggleScrollDirection() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isHorizontalScroll = !isHorizontalScroll;
    });
    await prefs.setBool('isHorizontalScroll', isHorizontalScroll);
  }

  void goToPage(String pageNumber) {
    final page = int.tryParse(pageNumber);
    if (page != null && page >= 1 && page <= pages) {
      _pdfViewController.setPage(page - 1);
      setState(() {
        currentPage = page - 1;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar( //req change here
        SnackBar(
          content: Text('Invalid page number. Please enter a number between 1 and $pages.'),
        ),
      );
    }
  }

  // ignore: unused_element
  void _showSurahDescription() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          // width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: isNightMode ? Colors.black : Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.end,
                  surahDescriptions[currentPage] ?? "No description available",
                  style: TextStyle(
                    fontSize: 20,
                    color: isNightMode ? Colors.white : Colors.black,
                  ),
                ),
                // Spacer(),
                IconButton(
                  icon: Icon(Icons.close, color: isNightMode ? Colors.white : Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => QuranPartsScreen()),
              ),
            );
          },
          icon: Icon(
            color: isNightMode ?Colors.white : Colors.black  ,
            Icons.arrow_back_ios_new_sharp,
            size: 25,
          ),
        ),
        backgroundColor: isNightMode ? Colors.black : Colors.white,
        title: Text(
          "Quran",
          style: TextStyle(color: isNightMode ?Colors.white : Colors.black  , fontSize: 17),
        ),
        actions: [
          IconButton(
            icon: Lottie.asset(
              'assets/animations/wired-lineal-400-bookmark-hover-flutter.json',
              width: 30,
              height: 30,
              fit: BoxFit.fill,
              animate: true,
              repeat: false,
            ),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setInt('savedBookmarkPage', currentPage);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(9),
                      topRight: Radius.circular(9),
                    ),
                  ),
                  backgroundColor: const Color.fromARGB(255, 108, 108, 108),
                  content: Center(
                    child: Text(
                      ' ${currentPage + 1} تم حفظ الصفحة',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              isHorizontalScroll ? Icons.swipe_vertical_outlined : Icons.swipe_left_outlined,
              color: isNightMode ?Colors.white : Colors.black  ,
            ),
            onPressed: toggleScrollDirection,
          ),
          Container(
            width: 50,
            height: 30,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              border: Border.all(color: Theme.of(context).colorScheme.inversePrimary),
              borderRadius: BorderRadius.circular(3),
            ),
            child: TextField(
              style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
              controller: _pageController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Page',
                contentPadding: EdgeInsets.only(bottom: 10),
              ),
              onSubmitted: (value) {
                goToPage(value);
              },
            ),
          ),
          IconButton(
            icon: isNightMode
                ? Lottie.asset(
                    'assets/animations/wired-outline-1958-sun-hover-pinch.json',
                    width: 40,
                    height: 50,
                    fit: BoxFit.fill,
                    animate: true,
                    reverse: true,
                    repeat: true,
                  )
                : Lottie.asset(
                    'assets/animations/wired-lineal-1821-night-sky-moon-stars-hover-pinch.json',
                    width: 40,
                    height: 50,
                    fit: BoxFit.fill,
                    animate: true,
                    repeat: true,
                  ),
            onPressed: toggleNightMode,
          ),
        ],
      ),
      body: GestureDetector(
        child: isReloading
            ? Center(
                child: Lottie.asset(
                  'assets/animations/wired-outline-1414-circle-hover-pinch.json',
                  width: 40,
                  height: 40,
                  fit: BoxFit.fill,
                  animate: true,
                  repeat: true,
                ),
              )
            : localPath != null
                ? PDFView(
                    key: ValueKey('pdfview_${isNightMode}_${isHorizontalScroll}_$localPath'),
                    defaultPage: currentPage,
                    filePath: localPath,
                    autoSpacing: true,
                    enableSwipe: true,
                    pageSnap: true,
                    swipeHorizontal: isHorizontalScroll,
                    fitEachPage: false,
                    nightMode: isNightMode,
                    onRender: (pages) {
                      setState(() {
                        this.pages = pages!;
                        isReady = true;
                      });
                    },
                    onViewCreated: (PDFViewController pdfViewController) {
                      _pdfViewController = pdfViewController;
                      _pdfViewController.setPage(currentPage);
                    },
                    onPageChanged: (int? page, int? total) async {
                      setState(() {
                        currentPage = page!;
                        _pageController.text = (page + 1).toString();
                      });

                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setInt('lastPage', page!);
                    },
                    onError: (error) {
                      print(error.toString());
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: isNightMode ? Colors.white : Colors.black),
              onPressed: () {
                if (currentPage > 0) {
                  _pdfViewController.setPage(currentPage - 1);
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward, color: isNightMode ? Colors.white : Colors.black),
              onPressed: () {
                if (currentPage < pages - 1) {
                  _pdfViewController.setPage(currentPage + 1);
                }
              },
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   color: isNightMode ? Colors.black : Colors.white,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       TextButton(
      //         child: Row(
      //           children: [
      //             Icon(Icons.info_outline, color: isNightMode ? Colors.white : Colors.black),
      //             SizedBox(width: 10,),
      //             Text("تفسير الايات" ,style: TextStyle(color: isNightMode ? Colors.white : Colors.black),)
      //           ],
      //         ),
      //         onPressed: _showSurahDescription,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}