// ignore_for_file: unused_import

import 'package:athkar_app/athkar_info.dart';
import 'package:athkar_app/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tasabeh extends StatefulWidget {
  Tasabeh({
    super.key,
  });

  @override
  State<Tasabeh> createState() => _TasabehState();
}

class _TasabehState extends State<Tasabeh> {
  final List<String> theker1 = [
    'سُبْحَانَ اللَّهِ', //1
    'لا حَوْلَ وَلا قُوَّةَ إِلا بِاللَّهِ', //2
    'الْلَّهُم صَلِّ وَسَلِم وَبَارِك عَلَى سَيِّدِنَا مُحَمَّد', //3
    'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ', //4
    'أستغفر الله', //5
    'سُبْحَانَ الْلَّهِ، وَالْحَمْدُ لِلَّهِ، وَلَا إِلَهَ إِلَّا الْلَّهُ، وَالْلَّهُ أَكْبَرُ', //6
    'لَا إِلَهَ إِلَّا اللَّهُ ', //7
    'الْحَمْدُ لِلَّهِ حَمْدًا كَثِيرًا طَيِّبًا مُبَارَكًا فِيهِ', //8
  ];

  final List<String> thekinfo1 = [
    'ي كتب له ألف حسنة أو يحط عنه ألف خطيئة', //1
    'كنز من كنوز الجنة ', //2
    'من صلى على حين يصبح وحين يمسى ادركته شفاعتى يوم القيامة.', //3
    'حُطَّتْ خَطَايَاهُ وَإِنْ كَانَتْ مِثْلَ زَبَدِ الْبَحْرِ. لَمْ يَأْتِ أَحَدٌ يَوْمَ الْقِيَامَةِ بِأَفْضَلَ مِمَّا جَاءَ بِهِ إِلَّا أَحَدٌ قَالَ مِثْلَ مَا قَالَ أَوْ زَادَ عَلَيْهِ', //4
    'غفر اللهُ له، وإن كان فرَّ من الزحف', //5
    'هن أحب الكلام الى الله، ومكفرات للذنوب، وغرس الجنة، وجنة لقائلهن من النار، وأحب الى النبي عليه السلام مما طلعت عليه الشمس، والْبَاقِيَاتُ الْصَّالِحَات.',
    'أفضل الذكر لا إله إلاّ الله.', //7
    'قَالَ النَّبِيُّ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ لَقَدْ رَأَيْتُ اثْنَيْ عَشَرَ مَلَكًا يَبْتَدِرُونَهَا، أَيُّهُمْ يَرْفَعُهَا"', //8
  ];

  static final String icon1 ='assets/icons/anniversary.png';

  List<Widget> thekeprovider(List<String> theker, List<String> thekinfo) {
    List<Widget> items = [];
    for (int i = 0; i < theker.length && i < thekinfo.length; i++) {
      items.add(Card(
        child: ListTile(
          leading: Padding(
        padding:  const EdgeInsets.all(3.0) ,
        child: Image(image: AssetImage(icon1) )),
          onTap: () {},
          title: Text(theker[i],style: GoogleFonts.amiri(
                  color: Color.fromARGB(255, 9, 9, 9),
                  textStyle: const TextStyle(fontSize: 25),
                ),),
                
          subtitle: Text(thekinfo[i],style: GoogleFonts.amiri(
                  color: Color.fromARGB(255, 48, 47, 47),
                  textStyle: const TextStyle(fontSize: 20),
                ),),
        ),
      ));
    }
    return items;
  }

  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(left: 95.0),
              child: Text(
                "تسابيح",
                style: GoogleFonts.amiri(
                  color: Color.fromARGB(255, 249, 248, 248),
                  textStyle: const TextStyle(fontSize: 25),
                ),
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 93, 89, 89),
            leading: IconButton( 
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => HomePage()),
                    ),
                  );
                },
                icon: Icon(
                  color: Colors.white,
                  Icons.arrow_back_ios_new_sharp,
                  size: 25,
                )),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 33, 33, 33),
                  Color.fromARGB(255, 71, 70, 70),
                  Color.fromARGB(255, 112, 109, 109),
                  Color.fromARGB(255, 101, 97, 97),
                  Color.fromARGB(255, 101, 97, 97),
                  const Color.fromARGB(255, 71, 70, 70),
                  Color.fromARGB(255, 38, 36, 36)
                ],
              ),
            ),
            child: ListView(
              children: thekeprovider(theker1, thekinfo1),
            ),
          ),
        ),
      ),
    );
  }
}
