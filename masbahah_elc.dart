import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MasbahaElc extends StatefulWidget {
  const MasbahaElc({super.key});

  @override
  _MasbahaElcState createState() => _MasbahaElcState();
}

class _MasbahaElcState extends State<MasbahaElc> {
  int counter = 0;
  int tasabehcount = 0;
  final player = AudioPlayer(); // Create audio player instance

  @override
void initState() {
  super.initState();
  _loadCounts();
  

}


  // Load the saved values from SharedPreferences
  Future<void> _loadCounts() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getInt('counter') ?? 0;
      tasabehcount = prefs.getInt('tasabehcount') ?? 0;
    });
  }

  // Save the values to SharedPreferences
  Future<void> _saveCounts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', counter);
    await prefs.setInt('tasabehcount', tasabehcount);
  }

  // Play sound when counter reaches 100
  Future<void> _playSound() async {
    await player.play(AssetSource('audios/counter100.m4a') , volume: 100);
  }

  void incrementCounter() {
    setState(() {
      counter++;
       // Play sound only if counter is exactly 100, 200, 300, etc.
    if ( counter % 100 == 0) {
      _playSound();
    }
    });
    _saveCounts();
  }

  void clear() {
    setState(() {
      tasabehcount += counter;
      counter = 0;
    });
    _saveCounts();
  }

  void clearAll() {
    setState(() {
      tasabehcount = 0;
      counter = 0;
    });
    _saveCounts();
  }

  // Show confirmation dialog
  void _showResetConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Reset Tasbehat",
            style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          content: Text(
            "Do you want to reset all tasbehat?",
            style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                "No",
                style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
              ),
            ),
            TextButton(
              onPressed: () {
                clearAll();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                "Yes",
                style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Text(
                    'Electronic Masbaha',
                    style: GoogleFonts.robotoSlab(
                      fontSize: 17,
                      color: Theme.of(context).colorScheme.primary,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                color: Theme.of(context).colorScheme.primary,
                Icons.arrow_back_ios_new_sharp,
                size: 25,
              )),
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Count  :   $counter',
                  style: GoogleFonts.electrolize(
                    color: const Color.fromARGB(255, 255, 253, 253),
                    textStyle: const TextStyle(fontSize: 25),
                  ),
                ),
                const SizedBox(height: 40),
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
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  height: 300,
                  child: FloatingActionButton(
                    heroTag: 'bt1',
                    onPressed: incrementCounter,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(300),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    mini: false,
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tasbehat  :',
                      style: GoogleFonts.electrolize(
                        color: const Color.fromARGB(255, 255, 253, 253),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                    ),
                    TextButton(
                      onPressed: _showResetConfirmationDialog,
                      child: Text(
                        '$tasabehcount',
                        style: GoogleFonts.electrolize(
                          color: const Color.fromARGB(255, 255, 253, 253),
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
