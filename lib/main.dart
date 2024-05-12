import 'dart:async';
import 'package:TheStafferEmployee/screens/Login/UI/intro_screen.dart';
import 'package:TheStafferEmployee/screens/Login/login_bloc/login_bloc.dart';
import 'package:TheStafferEmployee/screens/assignment/assignment_bloc/bloc/assignment_bloc.dart';
import 'package:TheStafferEmployee/screens/home/home_bloc/bloc/home_bloc.dart';
import 'package:TheStafferEmployee/screens/profile/Profile_Bloc/bloc/profile_bloc.dart';
import 'package:TheStafferEmployee/screens/timesheet/TimeSheet_Bloc/bloc/time_sheet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutternding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp( MultiBlocProvider(providers:[
    BlocProvider(
      create: (context)=>LoginBloc()
    ),
   
     BlocProvider(
      create: (context)=>HomeBloc()
    ), 

     BlocProvider(
      create: (context)=>AssignmentBloc()
    ),

      BlocProvider(
      create: (context)=>ProfileBloc()
    ),
     BlocProvider(
      create: (context)=>TimeSheetBloc()
    ),
    ],
    child: MyApp(),)
  );
}
class MyApp extends StatefulWidget {
  const MyApp() : super(key: null);
  @override
  State<MyApp> createState() => MyAppState();
}
class MyAppState extends State<MyApp> {
 static String keyLogin='login';
  var introskip;

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('mn', 'MN'),
      theme: ThemeData(
        fontFamily: 'Rubik',
        primarySwatch: Colors.blueGrey,
      ),
      home: IntroPage());
        }
        
      
  }

