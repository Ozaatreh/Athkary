import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _language = 'Arabic';
  bool _darkMode = false;
  double _fontSize = 16;
  bool _enableMorningAthkar = true;
  bool _enableEveningAthkar = true;
  bool _enableSleepAthkar = false;
  bool _showRepetitionCounter = true;
  bool _showExplanation = false;
  TimeOfDay _morningTime = const TimeOfDay(hour: 7, minute: 0);
  TimeOfDay _eveningTime = const TimeOfDay(hour: 17, minute: 0);
  bool _notificationSound = true;
  String _athan = 'Athan 1';
  double _volume = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_rounded)  ,
        color: Theme.of(context).colorScheme.primary, onPressed: () {
          Navigator.pop(context); 
           },),
        title:  Text('الاعدادات' ,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary),),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('General Settings'),
          _buildCard([
            _buildDropdownTile('Language', ['Arabic', 'English'], _language, (val) {
              setState(() => _language = val);
            }),
            _buildSwitchTile('Dark Mode', _darkMode, (val) {
              setState(() => _darkMode = val);
            }),
            _buildSliderTile('Font Size', _fontSize, 12, 24, (val) {
              setState(() => _fontSize = val);
            }),
          ]),

          _buildSectionTitle('Athkar Settings'),
          _buildCard([
            _buildSwitchTile('Enable Morning Athkar', _enableMorningAthkar, (val) {
              setState(() => _enableMorningAthkar = val);
            }),
            _buildSwitchTile('Enable Evening Athkar', _enableEveningAthkar, (val) {
              setState(() => _enableEveningAthkar = val);
            }),
            _buildSwitchTile('Enable Sleep Athkar', _enableSleepAthkar, (val) {
              setState(() => _enableSleepAthkar = val);
            }),
            _buildSwitchTile('Show Repetition Counter', _showRepetitionCounter, (val) {
              setState(() => _showRepetitionCounter = val);
            }),
            _buildSwitchTile('Show Explanation of Athkar', _showExplanation, (val) {
              setState(() => _showExplanation = val);
            }),
          ]),

          _buildSectionTitle('Notifications'),
          _buildCard([
            _buildTimeTile(context, 'Morning Reminder', _morningTime, (picked) {
              setState(() => _morningTime = picked);
            }),
            _buildTimeTile(context, 'Evening Reminder', _eveningTime, (picked) {
              setState(() => _eveningTime = picked);
            }),
            _buildSwitchTile('Enable Notification Sound', _notificationSound, (val) {
              setState(() => _notificationSound = val);
            }),
          ]),

          _buildSectionTitle('Athan Sound'),
          _buildCard([
            _buildDropdownTile('Choose Athan', ['Athan 1', 'Athan 2'], _athan, (val) {
              setState(() => _athan = val);
            }),
            _buildSliderTile('Volume', _volume, 0.0, 1.0, (val) {
              setState(() => _volume = val);
            }),
            _buildButtonTile('Preview Athan', () {}),
          ]),

          _buildSectionTitle('About'),
          _buildCard([
            _buildButtonTile('Contact Us', () {}),
            _buildButtonTile('Rate the App', () {}),
            _buildButtonTile('Share the App', () {}),
          ]),
        ],
      ),
  //     bottomNavigationBar: BottomNavigationBar(
  //       currentIndex: 1,
  //       items: const [
  //         BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
  //         BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  //         BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  //       ],
  //     ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: GoogleFonts.cairo(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title, style: GoogleFonts.cairo(color: Theme.of(context).colorScheme.primary,),),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildSliderTile(String title, double value, double min, double max, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.cairo(color: Theme.of(context).colorScheme.primary,)),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: (max - min).round(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDropdownTile(String title, List<String> options, String selected, ValueChanged<String> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.cairo(color: Theme.of(context).colorScheme.primary,)),
        DropdownButton<String>(
          value: selected,
          items: options.map((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(val , style: TextStyle(color: Theme.of(context).colorScheme.primary,),),
            );
          }).toList(),
          onChanged: (String? newVal) {
            if (newVal != null) onChanged(newVal);
          },
        ),
      ],
    );
  }

  Widget _buildTimeTile(BuildContext context, String title, TimeOfDay time, ValueChanged<TimeOfDay> onChanged) {
    return ListTile(
      title: Text(title, style: GoogleFonts.cairo(color: Theme.of(context).colorScheme.primary,)),
      trailing: Text(time.format(context) , style: TextStyle(color: Theme.of(context).colorScheme.primary,),),
      onTap: () async {
        final pickedTime = await showTimePicker(
          context: context,
          initialTime: time,
        );
        if (pickedTime != null) {
          onChanged(pickedTime);
        }
      },
    );
  }

  Widget _buildButtonTile(String title, VoidCallback onPressed) {
    return ListTile(
      title: Text(title, style: GoogleFonts.cairo(color: Theme.of(context).colorScheme.primary,)),
      trailing:  Icon(Icons.arrow_forward_ios ,color: Theme.of(context).colorScheme.primary,),
      onTap: onPressed,
    );
  }
}