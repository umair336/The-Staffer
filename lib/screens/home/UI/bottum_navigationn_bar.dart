import 'package:TheStafferEmployee/screens/home/UI/Home_Screen.dart';
import 'package:TheStafferEmployee/screens/profile/UI/profile_screen.dart';
import 'package:TheStafferEmployee/screens/timesheet/UI/timesheet_screen.dart';
import 'package:flutter/material.dart';
import 'package:TheStafferEmployee/style/theme.dart' as Style;
import '../../assignment/UI/Assignment_Tab_Bar.dart';


class Bottum_navi_bar_screen extends StatefulWidget {
  const Bottum_navi_bar_screen({ Key? key }) : super(key: key);

  @override
  _Bottum_navi_bar_screenState createState() => _Bottum_navi_bar_screenState();
}

class _Bottum_navi_bar_screenState extends State<Bottum_navi_bar_screen> {
  int _selectedIndex = 0;
   late List<Widget> screens = <Widget>[
     const HomeScreen(),
    TimesheetScreen(),
    AssignmentScreen(),
    ProfileScreen(),
  ];
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex=index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body:screens.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.white),
              BottomNavigationBarItem(
                  icon: Icon(Icons.lock_clock),
                  label: 'Time Sheet',
                  backgroundColor: Style.Colors.mainColor),
              BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Assignment',
                  backgroundColor: Style.Colors.mainColor),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                  backgroundColor: Style.Colors.mainColor),
            ],
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Color.fromRGBO(83, 83, 83, 1),
            selectedItemColor: Color.fromRGBO(183, 14, 105, 1),
            currentIndex: _selectedIndex,
            iconSize: 25,
            onTap: _onItemTapped,
            elevation: 4),
         );
  }
}
