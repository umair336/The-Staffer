
import 'package:TheStafferEmployee/screens/home/UI/bottum_navigationn_bar.dart';
import 'package:flutter/material.dart';
import 'dart:ffi';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Bottum_navi_bar_screen(),
    );
  }
}

