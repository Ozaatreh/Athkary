import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClothingAndEatingSunnahsScreen extends StatefulWidget {
  const ClothingAndEatingSunnahsScreen({super.key});

  @override
  State<ClothingAndEatingSunnahsScreen> createState() =>
      _ClothingAndEatingSunnahsScreenState();
}

class _ClothingAndEatingSunnahsScreenState
    extends State<ClothingAndEatingSunnahsScreen> {
  final List<Map<String, String>> clothingAndEatingSunnahs = const [
    {
      'title': 'الدعاء عند لبس ثوب جديد',
      'description':
          'عن أبي سعيد الخدري ـ رضي الله عنه ـ قال: كان رسول الله ـ صلى الله عليه وسلم ـ إذا استجد ثوبا سماه باسمه : إما قميصا ، أو عمامة، ثم يقول: (( اللهم لك الحمد ، أنت كسوتنيه ، أسألك من خيره ، وخير ما صنع له ، وأعوذ بك من شره، وشر ما صنع له )) [ رواه أبو داود: 4020 ].',
    },
    {
      'title': 'لبس النعل باليمين',
      'description':
          'عن أبي هريرة ـ رضي الله عنه ـ قـال: قـال رسـول الله صلى الله عليه وسلم : (( إذا انتعل أحدكم فليبدأ باليمنى ، وإذا خلع فليبدأ بالشمال، ولينعلهما جميعًا، أو ليخلعهما جميعًا )) [ متفق عليه:5855 - 5495 ].',
    },
    {
      'title': 'التسمية عند الأكل',
      'description':
          'عن عمر بن أبي سلمة ـ رضي الله عنه ـ قال: كنت في حجر رسول الله ـ صلى الله عليه وسلم ـ وكانت يدي تطيش في الصحفة ، فقال لي: (( يا غلام سم الله ، وكل بيمينك، وكل مما يليك )) [ متفق عليه: 5376 - 5269 ].',
    },
    {
      'title': 'حمد الله بعد الأكل والشرب',
      'description':
          'عن أنس بن مالك ـ رضي الله عنه ـ قال: قال رسول الله صلى الله عليه وسلم : (( إن الله ليرضى عن العبد أن يأكل الأكلة فيحمده عليها ، أو يشرب الشربة فيحمده عليها )) [ رواه مسلم: 6932 ].',
    },
    {
      'title': 'الجلوس عند الشرب',
      'description':
          'عن أنس رضي الله عنه ، عن النبي صلى الله عليه وسلم : (( أنه نهى أن يشرب الرجل قائمًا )) [ رواه مسلم: 5275 ].',
    },
    {
      'title': 'المضمضة من اللبن',
      'description':
          'عن ابن عباس رضي الله عنه ،أن رسول الله ـ صلى الله عليه وسلم ـ شرب لبنًا فمضمض، وقال: (( إن له دسمًا )) [ متفق عليه:798- 5609 ].',
    },
    {
      'title': 'عدم عيب الطعام',
      'description':
          'عن أبي هريرة ـ رضي الله عنه ـ قال: (( ما عاب رسول الله ـ صلى الله عليه وسلم ـ طعامًا قط ، كان إذا اشتهاه أكله ، وإن كرهه تركه )) [ متفق عليه:5409 - 5380 ].',
    },
    {
      'title': 'الأكل بثلاثة أصابع',
      'description':
          'عن كعب بن مال ـ رضي الله عنه ـ قال: (( كان رسول الله ـ صلى الله عليه وسلم ـ يأكل بثلاث أصابع ، ويلعق يده قبل أن يمسحها )) [ رواه مسلم: 5297 ].',
    },
    {
      'title': 'الشرب والاستشفاء من ماء زمزم',
      'description':
          'عن أبي ذر ـ رضي الله عنه ـ قال: قال رسول الله ـ صلى الله عليه وسلم ـ عن ماء زمزم: (( إنها مباركة ، إنها طعام طُعم )) [ رواه مسلم: 6359 ] زاد الطيالسي: (( وشفاء سُقم )).',
    },
    {
      'title': 'الأكل يوم عيد الفطر قبل الذهاب للمصلى',
      'description':
          'عن أنس بن مالك ـ رضي الله عنه ـ قال : (( كان رسول الله ـ صلى الله عليه وسلم ـ لا يغدو يوم الفطر حتى يأكل تمرات )) وفي رواية: (( ويأكلهن وترًا )) [ رواه البخاري: 953 ].',
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
    for (int i = 0; i < clothingAndEatingSunnahs.length; i++) {
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
          'سنن اللباس والطعام',
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
          clothingAndEatingSunnahs[index]['title']!,
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
              clothingAndEatingSunnahs[index]['description']!,
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