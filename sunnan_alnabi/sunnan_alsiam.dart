import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FastingSunnahsPage extends StatefulWidget {
  const FastingSunnahsPage({super.key});

  @override
  State<FastingSunnahsPage> createState() => _FastingSunnahsPageState();
}

class _FastingSunnahsPageState extends State<FastingSunnahsPage> {
  
   final List<Map<String, String>> fastingSunnahs = const [
    {
      'title': 'السحور',
      'description':
          'عن أنس ـ رضي الله عنه ـ قال : قال رسول الله صلى الله عليه وسلم : (( تسحروا ؛ فإن في السحور بركة )) [ متفق عليه: 1923 - 2549 ].',
    },
    {
      'title': 'تعجيل الفطر',
      'description':
          'عن سهل بن سعد ـ رضي الله عنه ـ قال: قال رسول الله صلى الله عليه وسلم : (( لا يزال الناس بخير ما عجلوا الفطر )) [ متفق عليه: 1957 - 2554 ].',
    },
    {
      'title': 'قيام رمضان',
      'description':
          'عن أبي هريرة رضي الله عنه ، أن رسول الله ـ صلى الله عليه وسلم ـ قال : (( من قام رمضان إيمانًا واحتسابًا غُفر له ما تقدم من ذنبه )) [ متفق عليه: 37-1779 ].',
    },
    {
      'title': 'الاعتكاف في رمضان',
      'description':
          'عن ابن عمر ـ رضي الله عنهما ـ قال: (( كان رسول الله ـ صلى الله عليه وسلم ـ يعتكف العشر الآواخر من رمضان )) [ رواه البخاري: 2025 ].',
    },
    {
      'title': 'صوم ستة أيام من شوال',
      'description':
          'عن أبي أيوب الأنصاري رضي الله عنه ، أن رسول الله ـ صلى الله عليه وسلم ـ قال: (( من صام رمضان ، ثم أتبعه ستًا من شوال ،كان كصيام الدهر )) [ رواه مسلم: 2758 ].',
    },
    {
      'title': 'صوم ثلاثة أيام من كل شهر',
      'description':
          'عن أبي هريرة ـ رضي الله عنه ـ قال: (( أوصاني خليلي بثلاث ، لا أدعهن حتى أموت: صوم ثلاثة أيام من كل شهر ، وصلاة الضحى ، ونوم على وتر )) [ متفق عليه: 1178-1672 ].',
    },
    {
      'title': 'صوم يوم عرفة',
      'description':
          'عن أبي قتادة رضي الله عنه ، أن رسول الله ـ صلى الله عليه وسلم ـ قال: (( صيام يوم عرفة، أحتسب على الله أن يكفر السنة التي قبلة، والسنة التي بعده )) [ رواه مسلم: 3746 ].',
    },
    {
      'title': 'صوم يوم عاشوراء',
      'description':
          'عن أبي قتادة ـ رضي الله عنه ـ قال: قال رسول الله صلى الله عليه وسلم : (( صيام يوم عاشوراء ، أحتسب على الله أن يكفر السنة التي قبله )) [ رواه مسلم: 3746 ].',
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
    for (int i = 0; i < fastingSunnahs.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      _listKey.currentState?.insertItem(i);
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
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
          'سنن الصيام',
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
          fastingSunnahs[index]['title']!,
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
              fastingSunnahs[index]['description']!,
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
 