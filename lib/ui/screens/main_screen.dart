import 'dart:ui';

import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  List<Widget> tabItems = [
    Center(
      child: Text(
        "Home",
        style: TextStyle(color: Colors.black),
      ),
    ),
    Center(
      child: Text("Camera"),
    ),
    Center(
      child: Text("Profile"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  _buildBody() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          color: Colors.amber,
        ),
        Container(
          color: Colors.red,
          child: tabItems[_selectedIndex],
        ),
      ],
    );
  }

  _buildBottomBar() {
    return FlashyTabBar(
      backgroundColor: Colors.white,
      selectedIndex: _selectedIndex,
      showElevation: true,
      onItemSelected: (index) => setState(
        () {
          _selectedIndex = index;
        },
      ),
      items: [
        FlashyTabBarItem(
          icon: const Icon(Icons.home),
          title: const Text('Home'),
        ),
        FlashyTabBarItem(
          icon: const Icon(Icons.camera_alt),
          title: const Text('Camera'),
        ),
        FlashyTabBarItem(
          icon: const Icon(Icons.group),
          title: const Text('Profile'),
        ),
      ],
    );
  }
}
