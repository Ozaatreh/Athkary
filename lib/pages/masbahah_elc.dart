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
    
    // Initialize animation controller first
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    
    // Then initialize the scale animation that depends on the controller
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "Reset Counter",
            style: GoogleFonts.robotoSlab(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Are you sure you want to reset all counts?",
            style: GoogleFonts.robotoSlab(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Cancel",
                style: GoogleFonts.robotoSlab(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
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
                  fontSize: 16,
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
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'المسبحة الالكترونية',
          style: GoogleFonts.robotoSlab(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Current Count Display
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                '$counter',
                style: GoogleFonts.electrolize(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Main Counter Button with Animation
            ScaleTransition(
              scale: _scaleAnimation,
              child: GestureDetector(
                onTap: incrementCounter,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
                        blurRadius: 15,
                        spreadRadius: 2,
                        offset: const Offset(0, 5), ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Tap',
                      style: GoogleFonts.robotoSlab(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Control Buttons Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Save Button
                  ElevatedButton(
                    onPressed: clear,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.restart_alt_rounded, color: Theme.of(context).colorScheme.inversePrimary, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Reset',
                          style: GoogleFonts.robotoSlab(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Total Count Display
                  GestureDetector(
                    onTap: _showResetConfirmationDialog,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
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
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Total: $tasabehcount',
                            style: GoogleFonts.robotoSlab(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}