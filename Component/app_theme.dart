// import 'package:flutter/material.dart';
// import 'dart:math' ;

// class AppTheme extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Color Changer',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ColorChanger(),
//     );
//   }
// }

// class ColorChanger extends StatefulWidget {
//   @override
//   _ColorChangerState createState() => _ColorChangerState();
// }

// class _ColorChangerState extends State<ColorChanger> {

//     Color color1 = const Color.fromARGB(255, 57, 63, 158);

//   Color themechanger(Color newcolor) {
//     setState(() {
//       color1 = newcolor;
//     });
//     return color1;
//     }
    
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Color Changer'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 200,
//               height: 200,
              
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed:(){},
//               child: Text('Change Color'),
//             ),
//           ],
//         ),
//       )
//       );

//   }
// }
