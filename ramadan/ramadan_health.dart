import 'package:flutter/material.dart';

class RamadanHealthBenefits extends StatefulWidget {
  const RamadanHealthBenefits({super.key});

  @override
  State<RamadanHealthBenefits> createState() => _RamadanHealthBenefitsState();
}

class _RamadanHealthBenefitsState extends State<RamadanHealthBenefits>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
            icon:  Icon(Icons.arrow_back_ios_new_rounded , color: Theme.of(context).colorScheme.primary,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        centerTitle: true,
        title: Text(
          'فوائد الصوم الصحية',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 206, 210, 206),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildExpansionTile(
              context,
              point: 'الصوم والصحة النفسية',
              description:
                  'إن أعصاب الإنسان قوية قادرة على احتمال العمل فالمخ يستطيع أن يعمل بلا انقطاع دون أن يرهقه العمل والعضلة البشرية يمكن لها العمل عشرات الساعات قبل أن ينالها التعب وهناك حقيقة مدهشة، أن العمل الذهني وحده لا يفضي إلى التعب، وقد حاول طائفة من العلماء أن يتعرفوا على مدى احتمال المخ الإنساني للعمل، فكانت دهشتهم كبيرة حين وجدوا أن الدماء المندفعة من المخ وإليه، وهو في أوج نشاطه، خالية من كل أثر للتعب في الأفراد الذين يمارسون عملا ذهنيا، في حين أنهم أخذوا عينة من دماء عامل يعمل بيديه بينما هو يزاول عمله فوجدوها حافلة بخمائر التعب وإفرازاته.',
            ),
            const SizedBox(height: 16.0),
            _buildExpansionTile(
              context,
              point: 'الصوم والتخلص من سموم الجسم',
              description:
                  'يتعرض الجسم البشري لكثير من المواد الضارة، والسموم التي قد تتراكم في أنسجته، وأغلب هذه المواد تأتي للجسم عبر الغذاء الذي يتناوله بكثرة، وجميع الأطعمة تقريبًا في هذه الأيام تحتوي على كميات قليلة من المواد السامة، وهذه المواد تضاف للطعام أثناء إعداده، أو حفظه كالنكهات، والألوان، ومضادات الأكسدة، والمواد الحافظة، أو الإضافات الكيميائية للنبات أو الحيوان، كمنشطات النمو، والمضادات الحيوية، والمخصبات، أو مشتقاتها، وتحتوي بعض النباتات في تركيبها على بعض المواد الضارة، كما أن عددًا كبيرًا من الأطعمة يحتوي على نسبة من الكائنات الدقيقة، التي تفرز سمومها فيها وتعرضها للتلوث، هذا بالإضافة إلى السموم التي نستنشقها مع الهواء، من عوادم السيارات، وغازات المصانع، وسموم الأدوية التي يتناولها الناس بغير ضابط... إلى غير ذلك من سموم الكائنات الدقيقة، التي تقطن في أجسامنا بأعداد تفوق الوصف والحصر، وأخيرًا مخلفات الاحتراق الداخلي للخلايا، والتي تسبح في الدم كغاز ثاني أكسيد الكربون، واليوريا، والكرياتينين، والأمونيا، والكبريتات، وحمض اليوريك... الخ، ومخلفات الغذاء المهضوم والغازات السامة التي تنتج من تخمره وتعفنه، مثل الأندول والسكاتول والفينول.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpansionTile(BuildContext context,
      {required String point, required String description}) {
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
            point,
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
                description,
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