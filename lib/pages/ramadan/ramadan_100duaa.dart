// import 'dart:async';
// import 'dart:io';

// import 'package:athkary/pages/quran/quran_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class DuaaPdfViewerScreen extends StatefulWidget {
//   final String pdfPath;
//   final int startPage;

//   const DuaaPdfViewerScreen({
//     Key? key,
//     required this.pdfPath,
//     this.startPage = 1,
//   }) : super(key: key);

//   @override
//   _DuaaPdfViewerScreenState createState() => _DuaaPdfViewerScreenState();
// }

// class _DuaaPdfViewerScreenState extends State<DuaaPdfViewerScreen> {
//   late PDFViewController _pdfViewController;
//   int pages = 0;
//   int currentPage = 0;
//   bool isReady = false;
//   String? localPath;
//   bool isNightMode = false;
//   bool isReloading = false;
//   bool isAppBarVisible = true;
//   Timer? _appBarTimer;
//   final TextEditingController _pageController = TextEditingController();
//   bool isHorizontalScroll = false;

//   @override
//   void initState() {
//     super.initState();
//     currentPage = widget.startPage - 1; // Initialize currentPage to the startPage
//     loadPdf();
//     _loadSettings();
//   }

//   Future<void> _loadSettings() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       isNightMode = prefs.getBool('isNightMode') ?? false;
//       isHorizontalScroll = prefs.getBool('isHorizontalScroll') ?? true;
//     });
//   }

//   @override
//   void dispose() {
//     _appBarTimer?.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }

//   void onPageChanged(int? page, int? total) async {
//     setState(() {
//       currentPage = page!;
//       _pageController.text = (page + 1).toString();
//     });
//   }

//   Future<void> loadPdf() async {
//     setState(() {
//       isReloading = true;
//     });

//     final tempDir = await getTemporaryDirectory();
//     final tempFilePath = '${tempDir.path}يا باغي الدعاء.pdf';
//     final file = File(tempFilePath);

//     if (!await file.exists()) {
//       final assetPath = widget.pdfPath;
//       final bytes = await rootBundle.load(assetPath);
//       await file.writeAsBytes(bytes.buffer.asUint8List());
//     }

//     setState(() {
//       localPath = tempFilePath;
//       isReloading = false;
//     });

//     // Restore the current page after the PDF is reloaded
//     _pdfViewController.setPage(currentPage);
//   }

//   void toggleNightMode() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       isNightMode = !isNightMode;
//       localPath = null; // Force reload the PDFView
//     });
//     await prefs.setBool('isNightMode', isNightMode);
//     loadPdf();
//   }

//   void toggleScrollDirection() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       isHorizontalScroll = !isHorizontalScroll;
//     });
//     await prefs.setBool('isHorizontalScroll', isHorizontalScroll);
//   }

//   void goToPage(String pageNumber) {
//     final page = int.tryParse(pageNumber);
//     if (page != null && page >= 1 && page <= pages) {
//       _pdfViewController.setPage(page - 1);
//       setState(() {
//         currentPage = page - 1;
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Invalid page number. Please enter a number between 1 and $pages.'),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//            Navigator.pop(context);
//           },
//           icon: Icon(
//             color: isNightMode ?Colors.white : Colors.black  ,
//             Icons.arrow_back_ios_new_sharp,
//             size: 25,
//           ),
//         ),
//         backgroundColor: isNightMode ? Colors.black : Colors.white,
//         centerTitle: true,
//         title: Text(
//          "١٠٠   دعاء",
//           style: GoogleFonts.amiri(color: isNightMode ? Colors.white: Colors.black ,
//            fontSize: 19 ,  fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           // Scroll Direction Toggle
//           IconButton(
//             icon: Icon(
//               isHorizontalScroll ? Icons.swipe_vertical_outlined : Icons.swipe_left_outlined,
//               color: isNightMode ?Colors.white : Colors.black  ,
//             ),
//             onPressed: toggleScrollDirection,
//           ),
//           // Page Number Input
//           Container(
//             width: 50,
//             height: 30,
//             margin: EdgeInsets.only(right: 10),
//             decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.primary,
//               border: Border.all(color: Theme.of(context).colorScheme.inversePrimary),
//               borderRadius: BorderRadius.circular(3),
//             ),
//             child: TextField(
//               style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
//               controller: _pageController,
//               textAlign: TextAlign.center,
//               keyboardType: TextInputType.number,
//               maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 hintText: 'Page',
//                 contentPadding: EdgeInsets.only(bottom: 10),
//               ),
//               onSubmitted: (value) {
//                 goToPage(value);
//               },
//             ),
//           ),
//           // Night Mode Toggle
//           IconButton(
//             icon: isNightMode
//                 ? Lottie.asset(
//                     'assets/animations/wired-outline-1958-sun-hover-pinch.json',
//                     width: 40,
//                     height: 50,
//                     fit: BoxFit.fill,
//                     animate: true,
//                     reverse: true,
//                     repeat: true,
//                   )
//                 : Lottie.asset(
//                     'assets/animations/wired-lineal-1821-night-sky-moon-stars-hover-pinch.json',
//                     width: 40,
//                     height: 50,
//                     fit: BoxFit.fill,
//                     animate: true,
//                     repeat: true,
//                   ),
//             onPressed: toggleNightMode,
//           ),
//         ],
//       ),
//       body: GestureDetector(
//         child: isReloading
//             ? Center(
//                 child: Lottie.asset(
//                   'assets/animations/wired-outline-1414-circle-hover-pinch.json',
//                   width: 40,
//                   height: 40,
//                   fit: BoxFit.fill,
//                   animate: true,
//                   repeat: true,
//                 ),
//               )
//             : localPath != null
//                 ? PDFView(
//                     key: ValueKey('pdfview_${isNightMode}_${isHorizontalScroll}_$localPath'),
//                     defaultPage: currentPage,
//                     filePath: localPath,
//                     autoSpacing: true,
//                     // fitPolicy: FitPolicy.HEIGHT,
//                     enableSwipe: true,
//                     pageSnap: true,
//                     swipeHorizontal: isHorizontalScroll,
//                     fitEachPage: true,
//                     nightMode: isNightMode,
//                     onRender: (pages) {
//                       setState(() {
//                         this.pages = pages!;
//                         isReady = true;
//                       });
//                     },
//                     onViewCreated: (PDFViewController pdfViewController) {
//                       _pdfViewController = pdfViewController;
//                       _pdfViewController.setPage(currentPage);
//                     },
//                     onPageChanged: onPageChanged,
//                     onError: (error) {
//                       print(error.toString());
//                     },
//                   )
//                 : Center(
//                     child: CircularProgressIndicator(),
//                   ),
//       ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.only(left: 20.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             IconButton(
//               icon: Icon(Icons.arrow_back, color: isNightMode ? Colors.white : Colors.black),
//               onPressed: () {
//                 if (currentPage > 0) {
//                   _pdfViewController.setPage(currentPage - 1);
//                 }
//               },
//             ),
//             IconButton(
//               icon: Icon(Icons.arrow_forward, color: isNightMode ? Colors.white : Colors.black),
//               onPressed: () {
//                 if (currentPage < pages - 1) {
//                   _pdfViewController.setPage(currentPage + 1);
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }