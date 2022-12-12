import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  _buildBottomBar() {
    return FlashyTabBar(
      selectedIndex: _selectedIndex,
      showElevation: true,
      onItemSelected: (index) => setState(() {
        _selectedIndex = index;
      }),
      items: [
        FlashyTabBarItem(
          icon: Icon(Icons.event),
          title: Text('Events'),
        ),
        FlashyTabBarItem(
          icon: Icon(Icons.search),
          title: Text('Search'),
        ),
        FlashyTabBarItem(
          icon: Icon(Icons.highlight),
          title: Text('Highlights'),
        ),
        FlashyTabBarItem(
          icon: Icon(Icons.settings),
          title: Text('Settings'),
        ),
        FlashyTabBarItem(
          icon: Icon(Icons.settings),
          title: Text('한국어'),
        ),
      ],
    );
  }
}
