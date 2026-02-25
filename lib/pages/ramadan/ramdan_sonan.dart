import 'package:flutter/material.dart';


class RamadanSunnahsPage extends StatefulWidget {
  const RamadanSunnahsPage({super.key});

  @override
  State<RamadanSunnahsPage> createState() => _RamadanSunnahsPageState();
}

class _RamadanSunnahsPageState extends State<RamadanSunnahsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final List<Map<String, String>> sunnahs = const [
    {
      'title': 'التهنئة بقدوم شهر رمضان',
      'description':
          'عن أبي هريرة رضي الله عنه قال: كان رسول الله صلى الله عليه وسلم يبشر أصحابه بقدوم رمضان...',
    },
    {
      'title': 'تعجيل الفطر',
      'description':
          'قال صلى الله عليه وسلم: "لا يزال الناس بخير ما عجلوا الفطر" رواه البخاري ومسلم.',
    },
    {
      'title': 'تفطير الصائمين',
      'description':
          'قال صلى الله عليه وسلم: "من فطر صائماً كتب له مثل أجره" رواه النسائي والترمذي.',
    },
    {
      'title': 'الفطر على تمر أو ماء',
      'description':
          'قال صلى الله عليه وسلم: "إذا كان أحدكم صائماً فليفطر على التمر، فإن لم يجد فعلى الماء" رواه الخمسة.',
    },
    {
      'title': 'السحور',
      'description':
          'قال صلى الله عليه وسلم: "تسحروا فإن في السحور بركة" رواه البخاري ومسلم.',
    },
    {
      'title': 'قيام رمضان',
      'description':
          'قال صلى الله عليه وسلم: "من قام رمضان إيماناً واحتساباً غفر له ما تقدم من ذنبه" رواه البخاري ومسلم.',
    },
    {
      'title': 'الإكثار من قراءة القرآن',
      'description':
          'قال تعالى: "شهر رمضان الذي أنزل فيه القرآن هدىً للناس وبينات من الهدى والفرقان".',
    },
    {
      'title': 'الاعتكاف في العشر الأواخر',
      'description':
          'قال ابن عمر رضي الله عنهما: "كان رسول الله صلى الله عليه وسلم يعتكف العشر الأواخر من رمضان" رواه البخاري.',
    },
    {
      'title': 'الإكثار من الدعاء',
      'description':
          'قال تعالى: "وإذا سألك عبادي عني فإني قريب أجيب دعوة الداع إذا دعان".',
    },
    {
      'title': 'الاجتهاد في العبادات',
      'description':
          'كان النبي صلى الله عليه وسلم أجود ما يكون في رمضان حين يلقاه جبريل.',
    },
    {
      'title': 'الرد على الإساءة بالصيام',
      'description':
          'قال صلى الله عليه وسلم: "فإن سابه أحد أو قاتله فليقل إني صائم" رواه البخاري.',
    },
    {
      'title': 'العمرة في رمضان',
      'description':
          'قال صلى الله عليه وسلم: "عمرة في رمضان تعدل حجة" رواه البخاري ومسلم.',
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon:  Icon(Icons.arrow_back_ios_new_rounded , color: Theme.of(context).colorScheme.primary,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        title: const Text('سنن رمضانية'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sunnahs.length,
        itemBuilder: (context, index) {
          return _buildExpansionTile(
            context,
            question: sunnahs[index]['title']!,
            answer: sunnahs[index]['description']!,
          );
        },
      ),
    );
  }

  Widget _buildExpansionTile(BuildContext context,
      {required String question, required String answer}) {
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
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            textAlign: TextAlign.end,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }
}