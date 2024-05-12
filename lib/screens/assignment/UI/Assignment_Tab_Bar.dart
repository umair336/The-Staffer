import 'package:flutter/material.dart';
import 'activeAssignment.dart';
import 'upcomingAssignment.dart';
import 'pastAssignment.dart';

class AssignmentScreen extends StatefulWidget {

  @override
  _AssignmentScreenState createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignments',
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
        appBar: AppBar(
            title:const  Text('Assignments'),
            flexibleSpace: Container(
              decoration:const  BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [
                  0.1,
                  0.5,
                ],
                colors: [
                  Color.fromRGBO(0, 91, 196, 1),
                  Color.fromRGBO(97, 29, 165, 1),
                ],
              ),
                  ),
            ),
            bottom:const  TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'Active'),
                Tab(text: 'Upcoming'),
                Tab(text: 'Finished'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Activeassignment(),
              Upcomingassignment(),
              PastAssignment()
            ],
          ),
        ),
      ),
    );
  }
}
