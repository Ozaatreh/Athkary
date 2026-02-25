import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


class LaylatAlQadrInfoScreen extends StatefulWidget {
  const LaylatAlQadrInfoScreen({super.key});

  @override
  State<LaylatAlQadrInfoScreen> createState() => _LaylatAlQadrInfoScreenState();
}

class _LaylatAlQadrInfoScreenState extends State<LaylatAlQadrInfoScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final List<Map<String, String>> laylatAlQadrInfo = const [
    {
      'title': 'هل ليلة 27 رمضان هي ليلة القدر؟',
      'description':
          'نعم، ليلة سبع وعشرين هي أرجى ما تكون ليلة القدر، كما جاء في صحيح مسلم من حديث أُبي بن كعب رضي الله عنه',
    },
    {
      'title': 'كيف نعرف أن ليلة القدر هي ليلة القدر؟',
      'description':
          'علامات ليلة القدر:\n'
          '- ليلة هادئة لطيفة لا حارة ولا باردة\n'
          '- تطلع الشمس في صباحها ضعيفة حمراء\n'
          '- قوة الإضاءة والنور في تلك الليلة\n'
          '- طمأنينة القلب وانشراح الصدر\n'
          '- الرياح تكون ساكنة\n'
          '- قد تراها في المنام كما حدث مع بعض السلف الصالح\n'
          '- لا يحل لشيطان أن يخرج فيها حتى الفجر\n'
          '- طلوع الشمس بيضاء لا شعاع لها بعد تمام الليلة',
    },
    {
      'title': 'كيف نلتمس ليلة القدر؟',
      'description':
          'إحياءها بالقيام، ففي الصحيحين عن أبي هريرة رضي الله عنه قال: قال رسول الله صلى الله عليه وسلم: "من قام ليلة القدر إيماناً واحتساباً غفر له ما تقدم من ذنبه"\n'
          'الدعاء، وخصوصاً ما ورد به الدليل، فعن عائشة رضي الله عنها قالت: قلت: يا رسول الله، أرأيت إن علمت ليلة القدر ما أقول فيها؟',
    },
    {
      'title': 'كم ركعة صلاة ليلة القدر؟',
      'description':
          'عدد ركعات صلاة ليلة القدر:\n'
          '- الحنفية: عشرون ركعة بعشر تسليمات\n'
          '- المالكية: ست وثلاثون ركعة بتسع ترويحات\n'
          '- الشافعية: عشرون ركعة بعشر تسليمات\n'
          '- الحنابلة: عشرون ركعة ولا حرج من الزيادة',
    },
    {
      'title': 'هل يجوز النوم في ليلة القدر؟',
      'description':
          'نعم، لا بأس أن ينام بعض الليل، مادام أنه قد قام أغلبه. عائشة رضي الله عنها قالت: «ما قام ليلة حتى أصبح» صلوات الله وسلامه عليه',
    },
    {
      'title': 'متى يبدأ وقت ليلة القدر ومتى تنتهي؟',
      'description':
          'ليلة القدر متنقلة في العشر الأواخر من رمضان، وقد تكون في ليلة إحدى وعشرين، أو ثلاث وعشرين، أو خمس وعشرين، أو سبع وعشرين (وهي أحرى الليالي)، أو تسع وعشرين',
    },
    {
      'title': 'ما هو أفضل وقت لصلاة ليلة القدر؟',
      'description':
          'أفضل وقت لصلاة ليلة القدر هو بعد منتصف الليل، خاصة في الساعات الأخيرة قبل الفجر (1:30 صباحًا – 2:00 صباحًا)',
    },
    {
      'title': 'هل يعتق الله في آخر ليلة من رمضان؟',
      'description':
          'نعم، في آخر ليلة من رمضان، يعتق الله بعدد ما أعتق من أول الشهر إلى آخره، كما جاء في حديث ابن عباس المرفوع',
    },
    {
      'title': 'هل ليلة القدر تأتي زوجية؟',
      'description':
          'ليلة القدر يمكن أن تكون في الليالي الزوجية أو الفردية، ولكنها تكون في العشر الأواخر من رمضان',
    },
    {
      'title': 'ما هو أفضل دعاء ليلة القدر؟',
      'description':
          'اللهم يا رب السماوات والأرض في ليلة القدر أن ترفع درجات أمي وأبي وأن تحرم عليهما عذاب النار وعذاب القبر وأن تجعلهما ممن لا خوف عليهم ولا هم يحزنون',
    },
    {
      'title': 'ما سبب عدم معرفة ليلة القدر؟',
      'description':
          'تم إخفاء موعد ليلة القدر حتى يداوم المسلمون على العبادات والطاعات في جميع الليالي، وليس فقط في ليلة واحدة',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
     final TextStyle textStyle2 = GoogleFonts.amiri(
    fontSize: 19 ,fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.inversePrimary, );

    final TextStyle textStyle1 = GoogleFonts.amiri(
    fontSize: 23,
    color: Theme.of(context).colorScheme.primary, );
    
    final TextStyle textStyle3 = GoogleFonts.amiri(
    fontSize: 17,
    color: Theme.of(context).colorScheme.primary, );
   
    return Scaffold(
      
      body: Column(
        children: [
           SizedBox(height: screenHeight * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
            icon:   Icon(Icons.arrow_back_ios_new_rounded , color: Theme.of(context).colorScheme.primary,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
                  Lottie.asset(
                              'assets/animations/wired-lineal-1821-night-sky-moon-stars-hover-pinch.json', // Dark mode animation
                              width: 70,
                              height: 70,
                              fit: BoxFit.fill,
                              animate: true,
                              repeat: true,
                            ),
                   Text('ليلة القدر' , style: textStyle1,),
                ],
              ),
              Divider(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: laylatAlQadrInfo.length,
              itemBuilder: (context, index) {
                return _buildExpansionTile(
                  context,
                  question: laylatAlQadrInfo[index]['title']!,
                  answer: laylatAlQadrInfo[index]['description']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

    Widget _buildExpansionTile(BuildContext context,
      {required String question, required String answer}) {
    
      final TextStyle textStyle1 = GoogleFonts.amiri(
    fontSize: 19, fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.inversePrimary, );  
     
     final TextStyle textStyle2 = GoogleFonts.amiri(
    fontSize: 19, fontWeight: FontWeight.w100,
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
            style: textStyle1
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                answer,
                style: textStyle2,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}