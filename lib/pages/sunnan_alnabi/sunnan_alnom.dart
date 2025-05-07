import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SleepSunnahsPage extends StatefulWidget {
  const SleepSunnahsPage({super.key});

  @override
  State<SleepSunnahsPage> createState() => _SleepSunnahsPageState();
}

class _SleepSunnahsPageState extends State<SleepSunnahsPage> {
  
  final List<Map<String, String>> sleepSunnahs = const [
    {
      'title': 'النوم على وضوء',
      'description':
          'قـال النبي ـ صلى الله عليه وسلم ـ للبراء بن عازب رضي الله عنه : (( إذا أتيت مضجعك ، فتوضأ وضوءك للصلاة ، ثم اضطجع على شقك الأيمن... الحديث )) [ متفق عليه:6311-6882].',
    },
    {
      'title': 'قراءة سورة الإخلاص والمعوذتين قبل النوم',
      'description':
          'عن عائشة رضي الله عنها ، أن النبي ـ صلى الله عليه وسلم ـ كان إذا أوى إلى فراشه كل ليلة جمع كفيه ثم نفث فيهما ، فقرأ فيهما: (( قل هو الله أحد )) و (( قل أعوذ برب الفلق )) و (( قل أعوذ برب الناس )) ، ثم يمسح بهما ما استطاع من جسده ، يبدأ بهما على رأسه ووجهه ، وما أقبل من جسده ، يفعل ذلك ثلاث مرات. [ رواه البخاري: 5017].',
    },
    {
      'title': 'التكبير والتسبيح عند المنام',
      'description':
          'عن علي رضي الله عنه ، أن رسول الله ـ صلى الله عليه وسلم ـ قال حين طلبت منه فاطمة ـ رضي الله عنها ـ خادمًا: (( ألا أدلكما على ما هو خير لكما من خادم ؟ إذا أويتما إلى فراشكما ، أو أخذتما مضاجعكما ، فكبرا أربعًا وثلاثين ، وسبحا ثلاثًا وثلاثين ، واحمدا ثلاثًا وثلاثين. فهذا خير لكما من خادم )) [متفق عليه: 6318 – 6915].',
    },
    {
      'title': 'الدعاء حين الاستيقاظ أثناء النوم',
      'description':
          'عن عبادة بن الصامت رضي الله عنه ، عن النبي ـ صلى الله عليه وسلم ـ قال: (( من تعارَّ من الليل فقال: لا إله إلا الله وحده لا شريك له ، له الملك وله الحمد ، وهو على كل شيء قدير، الحمد لله ، وسبحان الله ، والله أكبر، ولا حول ولا قوة إلا بالله، ثم قال: اللهم اغفر لي، أو دعا ، استُجيب له ، فإنْ توضأ وصلى قُبِلت صلاته )) [ رواه البخاري: 1154].',
    },
    {
      'title': 'الدعاء عند الاستيقاظ من النوم',
      'description':
          '(( الحمد لله الذي أحيانا بعدما أماتنا ، وإليه النشور )) [ رواه البخاري من حديث حذيفة بن اليمان رضي الله عنه : 6312 ].',
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
    for (int i = 0; i < sleepSunnahs.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      _listKey.currentState?.insertItem(i);
      // await _scrollController.animateTo(
      //   _scrollController.position.maxScrollExtent,
      //   duration: const Duration(milliseconds: 300),
      //   curve: Curves.easeOut,
      // );
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
          'سنن النوم',
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
          sleepSunnahs[index]['title']!,
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
              sleepSunnahs[index]['description']!,
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