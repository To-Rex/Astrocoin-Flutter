
import 'package:astro_coin/search_user.dart';
import 'package:astro_coin/settingspage.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class SamplePage extends StatefulWidget {
  const SamplePage({Key? key}) : super(key: key);

  @override
  _samplepage createState() => _samplepage();
}

class _samplepage extends State<SamplePage>{
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SearchUser(),
    SettingsPage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 10),
      body: Column(
        children: [
          _widgetOptions.elementAt(_selectedIndex),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image(image:  AssetImage('assets/images/samuser.png'),
                width: 30,
                height: 30,
              ),

            label: 'Sample',
          ),
          BottomNavigationBarItem(
            icon: Image(image:  AssetImage('assets/images/samsearchuser.png'),
                width: 30,
                height: 30,
              ),
            label: 'Search user',
          ),
          BottomNavigationBarItem(
            icon: Image(image:  AssetImage('assets/images/samsettings.png'),
                width: 30,
                height: 30,
              ),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}