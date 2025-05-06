import 'package:athkary/pages/ramadan/ramadan_100duaa.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RamadanDuaa extends StatefulWidget {
  @override
  _RamadanDuaaState createState() => _RamadanDuaaState();
}

class _RamadanDuaaState extends State<RamadanDuaa>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

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
    }
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle2 = GoogleFonts.amiri(
    fontSize: 19 ,fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.inversePrimary, );

    final TextStyle textStyle1 = GoogleFonts.amiri(
    fontSize: 25,
    color: Theme.of(context).colorScheme.primary, );
    
    final TextStyle textStyle3 = GoogleFonts.amiri(
    fontSize: 17,
    color: Theme.of(context).colorScheme.primary, );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon:  Icon(Icons.arrow_back_ios_new_rounded , color: Theme.of(context).colorScheme.primary,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        title: Text("أدعية رمضان" , style: textStyle1,)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: duaas.length,
                itemBuilder: (context, index) {
                  return _buildExpansionTile(
                    context,
                    question: duaas[index]["title"]!,
                    answer: duaas[index]["description"]!,
                  );
                },
              ),
            ),
          //   Card(
          //   color: Theme.of(context).colorScheme.primary,
          //   child: ListTile(
          //     title: Center(
          //       child: Text(
          //         "١٠٠   دعاء",
          //         style: GoogleFonts.amiri(fontSize: 18, fontWeight: FontWeight.bold
          //         , color:Theme.of(context).colorScheme.inversePrimary),
          //       ),
          //     ),
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => DuaaPdfViewerScreen(pdfPath: 'assets/pdfs/يا باغي الدعاء.pdf',)),
          //       );
          //     },
          //   ),
          // ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpansionTile(BuildContext context,
      {required String question, required String answer}) {
    
    final TextStyle textStyle2 = GoogleFonts.amiri(
    fontSize: 19 ,fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.inversePrimary, );

    final TextStyle textStyle1 = GoogleFonts.amiri(
    fontSize: 23,
    color: Theme.of(context).colorScheme.primary, );
    
    final TextStyle textStyle3 = GoogleFonts.amiri(
    fontSize: 17,
    color: Theme.of(context).colorScheme.inversePrimary, );

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        margin: const EdgeInsets.only(bottom: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ExpansionTile(
          iconColor: Theme.of(context).colorScheme.inversePrimary,
          collapsedIconColor: Theme.of(context).colorScheme.inversePrimary ,
          title: Text(
            question,
            style: textStyle2,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                answer,
                style: textStyle3,
                strutStyle: StrutStyle(height: 3),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
