import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatelessWidget {
  final String name;
  final String meaning;

  const DetailPage({super.key, required this.name, required this.meaning});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        backgroundColor: const Color.fromARGB(255, 32, 31, 31),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () {
                  Navigator.pop(context);
                          },
                           ),
                ],
              ),
              SizedBox(height: 100,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: const Color.fromARGB(255, 78, 79, 79),
                  child: Column(
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.reemKufi(
                          fontSize: 40,
                          color:const Color.fromARGB(255, 245, 223, 82), 
                          // const Color.fromARGB(255, 158, 26, 26),
                        ),
                      ),
                      SizedBox(height: 35,),
                      
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          meaning,
                          style: GoogleFonts.amiri(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                     const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}