import 'package:athkar_app/pages/athkar_alsabah.dart';
import 'package:athkar_app/pages/tasabeh.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  // final IconData icon;
  // final String title;
  // final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Container(
             
             width:  MediaQuery.of(context).size.width /2 ,
              color: const Color.fromARGB(255, 85, 82, 82),
              child: Column(
                      children: [
              SizedBox(height: 15,),
               Container(
                height: 120,width: 120, 
                    decoration: const 
                    BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(image: AssetImage("assets/images/App_icon.png"))    
                             ) ,
               ),
             
              SizedBox(height:5,),

               Divider(height: 10, color: const Color.fromARGB(255, 255, 254, 254), thickness: 1,),

               SizedBox(height: 25,),          
              TextButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                               builder: ((context) =>  Tasabeh() ),),);},
                icon: Icon(Icons.mosque,color:Colors.white),
                label: Text(
                  "تسابيح",
                  style: GoogleFonts.amiri(
                    color: Color.fromARGB(255, 220, 213, 213),
                    textStyle: const TextStyle(fontSize: 19),
                  ),
                ),
              ),
              SizedBox(height: 25,),

              TextButton.icon(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(
                              //  builder: ((context) =>  AthkarAlsabah() ),),);
                },
                icon: Icon(Icons.mosque_outlined,color:Colors.white),
                label: Text(
                  "اذكار الصباح",
                  style: GoogleFonts.amiri(
                    color: const Color.fromARGB(255, 255, 253, 253),
                    textStyle: const TextStyle(fontSize: 19),
                  ),
                ),
              ),
              SizedBox(height: 25,),

              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.mosque_sharp,color:Colors.white),
                label: Text(
                  "اذكار المساء",
                  style: GoogleFonts.amiri(
                    color: const Color.fromARGB(255, 255, 253, 253),
                    textStyle: const TextStyle(fontSize: 19),
                  ),
                ),
              ),
              SizedBox(height: 25,),

              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.mode_night_sharp ,color:Colors.white),
                label: Text(
                  "Soon..",
                  style: GoogleFonts.amiri(
                    color: const Color.fromARGB(255, 255, 253, 253),
                    textStyle: const TextStyle(fontSize: 19),
                  ),
                ),
              ),
                      ],
                    ),
            
      ),
    );
  }
}
