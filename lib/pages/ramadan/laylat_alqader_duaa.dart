import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LaylatAlQadrDuaScreen extends StatefulWidget {
  const LaylatAlQadrDuaScreen({super.key});

  @override
  State<LaylatAlQadrDuaScreen> createState() => _LaylatAlQadrDuaScreenState();
}

class _LaylatAlQadrDuaScreenState extends State<LaylatAlQadrDuaScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  
  final List<String> laylatAlQadrDuas = const [
    'اللَّهُمَّ لا تدع لنا يا ربنا في هذه الليلة العظيمة ذنبًا إلا غفرته، ولا مريضًا إلا شفيته، ولا ميتًا إلا رحمته، ولا دعاءً إلا استجبته، ولا تائبًا إلا قَبلته، ولا عاريًا إلا كسوته، ولا فقيرًا إلا أغنيته، ولا مؤمنًا إلا ثبَّته، ولا طالبًا إلا وفَّقته، ولا عاصيًا إلا هديته، ولا مظلومًا إلا نصرته، ولا عدوًّا إلا أخذته، ولا حاجة من حوائج الدنيا والآخرة هي لك فيها رضًا ولنا فيها صلاحٌ إلا قضيتها ويسَّرتها برحمتك يا أرحم الراحمين',
    'اللَّهُمَّ كما بلَّغتنا رمضان، نسألك يا الله أن تجعلنا ممن وفِّق لقيام ليلة القدر، وأن تجعلنا ممَّن وُفِّق لقيام ليلة القدر. اللَّهُمَّ ارزقنا خيرها، وعفوها، وكرمها، وفضلها، يا الله. ربي إني طرقت بابك فافتح لي أبواب سماواتك، وأجرني من عظيم بلائك',
    'اللهم إن كانت هذه ليلة القدر فاقسم لي فيها خير ما قسمت، واختم لي في قضائك خير ما ختمت، واختم لي بالسعادة فيمن ختمت. اللهم اجعل اسمي وذريتي في هذه الليلة في السعداء، وروحي مع الشهداء، وإحساني في عليين، وإساءتي مغفورة',
    'اللهم يا رب السماوات والأرض في ليله القدر أن ترفع درجات أمي وأبي وأن تحرم عليهما عذاب النار وعذاب القبر وأن تجعلهما ممن لا خوف عليهم ولا هم يحزنون وأن تسقيهما شربة هنيئة من حوض نبيك وحبيبك محمد عليه الصلاة والسلام',
    'اللَّهمَّ إنِّي عَبدُك، وابنُ عبدِك، وابنُ أمتِك، ناصِيَتي بيدِكَ، ماضٍ فيَّ حكمُكَ، عدْلٌ فيَّ قضاؤكَ، أسألُكَ بكلِّ اسمٍ هوَ لكَ سمَّيتَ بهِ نفسَك، أو أنزلْتَه في كتابِكَ، أو علَّمتَه أحدًا من خلقِك، أو استأثرتَ بهِ في علمِ الغيبِ عندَك، أن تجعلَ القُرآنَ ربيعَ قلبي، ونورَ صَدري، وجَلاءَ حَزَني، وذَهابَ هَمِّي',
    'اللَّهمَّ عالِمَ الغَيبِ والشَّهادةِ، فاطرَ السَّمواتِ والأرضِ، رَبَّ كلِّ شيءٍ ومَليكَهُ، أشهدُ أن لا إلَهَ إلَّا أنتَ، أعوذُ بِكَ مِن شرِّ نفسي وشرِّ الشَّيطانِ وشِركِهِ',
    'اللهمَّ إنِّي أسألُكَ مِنَ الخيرِ كلِّهِ عَاجِلِه وآجِلِه ما عَلِمْتُ مِنْهُ وما لمْ أَعْلمْ، وأعوذُ بِكَ مِنَ الشَّرِّ كلِّهِ عَاجِلِه وآجِلِه ما عَلِمْتُ مِنْهُ وما لمْ أَعْلمْ، اللهمَّ إنِّي أسألُكَ من خَيْرِ ما سألَكَ مِنْهُ عَبْدُكَ ونَبِيُّكَ، وأعوذُ بِكَ من شرِّ ما عَاذَ بهِ عَبْدُكَ ونَبِيُّكَ',
    'يا رب أتوسل إليك ألا يخرج رمضان إلا وقد أسعدت زوجي وهديت أولادي وجعلتنا جميعا من عتقائك من النار يا أرحم الراحمين، اللهم تقبل منا شهر رمضان وتقبل منه فيه الصيام والقيام',
    'اللهم احفظني، واحفظ زوجي، وأولادي من كل شر، وارزقهم كل ما يتمنون من خير في الآخرة قبل الدنيا، ولا ترهق قلوبهم بما ليس لهم، اللهم إني اسألك أن تجعلنا من الذين ذكرت أسمائهم في صحف المعتوقين من النار، والمغفور لهم ذنوبهم، ومن يدخلون أعلى درجات الفردوس والجنة',
    'اللّهم أصلح لنا ديننا الذي هو عصمة أمرنا، وأصلح لنا دنيانا التي فيها معاشنا، وأصلح لنا آخرتنا التي فيها معادنا، واجعل الحياة زيادة لنا في كل خير، واجعل الموت راحة لنا من كل شر',
    'اللّهم لك الحمد كما هديتنا للإسلام، وعلمتنا الحكمة والقرآن، اللّهم اجعلنا لكتابك من التّالين، ولك به من العاملين، وبالأعمال مخلصين، وبالقسط قائمين، وعن النار مزحزحين، وبالجنات منعمين، وإلى وجهك ناظرين',
    'اللّهم أحينا مستورين، و أمتنا مستورين، و ابعثنا مستورين، و أكرمنا بلقائك مستورين، اللّهم استرنا فوق الأرض، واسترنا تحت الأرض، واسترنا يوم العرض عليك',
    'اللّهم اشف مرضانا ومرضى المسلّمين، وارحم موتانا وموتى المسلّمين، واقض حوائجنا وحوائج السائلين',
    'اللّهم تولّ أمورنا، وفرج همومنا، واكشف كروبنا، اللّهم إنّك عفو كريم تحب العفو فاعف عنا',
    'اللّهم إنا نسألك حبّك، وحبّ من يحبّك، وحبّ العمل الذي يقرّبنا إلى حبّك، وأصلح ذات بيننا، وأَلِّف بين قلوبنا، وانصرنا على أعدائنا، وجنّبنا الفواحش ما ظهر منها وما بطن، وبارك لنا في أسماعنا وأبصارنا وأقوالنا ما أحييتنا، وبارك لنا في أزواجنا وذرّياتنا ما أبقيتنا، واجعلنا شاكرين لنعمك برحمتك يا أرحم الراحمين',
    'اللّهم إنا نسألك العفو والعافية والمعافاة الدائمة في الدين والدنيا والآخرة، اللّهم اجعلنا في هذه الليلة من الذين نظرت إليهم وغفرت لهم ورضيت عنهم، اللّهم اجعلنا في هذه الليلة من الذين تُسلّم عليهم الملائكة',
    'اللّهم اشف مرضانا ومرضى المسلّمين، وارحم موتانا وموتى المسلمين. اللهمَّ أصلح ذات بيننا، وأَلِّف بين قلوبنا، وانصرنا على أعدائنا، وجنّبنا الفواحش ما ظهر منها وما بطن. اللهم اقض حوائجنا وحوائج السائلين. اللّهم تولّ أمورنا، وفرج همومنا، واكشف كروبنا. اللّهم أوردنا حوض سيّدنا محمد -صلّى الله عليه وسلّم-، واجعله لنا شفيعا، واسقنا من يده الشريفة شربة لا نظمأ بعدها أبدا',
    'اللّهم أوردنا حوض نبيّك سيّدنا محمد صلّى الله عليه وسلّم، واجعله لنا شفيعاً، واسقنا من يده الشريفة شربة لا نظمأ بعدها أبداً، ربنا قِنا عذاب النار، ربنا إننا سمعنا منادياً ينادي للإيمان أن آمنوا بربكم فآمنا، ربنا فاغفر لنا ذنوبنا وكفّر عنا سيئاتنا وتوفّنا مع الأبرار، ربنا وآتنا ما وعدتنا على رُسُلك ولا تخزنا يوم القيامة إنك لا تخلف الميعاد، اللّهم اغفر للمؤمنين والمؤمنات، والمسلّمين والمسلّمات، الأحياء منهم والأموات، إنك سميع قريب مجيب الدعوات يا رب العالمين',
    'اللّهم أصلح لنا ديننا الذي هو عصمة أمرنا، وأصلح لنا دنيانا التي فيها معاشنا. اللهم أصلح لنا آخرتنا التي فيها معادنا، واجعل الحياة زيادة لنا في كل خير، واجعل الموت راحة لنا من كل شر. اللّهم لك الحمد كما هديتنا للإسلام، وعلمتنا الحكمة والقرآن، اللّهم اجعلنا لكتابك من التّالين، ولك به من العاملين، وبالأعمال مخلصين، وبالقسط قائمين، وعن النار مزحزحين، وبالجنات منعمين، وإلى وجهك ناظرين',
  ];
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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

                /// ================= HEADER =================
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/animations/wired-flat-1821-night-sky-moon-stars-hover-pinch.json',
                              width: 55,
                              repeat: true,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'ليلة القدر',
                              style: GoogleFonts.amiri(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40), // balance layout
                    ],
                  ),
                ),

                /// Divider with elegance
                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  color: Colors.white.withOpacity(0.1),
                ),

                const SizedBox(height: 16),

                /// ================= LIST =================
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: laylatAlQadrDuas.length,
                    itemBuilder: (context, index) {
                      final animation = CurvedAnimation(
                        parent: _controller,
                        curve: Interval(
                          (index / laylatAlQadrDuas.length),
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
                          child: _buildDuaCard(
                            context,
                            laylatAlQadrDuas[index],
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

  Widget _buildDuaCard(BuildContext context, String dua) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white.withOpacity(0.08),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 22,
        ),
        child: Text(
          dua,
          style: GoogleFonts.amiri(
            fontSize: 20,
            height: 1.9,
            color: Colors.white.withOpacity(0.95),
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}