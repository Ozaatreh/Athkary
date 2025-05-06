import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class QuranCompletionMethodsScreen extends StatefulWidget {
  const QuranCompletionMethodsScreen({super.key});

  @override
  State<QuranCompletionMethodsScreen> createState() =>
      _QuranCompletionMethodsScreenState();
}

class _QuranCompletionMethodsScreenState
    extends State<QuranCompletionMethodsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final List<Map<String, String>> quranCompletionMethods = const [
    {
      'title': 'الطريقة الأولى: ختم القرآن كل شهر',
      'description':
          'يتناسب عدد أجزاء القرآن الكريم الثلاثين مع عدد أيّام الشهر، بمُعدَّل جزء في كلّ يومٍ. يمكن تخصيص وقت مُحدَّد للقراءة في اليوم الواحد، مثل قراءة صفحتَين من القرآن الكريم عند كلّ صلاةٍ مفروضةٍ؛ أي ما يساوي أربعة أوجه. وبهذه الطريقة يُنهي المسلم قراءة جزء كامل في اليوم الواحد، وثلاثين جزءاً في الشهر',
    },
    {
      'title': 'الطريقة الثانية: ختم القرآن كل أسبوع',
      'description':
          'كان الصحابة -رضوان الله عليهم- يقسّمون القرآن الكريم إلى سبعة أحزاب، وهو ما يُسمّى (تحزيب القرآن الكريم). فيقرؤون كلّ يومٍ حِزباً منه. هذا التحزيب يعتمد على تقسيم القرآن الكريم إلى سبعة أحزاب موضوعية، بحيث يبدأ كل حزب بفاتحة سورة جديدة. هذه الطريقة أفضل من التحزيب المتعارف عليه (30 جزءًا) لأنها تحافظ على السياق الموضوعي للآيات',
    },
    {
      'title': 'الطريقة الثالثة: ختم القرآن كل عشرة أيام',
      'description':
          'تُقدَّر الفترة الزمنيّة لقراءة الجزء الواحد من عشرين دقيقة إلى نصف ساعة. لختم القرآن في عشرة أيام، يمكن قراءة ثلاثة أجزاء يوميّاً (ساعة ونصف يوميّاً). لختمه في ثمانية أيام، يمكن قراءة أربعة أجزاء يوميّاً (ساعتان يوميّاً). ولختمه في خمسة أيام، يمكن قراءة ستة أجزاء يوميّاً (ثلاث ساعات يوميّاً)',
    },
    {
      'title': 'الطريقة الرابعة: ختم القرآن كل ثلاثة أيام',
      'description':
          'هذه الطريقة تتطلب قراءة الحَدر (القراءة السريعة مع مراعاة أحكام التلاوة). تستغرق قراءة الجزء الواحد نحو عشرين دقيقة. يمكن تقسيم الوقت كالتالي: جزء بعد أذان الفجر (20 دقيقة)، ثلاثة أجزاء بعد صلاة الفجر (ساعة)، جزأين بعد صلاة الظهر (40 دقيقة)، ثلاثة أجزاء بعد صلاة العصر (ساعة)، وجزء بعد صلاة العشاء (20 دقيقة). بهذا يتم ختم عشرة أجزاء يوميّاً، وختم القرآن كاملاً في ثلاثة أيام',
    },
    {
      'title': 'الطريقة الخامسة: ختم القرآن في يوم واحد',
      'description':
          'يمكن ختم القرآن الكريم كاملاً في يوم واحد بتخصيص خمس إلى ست ساعات يوميّاً لقراءة القرآن قراءة حَدر. يمكن تقسيم الوقت على اليوم كاملاً، بحيث يتم قراءة الجزء الواحد في عشر إلى اثنتَي عشرة دقيقة. هذه الطريقة تتطلب جهدًا كبيرًا وتركيزًا عاليًا',
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
      appBar: AppBar(
        leading: IconButton(
            icon:  Icon(Icons.arrow_back_ios_new_rounded , color: Theme.of(context).colorScheme.primary,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        title:  Text('كيفية ختم القرآن الكريم' , style: textStyle1,),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: quranCompletionMethods.length,
        itemBuilder: (context, index) {
          return _buildExpansionTile(
            context,
            question: quranCompletionMethods[index]['title']!,
            answer: quranCompletionMethods[index]['description']!,
          );
        },
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
    color: Theme.of(context).colorScheme.primary, );
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
            style:textStyle2 ,
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
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}