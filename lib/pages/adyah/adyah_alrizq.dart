import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdyahAlrizq extends StatefulWidget {
  const AdyahAlrizq({super.key});

  @override
  State<AdyahAlrizq> createState() => _AdyahAlrizqState();
}

class _AdyahAlrizqState extends State<AdyahAlrizq> {
    final List<String> adyahAlrizq = [
  "اللَّهُمَّ لا مَانِعَ لِما أعْطَيْتَ، ولَا مُعْطِيَ لِما مَنَعْتَ، ولَا يَنْفَعُ ذَا الجَدِّ مِنْكَ الجد",
  "اللهم إني أعوذُ بكَ منَ الهمِّ والحزَنِ، وأعوذُ بكَ منَ العجزِ والكسلِ، وأعوذُ بكَ منَ الجُبنِ والبخلِ؛ وأعوذُ بكَ مِن غلبةِ الدَّينِ وقهرِ الرجالِ",
  "اللهمَّ مالكَ الملكِ تُؤتي الملكَ مَن تشاء، وتنزعُ الملكَ ممن تشاء، وتُعِزُّ مَن تشاء، وتذِلُّ مَن تشاء، بيدِك الخيرُ إنك على كلِّ شيءٍ قدير، رحمنُ الدنيا والآخرةِ ورحيمُهما، تعطيهما من تشاء، وتمنعُ منهما من تشاء، ارحمْني رحمةً تُغنيني بها عن رحمةِ مَن سواك",
  "اللهم أَغْنِني من الفقرِ واقضِ عني الدَّينَ وتوفّني في عبادتِك وجهادٍ في سبيلِك",
  "اللهم إن كان رزقي في السّماء فأنزله، وإن كان في الأرض فأخرجه، وإن كان بعيداً فقرّبه، وإن كان قريباً فيسّره، وإن كان قليلاً فكثّره، وإن كان كثيراً فبارك لي فيه",
  "اللهم رب السموات السبع، ورب العرش العظيم، اقض عنا الدين وأغننا من الفقر",
  "اللهم صل على سيدنا محمد، وعلى آل محمد، يا ذا الجلال والإكرام، يا قاضي الحاجات، يا أرحم الراحمين، يا حي يا قيوم، لا إله إلا أنت الملك الحق المبين",
  "اللهم اكفني وأغنني بحلالك عن حرامك، وأغنني بفضلك عمن سواك",
  "يا الله، يا رب، يا حي يا قيوم، يا ذا الجلال والإكرام، أسألك باسمك العظيم الأعظم أن ترزقني رزقاً واسعاً حلالاً طيباً، برحمتك يا أرحم الراحمين",
  "اللهم ارزقنا رزقا حلالا طيبا مباركا فيه كما تحب وترضى يا رب العالمين",
  "حسبنا الله سيؤتينا من فضله إنا إلى الله لراغبون",
  "اللهم يا رازق السائلين، يا راحم المساكين، ويا ذا القوة المتين، ويا خير الناصرين، يا ولي المؤمنين، يا غيّاث المستغيثين، إياك نعبد وإيّاك نستعين، اللهم إني أسألك رزقاً واسعاً طيباً من رزقك",
  "يا مقيل العثرات، يا قاضي الحاجات، اقض حاجتي، وفرج كربتي، وارزقني من حيث لا أحتسب",
  "اللهم أغننا بحلالك عن حرامك، وتولّنا فأنت أرحم الراحمين",
  "يا واصل المنقطعين أوصلنا إليك، ويا جابر المنكسرين اجعل حاجتنا إليك، وأغننا بالافتقار إليك، ولا تفقرنا بالاستغناء عنك"
];


  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateItems());
  }

  void _animateItems() async {
    for (int i = 0; i < adyahAlrizq.length; i++) {
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
          "أدعية الرزق",
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
                child: _buildDuaCard(context, index),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDuaCard(BuildContext context, int index) {
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
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Text(
          adyahAlrizq[index],
          textAlign: TextAlign.right,
          style: GoogleFonts.amiri(
            fontSize: 20,
            height: 1.6,
            color: isDarkMode ? Colors.white : theme.colorScheme.surface,
          ),
        ),
      ),
    );
  }
}