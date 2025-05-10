// ignore_for_file: unused_import

import 'package:athkar_app/Component/drawer.dart';
import 'package:athkar_app/pages/masbahah_elc.dart';
import 'package:athkar_app/pages/tasabeh.dart';
import 'package:athkar_app/notification.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:athkar_app/athkar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // void notifi1( ){

      Color color1 = Color.fromARGB(255, 48, 46, 46);

  Color themechanger(Color newcolor) {
    setState(() {
      color1 = newcolor;
    });
    return color1;
    }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: color1,
          appBar: AppBar(
            backgroundColor: color1,
            // leading: IconButton(
            //     onPressed: () => CustomDrawer(),
            //     icon: Icon(
            //       Icons.layers_outlined
            //       ,
            //     ),),
            title: Padding(
              padding: const EdgeInsets.only(left: 95.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween
                ,
                children: [
                  Text(
                    'Athkar',
                    style: GoogleFonts.robotoSlab(
                        color: Color.fromARGB(255, 218, 213, 213),
                        textStyle: const TextStyle(fontSize: 19)),
                  ),
                 
                //  SizedBox(width: 60,),

                IconButton(
                    onPressed: () {
                      themechanger(Color.fromARGB(255, 188, 188, 188));
                    },
                    alignment: Alignment.bottomCenter,
                    icon: const Icon(
                      Icons.color_lens,
                      size: 30,
                      color: Color.fromARGB(255, 251, 249, 249),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          drawer: const CustomDrawer(),
          body: Container(
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     colors: [
            //       Color.fromARGB(255, 33, 33, 33),
            //       Color.fromARGB(255, 71, 70, 70),
            //       Color.fromARGB(255, 112, 109, 109),
            //       Color.fromARGB(255, 101, 97, 97),
            //       Color.fromARGB(255, 101, 97, 97),
            //       const Color.fromARGB(255, 71, 70, 70),
            //       Color.fromARGB(255, 38, 36, 36)
            //     ],
            //   ),
            // ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset('assets/images/App_icon.png'),
                  SizedBox(
                    height: 13,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 251, 248, 248),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        height: 150,
                        width: 150,
                        alignment: Alignment.topRight,
                        child: Builder(
                          builder: (context) => Center(
                            child: TextButton(
                              child: Text(
                                "اذكار الصباح",
                                style: GoogleFonts.lalezar(
                                  color: Color.fromARGB(255, 9, 9, 9),
                                  textStyle: const TextStyle(fontSize: 25),
                                ),
                              ),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => Tasabeh()),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // color: Color.fromARGB(255, 159, 157, 157),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 247, 243, 243),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        height: 150,
                        width: 150,
                        alignment: Alignment.topRight,
                        child: Builder(
                          builder: (context) => Center(
                            child: TextButton(
                              style: ButtonStyle(
                                fixedSize: MaterialStatePropertyAll(
                                  Size(200, 200),
                                ),
                                // backgroundColor: MaterialStateColor.resolveWith((states) => Colors.amber)
                              ),
                              child: Text(
                                "تسابيح",
                                style: GoogleFonts.lalezar(
                                  color: Color.fromARGB(255, 9, 9, 9),
                                  textStyle: const TextStyle(fontSize: 25),
                                ),
                              ),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => Tasabeh()),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 251, 248, 248),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        height: 150,
                        width: 150,
                        alignment: Alignment.topRight,
                        child: Builder(
                          builder: (context) => Center(
                            child: TextButton(
                              style: ButtonStyle(
                                  padding: MaterialStatePropertyAll(
                                    EdgeInsets.only(left: 30),
                                  ),
                                  fixedSize: MaterialStatePropertyAll(
                                    Size(200, 200),
                                  ),
                                  // backgroundColor:
                                  //     MaterialStateColor.resolveWith(
                                  //         (states) => Colors.amber)
                                  ),
                              child: Text(
                                "المسبحة الالكترونية",
                                style: GoogleFonts.lalezar(
                                  color: Color.fromARGB(255, 9, 9, 9),
                                  textStyle: const TextStyle(fontSize: 25),
                                ),
                              ),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => MasbahaElc()),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 247, 243, 243),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        height: 150,
                        width: 150,
                        alignment: Alignment.topRight,
                        child: Builder(
                          builder: (context) => Center(
                            child: TextButton(
                              style: ButtonStyle(
                                fixedSize: MaterialStatePropertyAll(
                                  Size(200, 200),
                                ),
                                // backgroundColor: MaterialStateColor.resolveWith((states) => Colors.amber)
                              ),
                              child: Text(
                                "اذكار المساء",
                                style: GoogleFonts.lalezar(
                                  color: Color.fromARGB(255, 9, 9, 9),
                                  textStyle: const TextStyle(fontSize: 25),
                                ),
                              ),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => Tasabeh()),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  CustomNotification(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

late final String theker;
