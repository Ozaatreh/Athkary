import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RamadanDuaa extends StatefulWidget {
  const RamadanDuaa({super.key});

  @override
  State<RamadanDuaa> createState() => _RamadanDuaaState();
}

class _RamadanDuaaState extends State<RamadanDuaa>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  final List<Map<String, String>> duaas = [
    {
      "title": "الاستعانة بالله في الصيام",
      "description": "اَللّهُمَّ اَعِنّي فيهِ عَلى صِيامِهِ وَقِيامِهِ، وَجَنِّبني فيهِ مِن هَفَواتِهِ وَآثامِهِ، وَارْزُقني فيهِ ذِكْرَكَ بِدَوامِهِ، بِتَوْفيقِكَ يا هادِيَ المُضِّلينَ"
    },
    
    {
      "title": "صيام القائمين",
      "description": "اَللّهُمَّ اجْعَلْ صِيامي فيهِ صِيامَ الصّائِمينَ وَقِيامي فيِهِ قِيامَ القائِمينَ، وَنَبِّهْني فيهِ عَن نومه الغافِلينَ، وَهَبْ لي جُرمي فيهِ يا اِلهَ العالمينَ، وَاعْفُ عَنّي يا عافِيًا عَنِ المُجرِمينَ"
    },
    
    {
      "title": "دعاء النور",
      "description": "اللهمّ يا نور السماوات والأرض، يا عماد السماوات والأرض، يا جبّار السماوات والأرض، يا ديّان السماوات والأرض، يا وارث السماوات والأرض، يا مالك السماوات والأرض، يا عظيم السماوات والأرض، يا عالم السماوات والأرض، يا قيّوم السماوات والأرض، يا رحمن الدّنيا ورحيم الآخرة، اللهم إليك مددت يدي، وفيما عندك عظمت رغبتي، فاقبل توبتي، وارحم ضعف قوّتي، واغفر خطيئتي، واقبل معذرتي، واجعل لي من كل خير نصيبًا، وإلى كل خيرٍ سبيلًا، برحمتك يا أرحم الراحمين"
    },
    {
      "title": "طلب القبول والمغفرة",
      "description": "يارب اجْعَلْ سَعْيي فيهِ مَشكورا، وَذَنبي فيهِ مَغفُورا، وَعَمَلي فيهِ مَقبُولاً، وعيبي فيهِ مَستوراً يا أسمَعَ السّامعينَ"
    },
    {
      "title": "دعاء الرزق",
      "description": "اللهم يا رازق السائلين، يا راحم المساكين، ويا ذا القوة المتين، ويا خير الناصرين، يا وليّ المؤمنين، يا غيّاث المستغيثين، إياك نعبدوإيّاك نستعين، اللهم إني أسألك رزقاً واسعاً طيباً من رزقك. اللهم إني أسألك فهم النبيين، وحفظ المرسلين والملائكة المقربين، اللهم اجعل ألسنتنا عامرة بذكرك، وقلوبنا بخشيتك، وأسرارنا بطاعتك، إنك على كل شيء قدير، حسبنا الله ونعم الوكيل"
    },
    {
      "title": "شكر الله على نعمه",
      "description": "أشهدك يا الله أنك سبحانك أكرمتني وسترتني وأعطيتني من فضلك الواسع، وأنعمت عليّ بكرمك وجودك"
    },
    {
      "title": "التوكل على الله",
      "description": "اَللّهُمَّ اجْعَلني فيهِ مِنَ المُتَوَكِلينَ عَلَيْكَ، وَاجْعَلني فيهِ مِنَ الفائِزينَ لَدَيْكَ، وَاجعَلني فيه مِنَ المُقَرَّبينَ اِليكَ بِاِحْسانِكَ يا غايَةَ الطّالبينَ"
    },
    {
      "title": "طلب الإحسان",
      "description": "اَللّهُمَّ حَبِّبْ إلَيَّ الإحْسانَ، وَكَرِّهْ إلَيَّ الْفُسُوَق وَالْعِصْيانَ، وَحَرِّمْ عَلَيَّ سَّخَطَك وَالنّيرانَ بِعَوْنِكَ يا غِياثَ الْمُسْتَغيثينَ."
    },
   
    
    {
      "title": "تيسير الرزق",
      "description": "اللهم سخر لى رزقى، واعصمنى من الحرص والتعب فى طلبه، ومن شغل الهم، ومن الذل للخلق، اللهم يسر لى رزقًا حلالًا، وعجل لى به يا نعم المجيب"
    },
    {
      "title": "طلب البركة في الرزق",
      "description": "اللهم ياباسط اليدين بلعطايا، سبحان من قسم الأرزاق ولم ينس أحدًا، اجعل يدى عُليا بالإعطاء ولا تجعل يدى سفلى بالاستعطاء إنك على كل شىء قدي"
    },
    {
      "title": "استجلاب الرزق",
      "description": "اللهم إن كان رزقي في السماء فأهبطه وإن كان في الأرض فأظهره وإن كان بعيدا فقربه وإن كان قريبا فيسره وإن كان قليلا فكثره وبارك اللهم فيه"
    },
    {
    "title": "دعاء عند الإفطار",
    "description":
        "ذهب الظمأ وابتلت العروق وثبت الأجر إن شاء الله."
  },
  {
    "title": "طلب القبول في رمضان",
    "description":
        "اللهم تقبل منا صيامنا وقيامنا وصالح أعمالنا، واكتبنا من عتقائك من النار، واجعلنا من المقبولين."
  },
  {
    "title": "دعاء ليلة القدر",
    "description":
        "اللهم إنك عفو كريم تحب العفو فاعفُ عني."
  },
  {
    "title": "طلب الهداية والثبات",
    "description":
        "اللهم يا مقلب القلوب ثبت قلبي على دينك، اللهم اهدني وسددني، واجعلني من عبادك الصالحين."
  },
  {
    "title": "دعاء تفريج الهم",
    "description":
        "اللهم إني عبدك ابن عبدك ابن أمتك، ناصيتي بيدك، ماضٍ فيّ حكمك، عدلٌ فيّ قضاؤك، أسألك بكل اسم هو لك أن تجعل القرآن ربيع قلبي ونور صدري وجلاء حزني وذهاب همي."
  },
  {
    "title": "طلب حسن الخاتمة",
    "description":
        "اللهم أحسن خاتمتي في الأمور كلها، وأجرني من خزي الدنيا وعذاب الآخرة."
  },
  {
    "title": "دعاء صلاح القلب",
    "description":
        "اللهم طهر قلبي من النفاق، وعملي من الرياء، ولساني من الكذب، وعيني من الخيانة، إنك تعلم خائنة الأعين وما تخفي الصدور."
  },
  {
    "title": "طلب البركة في الوقت",
    "description":
        "اللهم بارك لي في وقتي، وأعني على ذكرك وشكرك وحسن عبادتك، واجعل أيامي شاهدة لي لا عليّ."
  },
  {
    "title": "دعاء قضاء الدين",
    "description":
        "اللهم اكفني بحلالك عن حرامك، وأغنني بفضلك عمن سواك."
  },
  {
    "title": "دعاء طلب الرحمة",
    "description":
        "رب اغفر لي وارحمني واهدني وعافني وارزقني، إنك أنت الغفور الرحيم."
  },
  {
    "title": "دعاء السكينة",
    "description":
        "اللهم أنزل على قلبي سكينة من عندك، واملأ صدري طمأنينة ورضاً، واجعلني بك مطمئناً."
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
                        child: Center(
                          child: Text(
                            "أدعية رمضان",
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

                /// ================= LIST =================
                Expanded(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: duaas.length,
                    itemBuilder: (context, index) {
                      final animation = CurvedAnimation(
                        parent: _controller,
                        curve: Interval(
                          (index / duaas.length),
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
                            question:
                                duaas[index]["title"]!,
                            answer:
                                duaas[index]["description"]!,
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
    required String question,
    required String answer,
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
            question,
            style: GoogleFonts.amiri(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          children: [
            Text(
              answer,
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