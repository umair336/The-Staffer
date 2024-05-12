// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:TheStafferEmployee/screens/Login/UI/login_form.dart';
import 'package:TheStafferEmployee/screens/profile/Profile_Bloc/bloc/profile_bloc.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:TheStafferEmployee/style/theme.dart' as Style;
import 'dialog_resetpassword.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as s;

class ProfileScreen extends StatefulWidget {
  // const ProfileScreen({ Key? key }) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final password = TextEditingController();
  bool correct = false;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProfileBloc>().add(GetUserProfileDataEvent(password: '', newpassword: '', confirmpassword: ''));
    print('Hellow profile');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return
      Scaffold(
          body:BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if(state is ProfileLoadingState){
                print('profile is loading');
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [CircularProgressIndicator()],
                  ),
                );
              }
              else if(state is ProfileErrorState){
                print('profile data error');
                return Center(
                  child: Column(
                    children: [Text('data not fetch${state.message}')],
                  ),
                );
              }
              if(state is ProfileLoadedState){
                print('profile is loaded');
                return  RefreshIndicator(
          backgroundColor: Colors.white,
          color: const Color.fromRGBO(13, 91, 196, 1),
          //  strokeWidth: 2,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          onRefresh: () async {
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    pageBuilder: (a, b, c) => ProfileScreen(),
                    transitionDuration: const Duration(seconds: 0)));
            return Future.value(false);
          },
          child: CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                hasScrollBody: false,
                child: SingleChildScrollView(
                  child: Column(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 190,
                                  decoration:const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
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
                                      )),
                                  child: Column(
                                    children: [
                                  const SizedBox(
                                        height: 30,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            22, 0, 7, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                          const  Text(
                                              'Profile',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                              ),
                                            ),
                                            IconButton(
                                                icon:const Icon(
                                                  EvaIcons.logOutOutline,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  context.read<ProfileBloc>().add(LogoutButtonPressEvent());
                                                         Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(builder: (context) => LoginForm()),
                                                  );
                                                })
                                          ],
                                        ),
                                      ),
                                     const SizedBox(
                                        height: 18,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            22, 0, 7, 0),
                                        child: Row(
                                          children: [
                                            Container(
                                                child:
                                                state.profileResponse.data.profilePic!=null?
                                                 AvatarView(
                                              radius: 33,
                                              avatarType: AvatarType.CIRCLE,
                                              backgroundColor: Colors.red,
                                              imagePath: state.profileResponse.data.profilePic,
                                              placeHolder: Image.network(
                                                state.profileResponse.data.profilePic,
                                                width: 50,
                                                height: 50,
                                                //fit: BoxFit.cover,
                                              ),
                                            ): 
                                            const Icon(EvaIcons.person,color: Colors.white60,)
                                                ),
                                           const SizedBox(
                                              width: 12,
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .baseline,
                                                textBaseline:
                                                    TextBaseline.alphabetic,
                                                children: [
                                                  Text(
                                                   state.profileResponse.data.employeeName !=null
                                                        ? state.profileResponse.data.employeeName: '',
                                                    style:const TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Nunito Sans',
                                                        color: Colors.white
                                                        //       color: Color.fromRGBO(13, 91, 196, 1),
                                                        ),
                                                  ),
                                                 const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                   state.profileResponse.data.jobPosition !=null
                                                        ? state.profileResponse.data.jobPosition: '',
                                                    style:const TextStyle(
                                                        fontFamily:
                                                            'Nunito Sans',
                                                        // fontWeight: FontWeight.semibold,
                                                        fontSize: 10.0,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                               const SizedBox(
                                  height: 50,
                                ),
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        23, 0, 23, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                          width: 1,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                        const  SizedBox(height: 12),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 50),
                                            child: Column(
                                              //  mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      "images/Union 6@2x.png",
                                                      height:
                                                          size.height * 0.02,
                                                      // fit: BoxFit.cover,
                                                    ),
                                                 const   SizedBox(width: 10),
                                                  const  Text(
                                                      'Phone',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Nunito Sans',
                                                        // fontWeight: FontWeight.semibold,
                                                        fontSize: 10.0,
                                                        color: Color.fromRGBO(
                                                            83, 83, 83, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                               const SizedBox(
                                                  height: 6,
                                                ),
                                                Padding(
                                                  padding:const EdgeInsets.only(
                                                      left: 19),
                                                  child: Text(
                                                    state.profileResponse.data.phone !=null
                                                        ? state.profileResponse.data.phone: '',
                                                    style:const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Nunito Sans',
                                                        color: Color.fromRGBO(
                                                            31, 33, 38, 1)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Divider(
                                            color: Colors.grey.shade200,
                                            thickness: 1,
                                          ),
                                         const SizedBox(height: 12),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 39),
                                            child: Column(
                                              //  mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      "images/003-envelope@2x.png",
                                                      height:
                                                          size.height * 0.02,
                                                      // fit: BoxFit.cover,
                                                    ),
                                                  const  SizedBox(width: 12),
                                                   const Text(
                                                      'Email',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Nunito Sans',
                                                        // fontWeight: FontWeight.semibold,
                                                        fontSize: 10.0,
                                                        color: Color.fromRGBO(
                                                            83, 83, 83, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                               const SizedBox(
                                                  height: 6,
                                                ),
                                                Padding(
                                                  padding:const EdgeInsets.only(
                                                      left: 34),
                                                  child: Text(
                                                   state.profileResponse.data.email !=null
                                                        ? state.profileResponse.data.email: '',
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Nunito Sans',
                                                        color: Color.fromRGBO(
                                                            31, 33, 38, 1)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                         const SizedBox(height: 3),
                                          Divider(
                                            color: Colors.grey.shade200,
                                            thickness: 1,
                                          ),
                                          const SizedBox(height: 12),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 44),
                                            child: Column(
                                              //  mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      "images/001-birthday@2x.png",
                                                      height:
                                                          size.height * 0.02,
                                                      // fit: BoxFit.cover,
                                                    ),
                                                  const  SizedBox(width: 11),
                                                   const Text(
                                                      'Date of Birth',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Nunito Sans',
                                                        // fontWeight: FontWeight.semibold,
                                                        fontSize: 10.0,
                                                        color: Color.fromRGBO(
                                                            83, 83, 83, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                               const SizedBox(
                                                  height: 6,
                                                ),
                                                Padding(
                                                  padding:const EdgeInsets.only(
                                                      left: 26),
                                                  child: Text(
                                                    state.profileResponse.data.dob.toString() !=null
                                                        ? state.profileResponse.data.dob.toString(): ' - - - ',
                                                    style:const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Nunito Sans',
                                                        color: Color.fromRGBO(
                                                            31, 33, 38, 1)),
                                                  ),
                                                
                                                ),
                                              ],
                                            ),
                                          ),
                                         const SizedBox(height: 3),
                                          Divider(
                                            color: Colors.grey.shade200,
                                            thickness: 1,
                                          ),
                                         const SizedBox(height: 12),
                                          correct == false
                                              ? InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      showDialog<void>(
                                                          context: context,
                                                          barrierDismissible:
                                                              false, // user must tap button!
                                                          builder:
                                                              (BuildContext
                                                                  context) {
                                                            return AlertDialog(
                                                                actions: <
                                                                    Widget>[
                                                                  Column(
                                                                    children: [
                                                                     const SizedBox(
                                                                        height:
                                                                            15,
                                                                      ),
                                                                      Padding(
                                                                        padding:const EdgeInsets.fromLTRB(
                                                                            14,
                                                                            0,
                                                                            14,
                                                                            0),
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              password,
                                                                          style:const TextStyle(
                                                                              fontSize: 14.0,
                                                                              color: Color.fromRGBO(83, 83, 83, 1)
                                                                              // fontWeight: FontWeight.bold
                                                                              ),
                                                                          cursorColor:
                                                                              Colors.grey.shade500,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            enabledBorder: OutlineInputBorder(borderSide:  BorderSide(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(5.0)),
                                                                            focusedBorder: OutlineInputBorder(borderSide:  BorderSide(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(5.0)),
                                                                            contentPadding:const EdgeInsets.only(left: 10.0, right: 10.0),
                                                                            labelText: "Enter Password",
                                                                            hintStyle:const TextStyle(fontSize: 12.0, color: Color.fromRGBO(83, 83, 83, 1), fontWeight: FontWeight.w500),
                                                                            labelStyle:const TextStyle(fontSize: 12.0, color: Color.fromRGBO(83, 83, 83, 1), fontWeight: FontWeight.w500),
                                                                          ),
                                                                          obscureText:
                                                                              true,
                                                                        ),
                                                                      ),
                                                                     const SizedBox(
                                                                        height:
                                                                            15,
                                                                      ),
                                                                      Padding(
                                                                        padding:const EdgeInsets.fromLTRB(
                                                                            12,
                                                                            0,
                                                                            12,
                                                                            0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Container(
                                                                                //    margin: EdgeInsets.symmetric(horizontal: 15 ,vertical: 14),
                                                                                //   color: Color.fromRGBO(23, 197, 204, 1),
          
                                                                                child: TextButton(
                                                                                  style: ButtonStyle(
                                                                                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(13, 91, 196, 1)),
                                                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                                      RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(10.0),
                                                                                        //   side: BorderSide(color: Colors.red.shade900),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                        
                                                                                  onPressed: () {
                                                                                    setState(() {
                                                                                      //functionChangepassword();
                                                                                      Navigator.pop(context);
                                                                                    });
                                                                                  },
                                                                                  child:const Text(
                                                                                    'Close',
                                                                                    style: TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontSize: 14.0,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          const  SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            Expanded(
                                                                              child: Container(
                                                                                child: TextButton(
                                                                                    style: ButtonStyle(
                                                                                      backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(13, 91, 196, 1)),
                                                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                                        RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius.circular(10.0),
          
                                                                                          //   side: BorderSide(color: Colors.red.shade900),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    onPressed: () async {
                                                                                      print('dddddddddddd${password.text}');
                                                                                      String curentpassword = password.text;
                                                                                      if (curentpassword != '') {
                                                                                        // print('aaaaaaaaaaaaaaaaaaaaaaaaa');
          
                                                                                        password.clear();
                                                                                        // postRequestSSn(curentpassword);
                                                                                        final s.FlutterSecureStorage storage = new s.FlutterSecureStorage();
                                                                                        final String? token = await storage.read(key: 'token');
          
                                                                                        var urll = 'https://dev5.thestaffer.com/api/admin/get_employee_ssn';
          
                                                                                        Map data = {
                                                                                          'password': curentpassword,
                                                                                        };
                                                                                        //encode Map to JSON
                                                                                        var body = json.encode(data);
          
                                                                                        var response = await http.post(Uri.parse(urll),
                                                                                            headers: {
                                                                                              "Content-Type": "application/json",
                                                                                              'Authorization': 'Bearer $token'
                                                                                            },
                                                                                            body: body);
                                                                                        print("${response.statusCode}");
                                                                                        if (response.statusCode == 200) {
                                                                                          if (response.body.contains('true')) {
                                                                                            // ignore: use_build_context_synchronously
                                                                                            Navigator.pop(context);
                                                                                            setState(() {
                                                                                              correct = true;
                                                                                            });
                                                                                          }
                                                                                          if (response.body.contains('false')) {
                                                                                            // ignore: use_build_context_synchronously
                                                                                            Flushbar(
                                                                                              //   title: 'Hey Ninja',
                                                                                              message: 'Invalid Password',
                                                                                              duration: const Duration(seconds: 3),
                                                                                              backgroundColor: const Color.fromRGBO(183, 14, 105, 1),
                                                                                            ).show(context);
                                                                                            // Navigator.pop(context);
                                                                                          }
                                                                                        }
                                                                                        // print(response);
          
                                                                                        print("${response.body}");
                                                                                        return Future.value(response);
                                                                                      }
                                                                                      if (curentpassword == '') {
                                                                                        Flushbar(
                                                                                          //   title: 'Hey Ninja',
                                                                                          message: 'Enter Password',
                                                                                          duration: const Duration(seconds: 3),
                                                                                          backgroundColor: const Color.fromRGBO(183, 14, 105, 1),
                                                                                        ).show(context);
                                                                                      }
                                                                                    },
                                                                                    child: const Text(
                                                                                      'Submit',
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 14.0,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                    )),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ]);
                                                          });
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 40),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          //  mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Image.asset(
                                                                  "images/Union 7@2x.png",
                                                                  height: size
                                                                          .height *
                                                                      0.02,
                                                                  // fit: BoxFit.cover,
                                                                ),
                                                                const SizedBox(
                                                                    width:
                                                                        12),
                                                                const Text(
                                                                  'SSN',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Nunito Sans',
                                                                    // fontWeight: FontWeight.semibold,
                                                                    fontSize:
                                                                        10.0,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            83,
                                                                            83,
                                                                            83,
                                                                            1),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 6,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                          31,
                                                                          0,
                                                                          20,
                                                                          0),
                                                              child: Text(
                                                                state.profileResponse.data
                                                                            .ssn !=
                                                                        null
                                                                    ? '***_**_${state.profileResponse.data.ssn}'
                                                                    : '',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                       FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        'Nunito Sans',
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            31,
                                                                            33,
                                                                            38,
                                                                            1)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 15),
                                                          child: Icon(
                                                            Icons
                                                                .visibility_outlined,
                                                            color: Color
                                                                .fromRGBO(
                                                                    183,
                                                                    14,
                                                                    105,
                                                                    1),
                                                            size: 20,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    //   _showMyDialog();
                                                    setState(() {
                                                      correct = false;
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 40),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          //  mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Image.asset(
                                                                  "images/Union 7@2x.png",
                                                                  height: size
                                                                          .height *
                                                                      0.02,
                                                                  // fit: BoxFit.cover,
                                                                ),
                                                                const SizedBox(
                                                                    width:
                                                                        12),
                                                                const Text(
                                                                  'SSN',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Nunito Sans',
                                                                    // fontWeight: FontWeight.semibold,
                                                                    fontSize:
                                                                        10.0,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            83,
                                                                            83,
                                                                            83,
                                                                            1),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 6,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                          31,
                                                                          0,
                                                                          20,
                                                                          0),
                                                              child: Text(
                                                                state.profileResponse.data
                                                                            .ssn !=
                                                                        null
                                                                    ? '${state.profileResponse.data.ssn}'
                                                                    : '',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        'Nunito Sans',
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            31,
                                                                            33,
                                                                            38,
                                                                            1)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 15),
                                                          child: Icon(
                                                            Icons
                                                                .visibility_off_outlined,
                                                            color: Color
                                                                .fromRGBO(
                                                                    183,
                                                                    14,
                                                                    105,
                                                                    1),
                                                            size: 20,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                          const SizedBox(height: 3),
                                          Divider(
                                            color: Colors.grey.shade200,
                                            thickness: 1,
                                          ),
                                          const SizedBox(height: 12),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 48),
                                            child: Column(
                                              //  mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      "images/placeholder@2x.png",
                                                      height:
                                                          size.height * 0.02,
                                                      // fit: BoxFit.cover,
                                                    ),
                                                    const SizedBox(width: 13),
                                                    const Text(
                                                      'Location',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Nunito Sans',
                                                        // fontWeight: FontWeight.semibold,
                                                        fontSize: 10.0,
                                                        color: Color.fromRGBO(
                                                            83, 83, 83, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 24),
                                                  child: Text(
                                                    state.profileResponse.data.location !=null
                                                        ? state.profileResponse.data.location: '',
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Nunito Sans',
                                                        color: Color.fromRGBO(
                                                            31, 33, 38, 1)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Divider(
                                            color: Colors.grey.shade200,
                                            thickness: 1,
                                          ),
                                          const SizedBox(height: 12),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 44),
                                            child: Column(
                                              //  mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      "images/rotation-lock@2x.png",
                                                      height:
                                                          size.height * 0.02,
                                                      // fit: BoxFit.cover,
                                                    ),
                                                    const SizedBox(width: 12),
                                                    const Text(
                                                      'Change Password',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Nunito Sans',
                                                        // fontWeight: FontWeight.semibold,
                                                        fontSize: 10.0,
                                                        color: Color.fromRGBO(
                                                            83, 83, 83, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 29),
                                                  child: Container(
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          showDialog(
                                                              context:
                                                                  context,
                                                              builder: (_) {
                                                                return MyDialog();
                                                              });
                                                        });
                                                      },
                                                      child: const Text(
                                                        'Reset Password',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Nunito Sans',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12.0,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          color:
                                                              Color.fromRGBO(
                                                                  13,
                                                                  91,
                                                                  196,
                                                                  1),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                        ],
                                      ),
                                    )),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ],
                        )
                ),
              ),
            ],
          ),
                    );
              }
              return Container();
            },
          )
          );
    
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          //   title: Text('AlertDialog '),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                  child: TextFormField(
                    controller: password,
                    style: const TextStyle(
                        fontSize: 14.0, color: Color.fromRGBO(83, 83, 83, 1)
                        // fontWeight: FontWeight.bold
                        ),
                    cursorColor: Colors.grey.shade500,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                               BorderSide(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(5.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                               BorderSide(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(5.0)),
                      contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      labelText: "Enter Password",
                      hintStyle: const TextStyle(
                          fontSize: 12.0,
                          color: Color.fromRGBO(83, 83, 83, 1),
                          fontWeight: FontWeight.w500),
                      labelStyle: const TextStyle(
                          fontSize: 12.0,
                          color: Color.fromRGBO(83, 83, 83, 1),
                          fontWeight: FontWeight.w500),
                    ),
                    obscureText: true,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(13, 91, 196, 1)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        onPressed: () {

                          setState(() {
                            //functionChangepassword();
                            Navigator.pop(context);
                          });
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(13, 91, 196, 1)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        onPressed: () {

                          functionShowSSN();
                        },
                        child:const  Text(
                          'Save',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  functionShowSSN() {
    print('dddddddddddd${password.text}');
    String curentpassword = password.text;
    if (curentpassword != '') {
      print('aaaaaaaaaaaaaaaaaaaaaaaaa');
      password.clear();
      postRequestSSn(curentpassword);
    } else {
      Flushbar(
        //   title: 'Hey Ninja',
        message: 'Enter password',
        duration: const Duration(seconds: 3),
        backgroundColor: const Color.fromRGBO(183, 14, 105, 1),
      ).show(context);
    }
  }

  Future<http.Response> postRequestSSn(String curentp) async {
    print('ssssssssssssssssssssssssssss$curentp');
    final s.FlutterSecureStorage storage =  s.FlutterSecureStorage();
    final String? token = await storage.read(key: 'token');
    String? authorization = token;
    var urll = 'https://dev5.thestaffer.com/api/admin/get_employee_ssn';

    Map data = {
      'password': curentp,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(urll),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $authorization'
        },
        body: body);
    print("${response.statusCode}");
    if (response.statusCode == 200) {
      if (response.body.contains('true')) {
        Navigator.pop(context);
        print('uuuuuuuuuuuuuuuuuuuuuu');
        setState(() {
          correct = true;
        });
      }
      if (response.body.contains('false')) {
        print('uuuuuuuuuuuuuuuuuuuuuu');
        Flushbar(
          //   title: 'Hey Ninja',
          message: 'Invalid Password',
          duration: const Duration(seconds: 3),
          backgroundColor: const Color.fromRGBO(183, 14, 105, 1),
        ).show(context);
      }
    }

    print("${response.body}");
    return response;
  }
}

