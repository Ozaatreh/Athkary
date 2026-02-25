class AudiosFiles {


  static const String _cloudBaseUrl =
      'https://ykvcjhxfyodririeyqiw.supabase.co/storage/v1/object/public/Audios';

  static const List<String?> _cloudMorningFileNames = [
     'Iklas.mp3',      // 0: سورة الإخلاص
     'Alfalaq.mp3',        // 1: سورة الفلق
    'Alnaas.mp3', 
    "Alahm eny asalk elman nafeaa.mp3", // 3
    "Astaghfirullaha w Atoob elaeh.mp3", // 4
    null, // 5: بسم الله الذي لا يضر...
    "Alahm Alem algyb w alsh'hadah Fater alsmawat.mp3", // 6
    "Subhan Alah W bihamdeh Adada Khlkeh.mp3", // 7
    "Allahumma A'udhu Bika Min Al-Kufr.mp3", // 8
    null, // 9: رضيت بالله رباً
    "Subhan Allah Wa Bi Hamdihi.mp3", // 10
    "Ya hy ya qaium.mp3", // 11
    "Asbahna w asbaha almulk llah rub.mp3", // 12
    "Alahm eny asbaht oush'hedouka.mp3", // 13
    "Allahumma Anta Rabbi La Ilaha Illa Ant.mp3", // 14
    null, // 15: اللهم ما أصبح بي من نعمة
    "La Ilaha Illa Allah Wahdahu.mp3", // 16
  ];

  static const List<String?> _cloudEveningFileNames = [
     'Iklas.mp3',      // 0: سورة الإخلاص
     'Alfalaq.mp3',        // 1: سورة الفلق
    'Alnaas.mp3', 
    "Alahm eny asalk elman nafeaa.mp3", // 3
    "Astaghfirullaha w Atoob elaeh.mp3", // 4
    null, // 5: بسم الله الذي لا يضر...
    "Alahm Alem algyb w alsh'hadah Fater alsmawat.mp3", // 6
    "Subhan Alah W bihamdeh Adada Khlkeh.mp3", // 7
    null, // 8: رضيت بالله رباً
    "Subhan Allah Wa Bi Hamdihi.mp3", // 9
    "Ya hy ya qaium.mp3", // 10
    "Asbahna w asbaha almulk.mp3", // 11: أمسينا وأمسى الملك
    "Alahm eny asbaht oush'hedouka.mp3", // 12: اللهم إني أمسيت أشهدك
    "Allahumma Anta Rabbi La Ilaha Illa Ant.mp3", // 13
    null, // 14: اللهم ما أمسى بي من نعمة
    "La Ilaha Illa Allah Wahdahu.mp3", // 15
  ];

  static String? cloudAudioUrlFromFileName(String? fileName) {
    if (fileName == null || fileName.isEmpty) return null;
    return '$_cloudBaseUrl/${Uri.encodeComponent(fileName)}';
  }

  static String? cloudAudioUrlForMorning(int index) {
    if (index < 0 || index >= _cloudMorningFileNames.length) return null;
    return cloudAudioUrlFromFileName(_cloudMorningFileNames[index]);
  }

  static String? cloudAudioUrlForEvening(int index) {
    if (index < 0 || index >= _cloudEveningFileNames.length) return null;
    return cloudAudioUrlFromFileName(_cloudEveningFileNames[index]);
  }

 static const List<String?> audioFiles = [
  'audio_athkar/سورة الإخلاص.mp3',      // 0: سورة الإخلاص
  'audio_athkar/سورة الفلق.mp3',        // 1: سورة الفلق
  'audio_athkar/سورة الناس.mp3',        // 2: سورة الناس
  'audio_athkar/a19.mp3',               // 3: اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْماً نَافِعاً...
  'audio_athkar/a2.mp3',                // 4: أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ
  'audio_athkar/a3.mp3',                // 5: بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ...
  'audio_athkar/a4.mp3',                // 6: اللَّهُمَّ عَالِمَ الْغَيْبِ وَالشَّهَادَةِ...
  'audio_athkar/a5.mp3',                // 7: سُبْحَانَ اللَّهِ وَبِحَمْدِهِ عَدَدَ خَلْقِهِ...
  'audio_athkar/a6.mp3',                // 8: اللّهُمَّ إِنّي أَعوذُ بِكَ مِنَ الْكُفر...
  'audio_athkar/a10.mp3',               // 9: رَضِيتُ باللَّهِ رَبًّا... (Note: a10 is سبحان الله وبحمده)
  'audio_athkar/a10.mp3',               // 10: سُبْحَانَ اللَّهِ وَبِحَمْدِهِ
  'audio_athkar/a8.mp3',                // 11: يَاحَيُّ، يَا قَيُّومُ...
  'audio_athkar/a9.mp3',                // 12: أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ...
  'audio_athkar/a20.mp3',               // 13: اللَّهُمَّ إِنِّي أَصْبَحْتُ أُشْهِدُكَ...
  'audio_athkar/a17.mp3',               // 14: اللَّهُمَّ أَنْتَ رَبِّي لَّا إِلَهَ إِلَّا أَنْتَ...
  'audio_athkar/a15.mp3',               // 15: اللَّهُمَّ مَا أَصْبَحَ بِي مِنْ نِعْمَةٍ...
  'audio_athkar/a13.mp3',               // 16: لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ...
];

static const List<String?> audioFiles2 = [
  'audio_athkar/سورة الإخلاص.mp3',      // 0: سورة الإخلاص
  'audio_athkar/سورة الفلق.mp3',        // 1: سورة الفلق
  'audio_athkar/سورة الناس.mp3',        // 2: سورة الناس
  'audio_athkar/a19.mp3',               // 3: اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْماً نَافِعاً...
  'audio_athkar/a2.mp3',                // 4: أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ
  'audio_athkar/a3.mp3',                // 5: بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ...
  'audio_athkar/a4.mp3',                // 6: اللَّهُمَّ عَالِمَ الْغَيْبِ وَالشَّهَادَةِ...
  'audio_athkar/a5.mp3',                // 7: سُبْحَانَ اللَّهِ وَبِحَمْدِهِ عَدَدَ خَلْقِهِ...
  'audio_athkar/a10.mp3',               // 8: رَضِيتُ باللَّهِ رَبًّا... (Note: May need separate file)
  'audio_athkar/a10.mp3',               // 9: سُبْحَانَ اللَّهِ وَبِحَمْدِهِ
  'audio_athkar/a8.mp3',                // 10: يَاحَيُّ، يَا قَيُّومُ...
  'audio_athkar/e11.mp3',               // 11: أَمْسَيْنَا... (evening version - need new recording)
  'audio_athkar/e12.mp3',               // 12: اللَّهُمَّ إِنِّي أَمْسَيْتُ... (evening version)
  'audio_athkar/a17.mp3',               // 13: اللَّهُمَّ أَنْتَ رَبِّي...
  'audio_athkar/e14.mp3',               // 14: اللَّهُمَّ مَا أَمْسَى بِي... (evening version)
  'audio_athkar/a13.mp3',               // 15: لَا إِلَهَ إِلَّا اللَّهُ...
];

}