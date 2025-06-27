import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final nameController = TextEditingController();
  final messageController = TextEditingController();

  void sendReport() async {
    final name = nameController.text.trim();
    final message = messageController.text.trim();

    if (name.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    await FirebaseFirestore.instance.collection('report').add({
      'name': name,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Message sent successfully!')),
    );

    nameController.clear();
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us & Report" ,style: TextStyle( color: Theme.of(context).colorScheme.primary),),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new_outlined , color: Theme.of(context).colorScheme.primary,) ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 🌟 Contact Info Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 3,
              color: Theme.of(context).colorScheme.primary.withOpacity(.10),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Contact Info", style: TextStyle(fontSize: 23, color:Theme.of(context).colorScheme.primary )),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.email, color: Colors.deepPurple),
                        const SizedBox(width: 10),
                        Text('ozaatreh10@gmail.com', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset("assets/icons/insta_icon.png", height: 25 , width: 25,),
                        const SizedBox(width: 10),
                        Text('quran', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // 📝 Message Form Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 3,
              color: Theme.of(context).colorScheme.primary.withOpacity(.10),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text("Send Us a Message", style: TextStyle(fontSize: 23, color:Theme.of(context).colorScheme.primary )),
                    const SizedBox(height: 16),
                    TextField(
                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Your Name",
                        labelStyle: TextStyle(color:  Theme.of(context).colorScheme.primary),
                        prefixIcon: Icon(Icons.person_outline ,color: Theme.of(context).colorScheme.primary,),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
                      controller: messageController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: "Your Message",
                        labelStyle: TextStyle(color:  Theme.of(context).colorScheme.primary),
                        prefixIcon: Icon(Icons.message_outlined ,color:  Theme.of(context).colorScheme.primary,),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: sendReport,
                        icon: Icon(Icons.send ,color: Theme.of(context).colorScheme.surface,),
                        label: Text("Send" , style: TextStyle(color: Theme.of(context).colorScheme.surface),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
