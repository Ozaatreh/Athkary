import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MasbahaElc extends StatefulWidget {
  const MasbahaElc({super.key});

  @override
  _MasbahaElcState createState() => _MasbahaElcState();
}

class _MasbahaElcState extends State<MasbahaElc> with SingleTickerProviderStateMixin {
  int counter = 0;
  int tasabehcount = 0;
  final player = AudioPlayer();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _loadCounts();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    player.dispose();
    super.dispose();
  }

  Future<void> _loadCounts() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getInt('counter') ?? 0;
      tasabehcount = prefs.getInt('tasabehcount') ?? 0;
    });
  }

  Future<void> _saveCounts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', counter);
    await prefs.setInt('tasabehcount', tasabehcount);
  }

  Future<void> _playSound() async {
    await player.play(AssetSource('audios/counter100.m4a'), volume: 100);
  }

  void incrementCounter() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
    
    setState(() {
      counter++;
      if (counter % 100 == 0) {
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

  void _showResetConfirmationDialog() {
    final screenSize = MediaQuery.of(context).size;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenSize.width * 0.05),
          ),
          title: Text(
            "Reset Counter",
            style: GoogleFonts.robotoSlab(
              color: Theme.of(context).colorScheme.primary,
              fontSize: screenSize.height * 0.025,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Are you sure you want to reset all counts?",
            style: GoogleFonts.robotoSlab(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
              fontSize: screenSize.height * 0.018,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Cancel",
                style: GoogleFonts.robotoSlab(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: screenSize.height * 0.018,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                clearAll();
                Navigator.of(context).pop();
              },
              child: Text(
                "Reset",
                style: GoogleFonts.robotoSlab(
                  color: Colors.red,
                  fontSize: screenSize.height * 0.018,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: screenSize.height * 0.025,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'المسبحة الالكترونية',
          style: GoogleFonts.robotoSlab(
            color: Theme.of(context).colorScheme.primary,
            fontSize: screenSize.height * 0.025,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Current Count Display
              Container(
                margin: EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.08,
                  vertical: screenSize.height * 0.015,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(screenSize.width * 0.1),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  '$counter',
                  style: GoogleFonts.electrolize(
                    fontSize: screenSize.height * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              
              SizedBox(height: screenSize.height * 0.03),
              
              // Main Counter Button with Animation
              ScaleTransition(
                scale: _scaleAnimation,
                child: GestureDetector(
                  onTap: incrementCounter,
                  child: Container(
                    width: isPortrait 
                        ? screenSize.width * 0.5 
                        : screenSize.height * 0.5,
                    height: isPortrait 
                        ? screenSize.width * 0.5 
                        : screenSize.height * 0.5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
                          blurRadius: 15,
                          spreadRadius: 2,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Tap',
                        style: GoogleFonts.robotoSlab(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: screenSize.height * 0.025,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: screenSize.height * 0.04),
              
              // Control Buttons Row
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Save Button
                    ElevatedButton(
                      onPressed: clear,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenSize.width * 0.03),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05,
                          vertical: screenSize.height * 0.015,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.restart_alt_rounded, 
                            color: Theme.of(context).colorScheme.inversePrimary, 
                            size: screenSize.height * 0.02,
                          ),
                          SizedBox(width: screenSize.width * 0.02),
                          Text(
                            'Reset',
                            style: GoogleFonts.robotoSlab(
                              color: Theme.of(context).colorScheme.inversePrimary,
                              fontSize: screenSize.height * 0.018,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Total Count Display
                    GestureDetector(
                      onTap: _showResetConfirmationDialog,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05,
                          vertical: screenSize.height * 0.015,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(screenSize.width * 0.03),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.calculate,
                              color: Theme.of(context).colorScheme.primary,
                              size: screenSize.height * 0.02,
                            ),
                            SizedBox(width: screenSize.width * 0.02),
                            Text(
                              'Total: $tasabehcount',
                              style: GoogleFonts.robotoSlab(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: screenSize.height * 0.018,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}