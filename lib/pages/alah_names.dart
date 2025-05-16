import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlahNames extends StatefulWidget {
  const AlahNames({super.key});

  @override
  State<AlahNames> createState() => _AlahNamesState();
}

class _AlahNamesState extends State<AlahNames> {
 
  // List of the 99 names of Allah with their meanings
  final List<Map<String, String>> _allahNamesWithMeanings = [
  {
    'name': 'الملك',
    'meaning': 'الملك هو الله الذي له الملك كله، وهو المتصرف في خلقه بما يشاء.',
  },
  {
    'name': 'الرحيم',
    'meaning': 'الرحيم هو الله الذي يرحم عباده ويغفر لهم ذنوبهم.',
  },
  {
    'name': 'الرحمن',
    'meaning': 'الرحمن هو الله الذي وسعت رحمته كل شيء.',
  },
  {
    'name': 'الله',
    'meaning': 'الله هو الاسم الأعظم الذي لا يسمى به غيره، وهو الإله الواحد الأحد.',
  },
  {
    'name': 'المهيمن',
    'meaning': 'المهيمن هو الله الذي يشهد على كل شيء ويحفظه.',
  },
  {
    'name': 'المؤمن',
    'meaning': 'المؤمن هو الله الذي يؤمن عباده من الخوف والظلم.',
  },
  {
    'name': 'السلام',
    'meaning': 'السلام هو الله الذي سلم من كل عيب ونقص.',
  },
  {
    'name': 'القدوس',
    'meaning': 'القدوس هو الله الذي تنزه عن كل نقص وعيب.',
  },
  {
    'name': 'العزيز',
    'meaning': 'العزيز هو الله الذي لا يُغلب ولا يُقهر.',
  },
  {
    'name': 'الجبار',
    'meaning': 'الجبار هو الله الذي يقهر الجبابرة ويصلح أحوال الخلق.',
  },
  {
    'name': 'المتكبر',
    'meaning': 'المتكبر هو الله الذي يتكبر على الظالمين ويعلو على كل شيء.',
  },
  {
    'name': 'الخالق',
    'meaning': 'الخالق هو الله الذي خلق كل شيء بقدرته.',
  },
  {
    'name': 'البارئ',
    'meaning': 'البارئ هو الله الذي خلق الخلق وأبدعهم.',
  },
  {
    'name': 'المصور',
    'meaning': 'المصور هو الله الذي صور الخلق في أحسن صورة.',
  },
  {
    'name': 'الغفار',
    'meaning': 'الغفار هو الله الذي يغفر الذنوب ويستر العيوب.',
  },
  {
    'name': 'القهار',
    'meaning': 'القهار هو الله الذي يقهر الخلق بقدرته.',
  },
  {
    'name': 'الوهاب',
    'meaning': 'الوهاب هو الله الذي يهب العطايا بلا حساب.',
  },
  {
    'name': 'الرزاق',
    'meaning': 'الرزاق هو الله الذي يرزق كل مخلوق.',
  },
  {
    'name': 'الفتاح',
    'meaning': 'الفتاح هو الله الذي يفتح أبواب الرزق والخير.',
  },
  {
    'name': 'العليم',
    'meaning': 'العليم هو الله الذي يعلم كل شيء.',
  },
  {
    'name': 'القابض',
    'meaning': 'القابض هو الله الذي يقبض الأرزاق والأرواح.',
  },
  {
    'name': 'الباسط',
    'meaning': 'الباسط هو الله الذي يبسط الرزق والرحمة.',
  },
  {
    'name': 'الخافض',
    'meaning': 'الخافض هو الله الذي يخفض الظالمين والمتكبرين.',
  },
  {
    'name': 'الرافع',
    'meaning': 'الرافع هو الله الذي يرفع المؤمنين والصالحين.',
  },
  {
    'name': 'المعز',
    'meaning': 'المعز هو الله الذي يعز من يشاء من عباده.',
  },
  {
    'name': 'المذل',
    'meaning': 'المذل هو الله الذي يذل من يشاء من عباده.',
  },
  {
    'name': 'السميع',
    'meaning': 'السميع هو الله الذي يسمع كل شيء.',
  },
  {
    'name': 'البصير',
    'meaning': 'البصير هو الله الذي يرى كل شيء.',
  },
  {
    'name': 'الحكم',
    'meaning': 'الحكم هو الله الذي يحكم بين الخلق بالعدل.',
  },
  {
    'name': 'العدل',
    'meaning': 'العدل هو الله الذي لا يظلم أحداً.',
  },
  {
    'name': 'اللطيف',
    'meaning': 'اللطيف هو الله الذي يلطف بعباده في كل أمورهم.',
  },
  {
    'name': 'الخبير',
    'meaning': 'الخبير هو الله الذي يعلم خفايا الأمور.',
  },
  {
    'name': 'الحليم',
    'meaning': 'الحليم هو الله الذي لا يعجل بالعقوبة.',
  },
  {
    'name': 'العظيم',
    'meaning': 'العظيم هو الله الذي لا أعظم منه.',
  },
  {
    'name': 'الغفور',
    'meaning': 'الغفور هو الله الذي يغفر الذنوب.',
  },
  {
    'name': 'الشكور',
    'meaning': 'الشكور هو الله الذي يشكر القليل من العمل.',
  },
  {
    'name': 'العلي',
    'meaning': 'العلي هو الله الذي لا أعلى منه.',
  },
  {
    'name': 'الكبير',
    'meaning': 'الكبير هو الله الذي لا أكبر منه.',
  },
  {
    'name': 'الحفيظ',
    'meaning': 'الحفيظ هو الله الذي يحفظ الخلق وأعمالهم.',
  },
  {
    'name': 'المقيت',
    'meaning': 'المقيت هو الله الذي يوفر الأرزاق للخلق.',
  },
  {
    'name': 'الحسيب',
    'meaning': 'الحسيب هو الله الذي يكفي عباده كل شيء.',
  },
  {
    'name': 'الجليل',
    'meaning': 'الجليل هو الله الذي له الجلال والعظمة.',
  },
  {
    'name': 'الكريم',
    'meaning': 'الكريم هو الله الذي يعطي بلا حساب.',
  },
  {
    'name': 'الرقيب',
    'meaning': 'الرقيب هو الله الذي يراقب كل شيء.',
  },
  {
    'name': 'المجيب',
    'meaning': 'المجيب هو الله الذي يجيب دعاء الداعين.',
  },
  {
    'name': 'الواسع',
    'meaning': 'الواسع هو الله الذي وسع كل شيء رحمةً وعلماً.',
  },
  {
    'name': 'الحكيم',
    'meaning': 'الحكيم هو الله الذي يضع الأشياء في مواضعها.',
  },
  {
    'name': 'الودود',
    'meaning': 'الودود هو الله الذي يحب عباده الصالحين.',
  },
  {
    'name': 'المجيد',
    'meaning': 'المجيد هو الله الذي له المجد والعظمة.',
  },
  {
    'name': 'الباعث',
    'meaning': 'الباعث هو الله الذي يبعث الخلق بعد الموت.',
  },
  {
    'name': 'الشهيد',
    'meaning': 'الشهيد هو الله الذي يشهد على كل شيء.',
  },
  {
    'name': 'الحق',
    'meaning': 'الحق هو الله الذي لا شيء أصدق منه.',
  },
  {
    'name': 'الوكيل',
    'meaning': 'الوكيل هو الله الذي يتولى أمور عباده.',
  },
  {
    'name': 'القوي',
    'meaning': 'القوي هو الله الذي لا يعجزه شيء.',
  },
  {
    'name': 'المتين',
    'meaning': 'المتين هو الله الذي لا يحتاج إلى أحد.',
  },
  {
    'name': 'الولي',
    'meaning': 'الولي هو الله الذي يتولى عباده الصالحين.',
  },
  {
    'name': 'الحميد',
    'meaning': 'الحميد هو الله الذي يستحق الحمد.',
  },
  {
    'name': 'المحصي',
    'meaning': 'المحصي هو الله الذي يحصي أعمال الخلق.',
  },
  {
    'name': 'المبدئ',
    'meaning': 'المبدئ هو الله الذي يبدأ الخلق.',
  },
  {
    'name': 'المعيد',
    'meaning': 'المعيد هو الله الذي يعيد الخلق بعد الموت.',
  },
  {
    'name': 'المحيي',
    'meaning': 'المحيي هو الله الذي يحيي الموتى.',
  },
  {
    'name': 'المميت',
    'meaning': 'المميت هو الله الذي يميت الخلق.',
  },
  {
    'name': 'الحي',
    'meaning': 'الحي هو الله الذي لا يموت.',
  },
  {
    'name': 'القيوم',
    'meaning': 'القيوم هو الله الذي يقوم على كل شيء.',
  },
  {
    'name': 'الواجد',
    'meaning': 'الواجد هو الله الذي لا يعوزه شيء.',
  },
  {
    'name': 'الماجد',
    'meaning': 'الماجد هو الله الذي له المجد والعظمة.',
  },
  {
    'name': 'الواحد',
    'meaning': 'الواحد هو الله الذي لا شريك له.',
  },
  {
    'name': 'الصمد',
    'meaning': 'الصمد هو الله الذي يُقصد في الحاجات.',
  },
  {
    'name': 'القادر',
    'meaning': 'القادر هو الله الذي يقدر على كل شيء.',
  },
  {
    'name': 'المقتدر',
    'meaning': 'المقتدر هو الله الذي لا يعجزه شيء.',
  },
  {
    'name': 'المقدم',
    'meaning': 'المقدم هو الله الذي يقدم من يشاء.',
  },
  {
    'name': 'المؤخر',
    'meaning': 'المؤخر هو الله الذي يؤخر من يشاء.',
  },
  {
    'name': 'الأول',
    'meaning': 'الأول هو الله الذي لا شيء قبله.',
  },
  {
    'name': 'الآخر',
    'meaning': 'الآخر هو الله الذي لا شيء بعده.',
  },
  {
    'name': 'الظاهر',
    'meaning': 'الظاهر هو الله الذي لا شيء فوقه.',
  },
  {
    'name': 'الباطن',
    'meaning': 'الباطن هو الله الذي لا شيء دونه.',
  },
  {
    'name': 'الوالي',
    'meaning': 'الوالي هو الله الذي يتولى أمور الخلق.',
  },
  {
    'name': 'المتعالي',
    'meaning': 'المتعالي هو الله الذي يتعالى عن كل نقص.',
  },
  {
    'name': 'البر',
    'meaning': 'البر هو الله الذي يعامل عباده بالبر والإحسان.',
  },
  {
    'name': 'التواب',
    'meaning': 'التواب هو الله الذي يقبل توبة التائبين.',
  },
  {
    'name': 'المنتقم',
    'meaning': 'المنتقم هو الله الذي ينتقم من الظالمين.',
  },
  {
    'name': 'العفو',
    'meaning': 'العفو هو الله الذي يعفو عن الذنوب.',
  },
  {
    'name': 'الرؤوف',
    'meaning': 'الرؤوف هو الله الذي يرأف بعباده.',
  },
  {
    'name': 'مالك الملك',
    'meaning': 'مالك الملك هو الله الذي يملك الملك كله.',
  },
  {
    'name': 'ذو الجلال والإكرام',
    'meaning': 'ذو الجلال والإكرام هو الله الذي له الجلال والإكرام.',
  },
  {
    'name': 'المقسط',
    'meaning': 'المقسط هو الله الذي يعطي العدل للخلق.',
  },
  {
    'name': 'الجامع',
    'meaning': 'الجامع هو الله الذي يجمع الخلق يوم القيامة.',
  },
  {
    'name': 'الغني',
    'meaning': 'الغني هو الله الذي لا يحتاج إلى شيء.',
  },
  {
    'name': 'المغني',
    'meaning': 'المغني هو الله الذي يغني عباده.',
  },
  {
    'name': 'المانع',
    'meaning': 'المانع هو الله الذي يمنع ما يشاء.',
  },
  {
    'name': 'الضار',
    'meaning': 'الضار هو الله الذي يضر من يشاء.',
  },
  {
    'name': 'النافع',
    'meaning': 'النافع هو الله الذي ينفع من يشاء.',
  },
  {
    'name': 'النور',
    'meaning': 'النور هو الله الذي ينور السماوات والأرض.',
  },
  {
    'name': 'الهادي',
    'meaning': 'الهادي هو الله الذي يهدي من يشاء.',
  },
  {
    'name': 'البديع',
    'meaning': 'البديع هو الله الذي خلق الخلق بإبداع.',
  },
  {
    'name': 'الباقي',
    'meaning': 'الباقي هو الله الذي لا يفنى.',
  },
  {
    'name': 'الوارث',
    'meaning': 'الوارث هو الله الذي يرث الأرض ومن عليها.',
  },
  {
    'name': 'الرشيد',
    'meaning': 'الرشيد هو الله الذي يهدي إلى الصواب.',
  },
  {
    'name': 'الصبور',
    'meaning': 'الصبور هو الله الذي لا يعجل بالعقوبة.',
  },
];



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: screenSize.height * 0.18, // Responsive app bar height
            floating: false,
            pinned: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new, 
                color: theme.colorScheme.primary,
                size: screenSize.width * 0.06, // Responsive icon size
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'أسماء الله الحسنى',
                style: GoogleFonts.tajawal(
                  fontSize: screenSize.width * 0.06, // Responsive font size
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
              ),
              centerTitle: true,
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.all(screenSize.width * 0.04), // Responsive padding
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isPortrait ? 3 : 5, // More columns in landscape
                crossAxisSpacing: screenSize.width * 0.03,
                mainAxisSpacing: screenSize.height * 0.015,
                childAspectRatio: isPortrait ? 0.9 : 1.1,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildNameCard(context, index, screenSize),
                childCount: _allahNamesWithMeanings.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameCard(BuildContext context, int index, Size screenSize) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (_, __, ___) => DetailPage(
              name: _allahNamesWithMeanings[index]['name']!,
              meaning: _allahNamesWithMeanings[index]['meaning']!,
              screenSize: screenSize,
            ),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDarkMode
                ? [
                    Color.lerp(
                        theme.colorScheme.surface, const Color.fromARGB(255, 222, 222, 222), 0.3)!,
                    Color.lerp(
                        theme.colorScheme.surface, const Color.fromARGB(255, 131, 129, 129), 0.3)!,
                  ]
                : [
                    Color.lerp(
                        theme.colorScheme.surface, const Color.fromARGB(255, 29, 26, 26), 0.3)!,
                    Color.lerp(
                        theme.colorScheme.surface, const Color.fromARGB(255, 29, 26, 26), 0.3)!,
                  ],
          ),
          borderRadius: BorderRadius.circular(screenSize.width * 0.03), // Responsive border radius
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDarkMode ? 0.2 : 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _allahNamesWithMeanings[index]['name']!,
                style: GoogleFonts.tajawal(
                  fontSize: screenSize.width * 0.045, // Responsive font size
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenSize.height * 0.005),
              Icon(
                Icons.arrow_circle_up_outlined,
                color: isDarkMode
                    ? Color.lerp(
                        theme.colorScheme.surface, const Color.fromARGB(255, 29, 26, 26), 0.3)!
                    : theme.colorScheme.inverseSurface,
                size: screenSize.width * 0.06, // Responsive icon size
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String name;
  final String meaning;
  final Size screenSize;

  const DetailPage({
    super.key, 
    required this.name, 
    required this.meaning,
    required this.screenSize
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenSize.width * 0.05), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenSize.height * 0.08),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(screenSize.width * 0.05), // Responsive padding
              decoration: BoxDecoration(
                color: isDarkMode
                    ? theme.colorScheme.primary
                    : theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(screenSize.width * 0.04), // Responsive radius
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.surface,
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.tajawal(
                      fontSize: screenSize.width * 0.08, // Responsive font size
                      fontWeight: FontWeight.w700,
                      color: isDarkMode
                          ? theme.colorScheme.surface
                          : theme.colorScheme.surface,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  Divider(
                    color: (isDarkMode
                            ? theme.colorScheme.surface
                            : theme.colorScheme.surface)
                        .withOpacity(0.3),
                    thickness: 1,
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  Text(
                    meaning,
                    style: GoogleFonts.tajawal(
                      fontSize: screenSize.width * 0.045, // Responsive font size
                      height: 1.6,
                      color: isDarkMode
                          ? theme.colorScheme.surface
                          : theme.colorScheme.surface,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: screenSize.height * 0.03),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.04,
                        vertical: screenSize.height * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: (isDarkMode
                                ? theme.colorScheme.surface
                                : theme.colorScheme.surface)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'تفسير الاسم',
                        style: GoogleFonts.tajawal(
                          fontSize: screenSize.width * 0.035, // Responsive font size
                          color: isDarkMode
                              ? theme.colorScheme.surface
                              : theme.colorScheme.surface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenSize.height * 0.04),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.1, // Responsive padding
                    vertical: screenSize.height * 0.02, // Responsive padding
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'العودة إلى الأسماء',
                  style: GoogleFonts.tajawal(
                    fontSize: screenSize.width * 0.04, // Responsive font size
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.surface,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}