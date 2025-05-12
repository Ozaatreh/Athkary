import 'package:athkary/Component/qiblah_compass.dart';
import 'package:athkary/pages/quran/quran_page.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AthanPopup extends StatefulWidget {
  final String prayerName;
  final String prayerTime;
  final String athanSoundPath;
  
  const AthanPopup({
    super.key,
    required this.prayerName,
    required this.prayerTime,
    required this.athanSoundPath,
  });

  @override
  State<AthanPopup> createState() => _AthanPopupState();
}

class _AthanPopupState extends State<AthanPopup> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playAthan();
  }

  void _playAthan() async {
  await _audioPlayer.play(AssetSource(widget.athanSoundPath));
}


  void _stopAthanAndClose() async {
    await _audioPlayer.stop();
    if (mounted) Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Stack(
        children: [
          // Background image covers full screen
          SizedBox.expand(
            child: Image.asset(
              'assets/images/mekah2.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.prayerTime,
                  style: const TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.prayerName,
                  style: const TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _stopAthanAndClose,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("Pray now", style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNavigationButton("Quran", Icons.book, () async {
                      await _audioPlayer.stop();
                      Navigator.of(context).pop();
                      Future.delayed(const Duration(milliseconds: 200), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  QuranPartsScreen()),
                        );
                      });
                    }),
                    const SizedBox(width: 20),
                    _buildNavigationButton("Qibla", Icons.explore, () async {
                      await _audioPlayer.stop();
                      Navigator.of(context).pop();
                      Future.delayed(const Duration(milliseconds: 200), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const QiblahScreen()),
                        );
                      });
                    }),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: _stopAthanAndClose,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButton(String title, IconData icon, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white),
      label: Text(title, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black.withOpacity(0.6),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
