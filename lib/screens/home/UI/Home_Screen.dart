import 'package:TheStafferEmployee/screens/assignment/UI/assignmentdetail.dart';
import 'package:TheStafferEmployee/screens/home/home_bloc/bloc/home_bloc.dart';
import 'package:TheStafferEmployee/screens/main_screen/main_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool hours = true;
    @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetUserHomeDataEvent());
  }                                                                                                                                      
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            if (state is HomeDataLoadingState) {
              print('Home Data Loading');
              return const Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    )
                  ]));
            } else if (state is HomeDataErrorState) {
              print('home data error');
              return Center(
                child: Column(children: [
                  Text('Data not fetch ${state.message}')
                ],),
              );
            } else if (state is HomeDataCompletedstate) {
              print('home data loaded');
              return
                  //  Center(child: Text('Home data loaded'));
                  RefreshIndicator(
                backgroundColor: Colors.white,
                color: Color.fromRGBO(13, 91, 196, 1),
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                onRefresh: () async {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (a, b, c) => MainScreen(),
                          transitionDuration: const Duration(seconds: 0)));
                  return Future.value(false);
                },
                child: CustomScrollView(slivers: <Widget>[
                  SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(children: [
                        Container(
                          child: Stack(
                            children: [
                              Container(
                                  height:
                                      (MediaQuery.of(context).size.height),
                                  width: (MediaQuery.of(context).size.width),
                                  color: Colors.grey.shade100),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 190,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15)),
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
                                ),
                              ),
                              state.homeResponse.data[0].profilePic == null
                                  ? Positioned(
                                      top: 65,
                                      left: 25,
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        child: const Icon(
                                          EvaIcons.person,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Positioned(
                                      top: 65,
                                      left: 25,
                                      child: CircleAvatar(
                                        radius: 23,
                                        backgroundImage: NetworkImage(state.homeResponse.data[0].profilePic)
                                        // placeHolder: Image.network(
                                        //   state.homeResponse.data[0]
                                        //       .profilePic,
                                        //   width: 30,
                                        //   height: 30,
                                        // ),
                                        // avatarType: AvatarType.CIRCLE,
                                        // backgroundColor: Colors.red,
                                        // imagePath: state
                                        //     .homeResponse.data[0].profilePic,
                                        // placeHolder: Image.network(
                                        //   state.homeResponse.data[0]
                                        //       .profilePic,
                                        //   width: 30,
                                        //   height: 30,
                                        // ),
                                      )),
                              const Positioned(
                                top: 70,
                                left: 80,
                                child: Text(
                                  'Welcome',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 90,
                                left: 80,
                                child: Text(state.homeResponse.data.isNotEmpty &&
          state.homeResponse.data.first.assignments.isNotEmpty &&
                                  state.homeResponse.data.first.assignments.first.employeeName != null
                                      ? state.homeResponse.data.first.assignments.first.employeeName
                                      :
                                       'No employee',
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 70,
                                  right: 10,
                                  child: IconButton(
                                      icon: const Icon(
                                        EvaIcons.logOutOutline,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        context.read<HomeBloc>().add(LogoutButtonPressedEvent());

                                        // BlocProvider.of<
                                        //             AuthenticationBloc>(
                                        //         context)
                                        //     .add(
                                        //   LoggedOut(),
                                        // );
                                      })),
                              Positioned(
                                top: 150,
                                left: 20,
                                right: 20,
                                child: Container(
                                  height: 80,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: const Color.fromRGBO(
                                            79, 171, 247, 1),
                                        width: 2,
                                      ),
                                    ),
                                    child: CarouselSlider(
                                      items: [
                                        Padding(
                                          //    padding: const EdgeInsets.all(8.0),
                                          padding: const EdgeInsets.fromLTRB(
                                              2, 0, 2, 13),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.88,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .fromLTRB(0, 5, 10, 0),
                                                  child: Container(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Image.asset(
                                                      "images/Path 54457@2x.png",
                
                                                      height:
                                                          size.height * 0.02,
                                                      // fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            const SizedBox(
                                                              width: 15,
                                                            ),
                                                            Image.asset(
                                                              "images/002-schedule@2x.png",
                                                              height:
                                                                  size.height *
                                                                      0.04,
                
                                                              // fit: BoxFit.cover,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const Text(
                                                                    'Total Hours',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        fontFamily:
                                                                            'Nunito Sans',
                                                                        color: Color.fromRGBO(
                                                                            112,
                                                                            112,
                                                                            112,
                                                                            1)),
                                                                  ),
                                                                  const SizedBox(
                                                                    height:
                                                                       5,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                          child:
                                                                              Text(
                                                                        state.homeResponse.data[0].startDate.toString() != null
                                                                            ?
                                                                        context.read<HomeBloc>().getDateInGoogleFormate(state.homeResponse.data[0].startDate)
                                                                            : ' - - - ',
                                                                        style: const TextStyle(
                                                                            fontSize: 8,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: 'Nunito Sans',
                                                                            color: Color.fromRGBO(13, 91, 196, 1)),
                                                                      )),
                                                                      const SizedBox(
                                                                        width:
                                                                            3,
                                                                      ),
                                                                      const Text(
                                                                        'to',
                                                                        style: TextStyle(
                                                                            fontSize: 7,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: 'Nunito Sans',
                                                                            color: Color.fromRGBO(13, 91, 196, 1)),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            3,
                                                                      ),
                                                                      Container(
                                                                          child:
                                                                              Text(
                                                                        state.homeResponse.data[0].endDate != null
                                                                            ? 
                                                                            context.read<HomeBloc>().getDateInGoogleFormate(state.homeResponse.data[0].endDate.toString())
                                                                            : ' - - - ',
                                                                        style: const TextStyle(
                                                                            fontSize: 8,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: 'Nunito Sans',
                                                                            color: Color.fromRGBO(13, 91, 196, 1)),
                                                                      )),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          width: 120,
                                                          height: 20,
                                                          child: FittedBox(
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .baseline,
                                                              textBaseline:
                                                                  TextBaseline
                                                                      .alphabetic,
                                                              children: [
                                                                AutoSizeText(
                                                                  state
                                                                      .homeResponse
                                                                      .data[0]
                                                                      .totalWeeklyHours
                                                                      .toString(),
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        28,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        'Nunito Sans',
                                                                    //      color: Color.fromRGBO(255, 255, 255, 1)
                                                                  ),
                                                                  maxFontSize:
                                                                      23,
                                                                  minFontSize:
                                                                      15,
                                                                  maxLines: 1,
                                                                ),
                                                                const SizedBox(
                                                                  width: 18,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                      //Slider Container properties
                                      options: CarouselOptions(
                                        reverse: false,
                                        initialPage: 2,
                                        enlargeCenterPage: true,
                                        viewportFraction: 3.0,
                                        enableInfiniteScroll: false,
                                        //      enableInfiniteScroll: true,
                                        //  aspectRatio: 30 / 9,
                                        //    autoPlay: true,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 240,
                                left: 20,
                                right: 20,
                                child: Container(
                                  height: 80,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: const Color.fromRGBO(
                                            79, 171, 247, 1),
                                        width: 2,
                                      ),
                                    ),
                                    child: CarouselSlider(
                                      items: [
                                        Padding(
                                          //    padding: const EdgeInsets.all(8.0),
                                          padding: const EdgeInsets.fromLTRB(
                                              2, 0, 2, 13),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.88,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .fromLTRB(0, 5, 10, 0),
                                                  child: Container(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Image.asset(
                                                      "images/Path 52375@2x.png",
                                                      height:
                                                          size.height * 0.02,
                                                      // fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            const SizedBox(
                                                              width: 15,
                                                            ),
                                                            Image.asset(
                                                              "images/Group 12117@2x.png",
                                                              height:
                                                                  size.height *
                                                                      0.04,
                
                                                              // fit: BoxFit.cover,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const Text(
                                                                    'Earnings',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        fontFamily:
                                                                            'Nunito Sans',
                                                                        color: Color.fromRGBO(
                                                                            112,
                                                                            112,
                                                                            112,
                                                                            1)),
                                                                  ),
                                                                  const SizedBox(
                                                                    height:
                                                                        5,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                          child:
                                                                              Text(
                                                                        state.homeResponse.data[0].prevWeekStart.toString() != null
                                                                            ?context.read<HomeBloc>().getDateInGoogleFormate(state.homeResponse.data[0].startDate)
                                                                            : ' - - - ',
                                                                        style: const TextStyle(
                                                                            fontSize: 8,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: 'Nunito Sans',
                                                                            color: Color.fromRGBO(31, 33, 38, 1)),
                                                                      )),
                                                                      const SizedBox(
                                                                        width:
                                                                            3,
                                                                      ),
                                                                      const Text(
                                                                        'to',
                                                                        style: TextStyle(
                                                                            fontSize: 8,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: 'Nunito Sans',
                                                                            color: Color.fromRGBO(31, 33, 38, 1)),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            3,
                                                                      ),
                                                                      Container(
                                                                          child:
                                                                              Text(
                                                                        state.homeResponse.data[0].prevWeekEnd.toString() != null
                                                                            ? context.read<HomeBloc>().getDateInGoogleFormate(state.homeResponse.data[0].endDate.toString())
                                                                            : ' - - - ',
                                                                        style: const TextStyle(
                                                                            fontSize: 8,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: 'Nunito Sans',
                                                                            color: Color.fromRGBO(31, 33, 38, 1)),
                                                                      )),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          width: 120,
                                                          height: 20,
                                                          child: FittedBox(
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .baseline,
                                                              textBaseline:
                                                                  TextBaseline
                                                                      .alphabetic,
                                                              children: [
                                                                Text(state.formateResponse.data[0].currencyformat
                                                                            .toString()) !=
                                                                        null
                                                                    ? Container(
                                                                        child:
                                                                            AutoSizeText(
                                                                          state.formateResponse.data[0].currencyformat.toString(),
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize: 30,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: 'Nunito Sans',
                                                                            //      color: Color.fromRGBO(255, 255, 255, 1)
                                                                          ),
                                                                          maxFontSize:
                                                                              23,
                                                                          minFontSize:
                                                                              15,
                                                                          maxLines:
                                                                              1,
                                                                        ),
                                                                      )
                                                                    : Container(
                                                                        child:
                                                                            const Text(' ')),
                                                                     Text(
                                                                          state.homeResponse.data[0].prevEarnings.toString(),
                                                                        ) !=
                                                                        null
                                                                    ? Container(
                                                                        child:
                                                                            AutoSizeText(
                                                                          state.homeResponse.data[0].prevEarnings.toString(),
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize: 28,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: 'Nunito Sans',
                                                                            //      color: Color.fromRGBO(255, 255, 255, 1)
                                                                          ),
                                                                          maxFontSize:
                                                                              23,
                                                                          minFontSize:
                                                                              15,
                                                                          maxLines:
                                                                              1,
                                                                        ),
                                                                      )
                                                                    : Container(
                                                                        child: const Text(
                                                                            '0',
                                                                            style: TextStyle(
                                                                              fontSize: 30,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: 'Nunito Sans',
                                                                            ))),
                                                                const SizedBox(
                                                                  width: 18,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          //    padding: const EdgeInsets.all(8.0),
                                          padding: const EdgeInsets.fromLTRB(
                                              2, 0, 2, 13),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.88,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .fromLTRB(0, 5, 10, 0),
                                                  child: Container(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Image.asset(
                                                      "images/Path 54457@2x.png",
                
                                                      height:
                                                          size.height * 0.02,
                                                      // fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            const SizedBox(
                                                              width: 15,
                                                            ),
                                                            Image.asset(
                                                              "images/Group 12117@2x.png",
                                                              height:
                                                                  size.height *
                                                                      0.04,
                
                                                              // fit: BoxFit.cover,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const Text(
                                                                    'Earnings',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        fontFamily:
                                                                            'Nunito Sans',
                                                                        color: Color.fromRGBO(
                                                                            112,
                                                                            112,
                                                                            112,
                                                                            1)),
                                                                  ),
                                                                  const SizedBox(
                                                                    height:
                                                                        5,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                          child:
                                                                              Text(
                                                                        state.homeResponse.data[0].startDate.toString() != null
                                                                            ? context.read<HomeBloc>().getDateInGoogleFormate(state.homeResponse.data[0].startDate)
                                                                            : ' - - - ',
                                                                        style: const TextStyle(
                                                                            fontSize: 8,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: 'Nunito Sans',
                                                                            color: Color.fromRGBO(13, 91, 196, 1)),
                                                                      )),
                                                                      const SizedBox(
                                                                        width:
                                                                            3,
                                                                      ),
                                                                      const Text(
                                                                        'to',
                                                                        style: TextStyle(
                                                                            fontSize: 8,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: 'Nunito Sans',
                                                                            color: Color.fromRGBO(13, 91, 196, 1)),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            3,
                                                                      ),
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          state.homeResponse.data[0].endDate.toString() != null
                                                                              ? context.read<HomeBloc>().getDateInGoogleFormate(state.homeResponse.data[0].startDate)
                                                                              : ' - - - ',
                                                                          style: const TextStyle(
                                                                              fontSize: 8,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: 'Nunito Sans',
                                                                              color: Color.fromRGBO(13, 91, 196, 1)),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          width: 120,
                                                          height: 20,
                                                          child: FittedBox(
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .baseline,
                                                              textBaseline:
                                                                  TextBaseline
                                                                      .alphabetic,
                                                              children: [
                                                                Text(state.formateResponse.data[0].currencyformat
                                                                            .toString()) !=
                                                                        null
                                                                    ? Container(
                                                                        child:
                                                                            AutoSizeText(
                                                                          state.formateResponse.data[0].currencyformat.toString(),
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize: 30,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: 'Nunito Sans',
                                                                          ),
                                                                          maxFontSize:
                                                                              23,
                                                                          minFontSize:
                                                                              15,
                                                                          maxLines:
                                                                              1,
                                                                        ),
                                                                      )
                                                                    : Container(
                                                                        child:
                                                                            const Text(' ')),
                                                                Text(
                                                                          state.homeResponse.data[0].earnings.toString(),
                                                                        ) !=
                                                                        null
                                                                    ? Container(
                                                                        child:
                                                                            AutoSizeText(
                                                                          state.homeResponse.data[0].earnings.toString(),
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize: 30,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontFamily: 'Nunito Sans',
                                                                          ),
                                                                          maxFontSize:
                                                                              23,
                                                                          minFontSize:
                                                                              15,
                                                                          maxLines:
                                                                              1,
                                                                        ),
                                                                      )
                                                                    : Container(
                                                                        child: const Text(
                                                                            '0',
                                                                            style: TextStyle(
                                                                              fontSize: 30,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: 'Nunito Sans',
                                                                            ))),
                                                                const SizedBox(
                                                                  width: 18,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                      //Slider Container properties
                                      options: CarouselOptions(
                                        reverse: false,
                                        initialPage: 2,
                                        enlargeCenterPage: true,
                                        viewportFraction: 3.0,
                                        enableInfiniteScroll: false,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 330,
                                left: 20,
                                right: 20,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Color.fromRGBO(0, 214, 214, 1),
                                        width: 2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          offset: Offset(3.0, 5.0),
                                          blurRadius: 1.0,
                                        )
                                      ]),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 19,
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Image.asset(
                                                    "images/08-shift@2x.png",
                                                    height:
                                                        size.height * 0.05,
                
                                                    // fit: BoxFit.cover,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    child: const Column(
                                                      children: [
                                                        Text(
                                                          'Active Shift Count',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Nunito Sans',
                                                              color: Color
                                                                  .fromRGBO(
                                                                      112,
                                                                      112,
                                                                      112,
                                                                      1)),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              alignment:
                                                  Alignment.centerRight,
                                              width: 120,
                                              height: 20,
                                              child: FittedBox(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .baseline,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    AutoSizeText(
                                                      state.homeResponse.data.first
                                                          .shifts.toString(),
                                                      style: const TextStyle(
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Nunito Sans',
                                                      ),
                                                      maxFontSize: 23,
                                                      minFontSize: 15,
                                                      maxLines: 1,
                                                    ),
                                                    const SizedBox(
                                                      width: 18,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 17,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 420,
                                left: 20,
                                right: 20,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color:
                                            Color.fromRGBO(212, 144, 255, 1),
                                        width: 2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          offset: const Offset(3.0, 5.0),
                                          blurRadius: 1.0,
                                        )
                                      ]),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 19,
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Image.asset(
                                                    "images/Group 12123@2x.png",
                                                    height:
                                                        size.height * 0.05,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    child: const Column(
                                                      children: [
                                                        AutoSizeText(
                                                          'Pending Balance',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Nunito Sans',
                                                              color: Color
                                                                  .fromRGBO(
                                                                      112,
                                                                      112,
                                                                      112,
                                                                      1)),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              alignment:
                                                  Alignment.centerRight,
                                              width: 120,
                                              height: 20,
                                              child: FittedBox(
                                                child: Row(
                                                  children: [
                                                    Text(state
                                                                .formateResponse
                                                                .data[0]
                                                                .currencyformat
                                                                .toString()) !=
                                                            null
                                                        ? Container(
                                                            child:
                                                                AutoSizeText(
                                                              state
                                                                  .formateResponse
                                                                  .data[0]
                                                                  .currencyformat
                                                                  .toString(),
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 30,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Nunito Sans',
                                                              ),
                                                              maxFontSize: 23,
                                                              minFontSize: 15,
                                                              maxLines: 1,
                                                            ),
                                                          )
                                                        : Container(
                                                            child: const Text(
                                                                ' ')),
                                                    AutoSizeText(
                                                      state.homeResponse
                                                          .data[0].pending
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      maxFontSize: 23,
                                                      minFontSize: 15,
                                                      maxLines: 1,
                                                    ),
                                                    const SizedBox(
                                                      width: 18,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                
                                      ////// from here the assignment part starts //////
                
                                      const SizedBox(
                                        height: 17,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 525,
                                  left: 23,
                                  right: 20,
                                  child: Container(
                                    child: const Text(
                                      'Recent Assignments',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Nunito Sans',
                                          color:
                                              Color.fromRGBO(13, 91, 196, 1)),
                                    ),
                                  )),
                              Positioned(
                                top: 570,
                                left: 23,
                                right: 20,
                                child: Container(
                                  height: 100.0,
                                  child: state.homeResponse.data.length == 0
                                      ? const Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Text(
                                            'No Assignment',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Nunito Sans',
                                                color: Color.fromRGBO(
                                                    112, 112, 112, 1)),
                                          ),
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              state.homeResponse.data.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: (() {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Assignmentdetail(
                                                            jobid: 
                                                            state
                                                                .homeResponse
                                                                .data.first.assignments[index]
                                                                .jobId
                                                                ),
                                                  ),
                                                );
                                              }),
                                              child: Card(
                                                elevation: 4.0,
                                                shadowColor: Colors.grey
                                                    .withOpacity(0.2),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .baseline,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    20,
                                                                    0,
                                                                    120,
                                                                    0),
                                                            child: Text(state.homeResponse.data.isNotEmpty &&
                                                              state.homeResponse.data.first.assignments.isNotEmpty &&
                                                              state.homeResponse
                                                                          .data.first.assignments[index]
                                                                          .jobTitle
                                                                          .toString() !=
                                                                      null
                                                                  ? state.homeResponse
                                                                      .data.first.assignments[index]
                                                                      .jobTitle
                                                                  : 
                                                                  '',
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      14,
                                                                  fontFamily:
                                                                      'Nunito Sans',
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          13,
                                                                          91,
                                                                          196,
                                                                          1)),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets
                                                              .only(left: 20),
                                                      child: Text(
                                                         index < state.homeResponse.data.first.assignments.length? 
                                                        state.homeResponse
                                                                .data.first.assignments[index]
                                                                .customerName ?? '':'Recent Assignment Empty',
                                                        style: const TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                            fontFamily:
                                                                'Nunito Sans',
                                                            color: Color
                                                                .fromRGBO(
                                                                    112,
                                                                    112,
                                                                    112,
                                                                    1)),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    Container(
                                                        child: Padding(
                                                      padding:
                                                          const EdgeInsets
                                                              .only(left: 20),
                                                      child: Text(
                                                          state
                                                                      .homeResponse
                                                                      .data[
                                                                          index]
                                                                      .startDate !=
                                                                  null
                                                              ? context.read<HomeBloc>().getDateInGoogleFormate(state.homeResponse.data[0].startDate)
                                                              : ' - - - ',
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Nunito Sans',
                                                              color:
                                                                  Color.fromRGBO(
                                                                      31,
                                                                      33,
                                                                      38,
                                                                      1))),
                                                    )),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]))
                ]),
              );
            }
            return Container();
          })),
    );
  }
}
