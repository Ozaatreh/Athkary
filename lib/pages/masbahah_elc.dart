import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MasbahaElc extends StatefulWidget {
  @override
  _MasbahaElcState createState() => _MasbahaElcState();
}

class _MasbahaElcState extends State<MasbahaElc> {
  int counter = 0;
  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  int tasabehcount = 0;
  void clear() {
    setState(() {
      tasabehcount += counter;
      counter = 0;
    });
  }
 
  Color color1 = Color.fromARGB(255, 48, 46, 46);

  Color themechanger(Color newcolor) {
    setState(() {
      color1 = newcolor;
    });
    return color1;
    }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: color1,
        appBar: AppBar(
          backgroundColor: color1,
          title: Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Masbaha Elctroneh',
                  style: GoogleFonts.robotoSlab(
                    color: const Color.fromARGB(255, 255, 253, 253),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    themechanger(Color.fromARGB(255, 134, 126, 126));
                  },
                  alignment: Alignment.bottomCenter,
                  icon: const Icon(
                    Icons.color_lens,
                    size: 30,
                    color: Color.fromARGB(255, 236, 213, 213),
                  ),
                ),
              ],
            ),
          ),
        ),
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Count  :   $counter',
                  style: GoogleFonts.robotoSlab(
                    color: const Color.fromARGB(255, 255, 253, 253),
                    textStyle: const TextStyle(fontSize: 25),
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: FloatingActionButton(
                        onPressed: clear,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        backgroundColor: Color.fromARGB(255, 215, 221, 227),
                        // foregroundColor: const Color.fromARGB(255, 251, 63, 63),
                        // Large floating button
                        // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        // mini: false,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 300, // Set the desired width
                  height: 300, // Set the desired height
                  child: FloatingActionButton(
                    heroTag: 'bt1',
                    onPressed: incrementCounter,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(300),
                    ),
                    backgroundColor: Color.fromARGB(255, 215, 221, 227),
                    // foregroundColor: const Color.fromARGB(255, 251, 63, 63),
                    // Large floating button
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    mini: false,
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  'Tasbehat  :   $tasabehcount',
                  style: GoogleFonts.robotoSlab(
                    color: const Color.fromARGB(255, 255, 253, 253),
                    textStyle: const TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
