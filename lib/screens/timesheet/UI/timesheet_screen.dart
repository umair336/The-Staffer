

import 'package:TheStafferEmployee/screens/timesheet/TimeSheet_Bloc/bloc/time_sheet_bloc.dart';
import 'package:TheStafferEmployee/screens/timesheet/UI/addtimesheet.dart';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:TheStafferEmployee/style/theme.dart' as Style;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TimesheetScreen extends StatefulWidget {
  @override
  _TimesheetScreenState createState() => _TimesheetScreenState();
}

class _TimesheetScreenState extends State<TimesheetScreen> {
  /// Future<TimeSheetData> futureData;
  // late Future<TimeSheetModel> showTimeSheetData;
  // late Future<FormatModel> futureFormate;
  bool isExpanded = false;
// late String startDate; 
// late String endDate; 

  String end = "";
  String startDate = DateFormat('MMMM d,yyyy')
      .format(DateTime.now().subtract( Duration(days: 30)));
    String  endDate = DateFormat('MMMM d,yyyy').format(DateTime.now());

  // String weekstrart = "";
  // String weekend = "";
  var rugular = "";
  var over = "";
  var week_end_date;
  var week_start_date;
  int mg = 0;
  // static const duration = 0;
  late Duration totalweek;
  late Duration month_reg;
  late Duration month_over;
  late Duration month_toal;
  bool val_month_reg = false;
  bool val_month_over = false;
  
 @override
 void initState(){
    // TODO: implement initState
    super.initState();
    print('timesheet init');
    context.read<TimeSheetBloc>().add(GetTimeSheetDataEvent(startDate,endDate));
 }
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   // futureData = timesheet(startDate, endDate);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return  Scaffold(
        body: BlocBuilder<TimeSheetBloc, TimeSheetState>(
          builder: (context, state) {
            if (state is TimeSheetLoadingState) {
              print('time sheet screen loading');
              return const Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Center(child: CircularProgressIndicator())
                ],),
              );
            }
            else if(state is TimeSheetErrorState){
              print('time sheet screen error');
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Text(state.message),
              ],);
            }
             else if(state is TimeSheetCompletedState){
            print('Time sheet screen completed');
             return RefreshIndicator(
                  backgroundColor: Colors.white,
                  color: Color.fromRGBO(13, 91, 196, 1),
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  onRefresh: () {
                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (a, b, c) => TimesheetScreen(),
                            transitionDuration: Duration(seconds: 0)));
                    return Future.value(false);
                  },
                  child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: state.timesheetResponse.timesheet.isEmpty?
                       Container(
                          height: MediaQuery.of(context).size.height,
                          child:const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text('No Job available')
                              )
                            ],
                          ),
                        )
                  
                         : Column(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    decoration:const BoxDecoration(
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
                                            const Color.fromRGBO(0, 91, 196, 1),
                                            Color.fromRGBO(97, 29, 165, 1),
                                          ],
                                        )),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: const Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    Text(
                                                      'Time Sheet',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                        color: Color.fromRGBO(
                                                            255, 255, 255, 1),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Nunito Sans',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        "images/Group 12126@2x.png",
                                                        height:
                                                            size.height * 0.03,
                                                         fit: BoxFit.cover,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.029),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(39, 0, 39, 0),
                                          child: Container(
                                            height: 40,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    //   height: MediaQuery.of(context).size.height * 0.04,
                                                    decoration:
                                                         BoxDecoration(
                                                      color: Colors
                                                          .purple.shade700,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Center(
                                                      child: TextButton(
                                                          onPressed: () {
                                                            _selectStart(
                                                                context);
                                                          },
                                                          child: AutoSizeText(
                                                            startDate,
                                                            style: const TextStyle(
                                                              //  fontWeight: FontWeight.bold,
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Nunito Sans',
                                                              color: Color
                                                                  .fromRGBO(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      1),
                                                            ),
                                                            maxFontSize: 16,
                                                            minFontSize: 8,
                                                            maxLines: 1,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              const  SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  child:const Text(
                                                    'to',
                                                    style: TextStyle(
                                                      //  fontWeight: FontWeight.bold,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Nunito Sans',
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                    ),
                                                  ),
                                                ),
                                               const SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    decoration:
                                                         BoxDecoration(
                                                      color: Colors
                                                          .purple.shade700,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Center(
                                                      child: TextButton(
                                                          onPressed: () {
                                                            _selectEnd(context);
                                                          },
                                                          child: AutoSizeText(
                                                            endDate,
                                                            style:const TextStyle(
                                                              //  fontWeight: FontWeight.bold,
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Nunito Sans',
                                                              color: Color
                                                                  .fromRGBO(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      1),
                                                            ),
                                                            maxFontSize: 16,
                                                            minFontSize: 8,
                                                            maxLines: 1,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02),
                                        Container(
                                          child:const Text(
                                            'Overall Totals',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Nunito Sans',
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .baseline,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      child:const Text(
                                                        'Regular',
                                                        style: TextStyle(
                                                          fontSize: 10.0,
                                                          fontFamily:
                                                              'Nunito Sans',
                                                          color: Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                          //     fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    for (int i = 0;
                                                        i <
                                                            state.timesheetResponse
                                                                .timesheet
                                                                .length;
                                                        i++)
                                                      Container(
                                                        child:
                                                            Regulartotalfunction(
                                                                 state.timesheetResponse
                                                                    .timesheet[
                                                                        i]
                                                                    .regularHours
                                                                    .toString()),
                                                      ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          month_reg.inHours
                                                              .toString(),
                                                          style:const TextStyle(
                                                            fontSize: 14.0,
                                                            fontFamily:
                                                                'Nunito Sans',
                                                            color:
                                                                Color.fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    1),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                       const Text(
                                                          '.',
                                                          style: TextStyle(
                                                            fontSize: 14.0,
                                                            fontFamily:
                                                                'Nunito Sans',
                                                            color:
                                                                Color.fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    1),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          month_reg.inMinutes
                                                                      .remainder(
                                                                          60)
                                                                      .toString() ==
                                                                  '0'
                                                              ? '00'
                                                              : month_reg
                                                                  .inMinutes
                                                                  .remainder(60)
                                                                  .toString(),
                                                          style:const TextStyle(
                                                            fontSize: 14.0,
                                                            fontFamily:
                                                                'Nunito Sans',
                                                            color:
                                                                Color.fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    1),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .baseline,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      child:const Text(
                                                        'Overtime',
                                                        style: TextStyle(
                                                          fontSize: 10.0,
                                                          fontFamily:
                                                              'Nunito Sans',
                                                          color: Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                          //    fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    for (int i = 0;
                                                        i <
                                                             state.timesheetResponse
                                                                .timesheet
                                                                .length;
                                                        i++)
                                                      Container(
                                                        child: Overtotalfunction(
                                                             state.timesheetResponse
                                                                .timesheet[i]
                                                                .overtimeHours
                                                                .toString()),
                                                      ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          month_over.inHours
                                                              .toString(),
                                                          style:const TextStyle(
                                                            fontSize: 14.0,
                                                            fontFamily:
                                                                'Nunito Sans',
                                                            color:
                                                                Color.fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    1),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                       const Text(
                                                          '.',
                                                          style: TextStyle(
                                                            fontSize: 14.0,
                                                            fontFamily:
                                                                'Nunito Sans',
                                                            color:
                                                                Color.fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    1),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          month_over.inMinutes
                                                                      .remainder(
                                                                          60)
                                                                      .toString() ==
                                                                  '0'
                                                              ? '00'
                                                              : month_over
                                                                  .inMinutes
                                                                  .remainder(60)
                                                                  .toString(),
                                                          style:const TextStyle(
                                                            fontSize: 14.0,
                                                            fontFamily:
                                                                'Nunito Sans',
                                                            color:
                                                                Color.fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    1),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .baseline,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      child:const Text(
                                                        'Total',
                                                        style: TextStyle(
                                                          fontSize: 10.0,
                                                          fontFamily:
                                                              'Nunito Sans',
                                                          color: Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                          // fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Monthtotalfuction(
                                                          month_reg,
                                                          month_over),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          month_toal.inHours
                                                              .toString(),
                                                          style:const TextStyle(
                                                            fontSize: 14.0,
                                                            fontFamily:
                                                                'Nunito Sans',
                                                            color:
                                                                Color.fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    1),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                       const Text(
                                                          '.',
                                                          style: TextStyle(
                                                            fontSize: 14.0,
                                                            fontFamily:
                                                                'Nunito Sans',
                                                            color:
                                                                Color.fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    1),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          month_toal.inMinutes
                                                                      .remainder(
                                                                          60)
                                                                      .toString() ==
                                                                  '0'
                                                              ? '00'
                                                              : month_toal
                                                                  .inMinutes
                                                                  .remainder(60)
                                                                  .toString(),
                                                          style:const TextStyle(
                                                            fontSize: 14.0,
                                                            fontFamily:
                                                                'Nunito Sans',
                                                            color:
                                                                Color.fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    1),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                      
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02),
                                      ],
                                    ),
                                  ),
                                  ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: <Widget>[
                                       SizedBox(height: 0.0),
                                       Container(
                                        child:  ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                               state.timesheetResponse.timesheet.length,
                                          physics: ScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            week_end_date =  state.timesheetResponse
                                                .timesheet[index].hoursForWeek
                                                .toString();
                                            week_start_date =
                                                DateTime.parse(week_end_date)
                                                    .subtract(
                                                         Duration(days: 7));
                                            return  Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          25, 0, 25, 0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                        color: Colors
                                                            .grey.shade300,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    //color: Colors.black12,

                                                    child: Column(
                                                      children: <Widget>[
                                                        ExpansionTile(
                                                          trailing: SizedBox(),
                                                       
                                                          title: Column(
                                                            children: [
                                                            const  SizedBox(
                                                                height: 10,
                                                              ),
                                                              Container(
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      child:
                                                                          Text(
                                                                         state.timesheetResponse
                                                                            .timesheet[index]
                                                                            .jobPosition
                                                                            .toString(),
                                                                        style:
                                                                           const TextStyle(
                                                                          fontSize:
                                                                              14.0,
                                                                          color: Color.fromRGBO(
                                                                              13,
                                                                              91,
                                                                              196,
                                                                              1),
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                   state.timesheetResponse
                                                                      .timesheet[
                                                                          index]
                                                                      .customerName
                                                                      .toString(),
                                                                  style:
                                                                     const TextStyle(
                                                                    fontSize:
                                                                        10.0,
                                                                    fontFamily:
                                                                        'Nunito Sans',
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            112,
                                                                            112,
                                                                            112,
                                                                            1),
                                                                    //  fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            const  SizedBox(
                                                                height: 10,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Container(
                                                                          child: Text(
                                                                                    //  DateTime.parse(snapshot.data.timesheet[index].hoursForWeek.toString()).subtract(new Duration(days: 7)).toString(),
                                                                                     state.timesheetResponse.timesheet[index].hoursForWeek.toString() != null ?
                                                                                      DateFormat(state.formateResponse.data[0].currentDateFormat).format(
                                                                                        DateTime.parse( state.timesheetResponse.timesheet[index].hoursForWeek.toString()).subtract(new Duration(days: 7))) : ' ',
                                                                                    style:const TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontSize: 16.0,
                                                                                      fontFamily: 'Nunito Sans',
                                                                                      color: Color.fromRGBO(31, 33, 38, 1),
                                                                                    ),
                                                                                  )),
                                                                    ),

                                                                   const Text(
                                                                      '  to  ',
                                                                      style:
                                                                          TextStyle(
                                                                        //  fontWeight: FontWeight.bold,
                                                                        fontSize:
                                                                            16.0,
                                                                        fontFamily:
                                                                            'Nunito Sans',
                                                                        color: Color.fromRGBO(
                                                                            112,
                                                                            112,
                                                                            112,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child: Container(
                                                                          child:  Text(
                                                                                     state.timesheetResponse.timesheet[index].hoursForWeek != null ? 
                                                                                     DateFormat(state.formateResponse.data[0].currentDateFormat).format(DateTime.parse(state.timesheetResponse.timesheet[index].hoursForWeek)) : ' ',
                                                                                    style:const TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontSize: 16.0,
                                                                                      fontFamily: 'Nunito Sans',
                                                                                      color: Color.fromRGBO(31, 33, 38, 1),
                                                                                    ),
                                                                                  )),
                                                                    ),

                                                                    //          Container(
                                                                    //  child: weekDifference(weekstrart),
                                                                    //),
                                                                  ],
                                                                ),
                                                              ),
                                                            const  SizedBox(
                                                                height: 15,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        27,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade200,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  // color: Color.fromRGBO(0, 0, 0, 0.16),
                                                                  child:
                                                                      Container(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        Container(
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.baseline,
                                                                            textBaseline:
                                                                                TextBaseline.alphabetic,
                                                                            children: [
                                                                            const  SizedBox(
                                                                                height: 15,
                                                                              ),
                                                                              Container(
                                                                                child:const Text(
                                                                                  'Regular',
                                                                                  style: TextStyle(
                                                                                    fontSize: 10.0,
                                                                                    fontFamily: 'Nunito Sans',
                                                                                    color: Color.fromRGBO(112, 112, 112, 1),
                                                                                    //  fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                rugular =  state.timesheetResponse.timesheet[index].regularHours.toString(),
                                                                                style:const TextStyle(
                                                                                  fontSize: 12.0,
                                                                                  fontFamily: 'Nunito Sans',
                                                                                  color: Color.fromRGBO(31, 33, 38, 1),
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                             const SizedBox(
                                                                                height: 15,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.baseline,
                                                                            textBaseline:
                                                                                TextBaseline.alphabetic,
                                                                            children: [
                                                                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                                                              Container(
                                                                                child:const Text(
                                                                                  'Overtime',
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'Nunito Sans',
                                                                                    fontSize: 10.0,
                                                                                    color: Color.fromRGBO(112, 112, 112, 1),
                                                                                    // fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                over =  state.timesheetResponse.timesheet[index].overtimeHours.toString(),
                                                                                style:const TextStyle(
                                                                                  fontSize: 12.0,
                                                                                  fontFamily: 'Nunito Sans',
                                                                                  color: Color.fromRGBO(31, 33, 38, 1),
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.baseline,
                                                                            textBaseline:
                                                                                TextBaseline.alphabetic,
                                                                            children: [
                                                                              Container(
                                                                                child: Weektotal(),
                                                                              ),
                                                                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                                                              Container(
                                                                                child:const Text(
                                                                                  'Total',
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'Nunito Sans',
                                                                                    fontSize: 10.0,
                                                                                    color: Color.fromRGBO(112, 112, 112, 1),
                                                                                    //   fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    totalweek.inHours.toString(),
                                                                                    style:const TextStyle(
                                                                                      fontFamily: 'Nunito Sans',
                                                                                      fontSize: 12.0,
                                                                                      color: Color.fromRGBO(31, 33, 38, 1),
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                 const Text(
                                                                                    '.',
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Nunito Sans',
                                                                                      fontSize: 12.0,
                                                                                      color: Color.fromRGBO(31, 33, 38, 1),
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    totalweek.inMinutes.remainder(60).toString() == '0' ? '00' : totalweek.inMinutes.remainder(60).toString(),
                                                                                    style:const TextStyle(
                                                                                      fontFamily: 'Nunito Sans',
                                                                                      fontSize: 12.0,
                                                                                      color: Color.fromRGBO(31, 33, 38, 1),
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            const  SizedBox(
                                                                height: 10,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 20.0),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                              Container(
                                child: dispos(),
                              )
                            ],
                          )
                        // } else {
                        //   return Column(children: [
                        //     Container(
                        //         decoration:const BoxDecoration(
                        //             borderRadius: BorderRadius.only(
                        //                 bottomLeft: Radius.circular(15),
                        //                 bottomRight: Radius.circular(15)),
                        //             gradient: LinearGradient(
                        //               begin: Alignment.topRight,
                        //               end: Alignment.bottomLeft,
                        //               stops: [
                        //                 0.1,
                        //                 0.5,
                        //               ],
                        //               colors: [
                        //                 Color.fromRGBO(0, 91, 196, 1),
                        //                 Color.fromRGBO(97, 29, 165, 1),
                        //               ],
                        //             )),
                        //         child: Column(
                        //           children: [
                        //             SizedBox(
                        //                 height:
                        //                     MediaQuery.of(context).size.height *
                        //                         0.05),
                        //             Container(
                        //               child: Row(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.spaceBetween,
                        //                 children: [
                        //                   Container(
                        //                     child:const Row(
                        //                       children: [
                        //                         SizedBox(
                        //                           width: 12,
                        //                         ),
                        //                         Text(
                        //                           'Time Sheet',
                        //                           style: TextStyle(
                        //                             fontSize: 18.0,
                        //                             color: Color.fromRGBO(
                        //                                 255, 255, 255, 1),
                        //                             fontWeight: FontWeight.bold,
                        //                             fontFamily: 'Nunito Sans',
                        //                           ),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                   Container(
                        //                     child: Padding(
                        //                       padding: const EdgeInsets.only(
                        //                           right: 10),
                        //                       child: Row(
                        //                         children: [
                                        
                        //                           Image.asset(
                        //                             "images/Group 12126@2x.png",
                        //                             height: size.height * 0.03,
                        //                             // fit: BoxFit.cover,
                        //                           ),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //             ),
                        //             SizedBox(
                        //                 height:
                        //                     MediaQuery.of(context).size.height *
                        //                         0.029),
                        //             Padding(
                        //               padding:
                        //                   EdgeInsets.fromLTRB(39, 0, 39, 0),
                        //               child: Container(
                        //                 height: 40,
                        //                 child: Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.center,
                        //                   children: [
                        //                     Expanded(
                        //                       child: Container(
                        //                         //   height: MediaQuery.of(context).size.height * 0.04,
                        //                         decoration:  BoxDecoration(
                        //                           color: Colors.purple.shade700,
                        //                           borderRadius:
                        //                               BorderRadius.circular(20),
                        //                         ),
                        //                         child: Center(
                        //                           child: TextButton(
                        //                               onPressed: () {
                        //                                 _selectStart(context);
                        //                               },
                        //                               child: AutoSizeText(
                        //                                 startDate,
                        //                                 style:const TextStyle(
                        //                                   //  fontWeight: FontWeight.bold,
                        //                                   fontSize: 16.0,
                        //                                   fontWeight:
                        //                                       FontWeight.bold,
                        //                                   fontFamily:
                        //                                       'Nunito Sans',
                        //                                   color: Color.fromRGBO(
                        //                                       255, 255, 255, 1),
                        //                                 ),
                        //                                 maxFontSize: 15,
                        //                                 minFontSize: 8,
                        //                                 maxLines: 1,
                        //                               )),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   const  SizedBox(
                        //                       width: 5,
                        //                     ),
                        //                     Container(
                        //                       child:const Text(
                        //                         'to',
                        //                         style: TextStyle(
                        //                           //  fontWeight: FontWeight.bold,
                        //                           fontSize: 12.0,
                        //                           fontWeight: FontWeight.bold,
                        //                           fontFamily: 'Nunito Sans',
                        //                           color: Color.fromRGBO(
                        //                               255, 255, 255, 1),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                 const    SizedBox(
                        //                       width: 5,
                        //                     ),
                        //                     Expanded(
                        //                       child: Container(
                        //                         decoration:  BoxDecoration(
                        //                           color: Colors.purple.shade700,
                        //                           borderRadius:
                        //                               BorderRadius.circular(20),
                        //                         ),
                        //                         child: Center(
                        //                           child: TextButton(
                        //                               onPressed: () {
                        //                                 _selectEnd(context);
                        //                               },
                        //                               child: AutoSizeText(
                        //                                 endDate,
                        //                                 style:const TextStyle(
                        //                                   //  fontWeight: FontWeight.bold,
                        //                                   fontSize: 16.0,
                        //                                   fontWeight:
                        //                                       FontWeight.bold,
                        //                                   fontFamily:
                        //                                       'Nunito Sans',
                        //                                   color: Color.fromRGBO(
                        //                                       255, 255, 255, 1),
                        //                                 ),
                        //                                 maxFontSize: 16,
                        //                                 minFontSize: 8,
                        //                                 maxLines: 1,
                        //                               )),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //             SizedBox(
                        //                 height:
                        //                     MediaQuery.of(context).size.height *
                        //                         0.01),
                              
                        //             SizedBox(
                        //                 height:
                        //                     MediaQuery.of(context).size.height *
                        //                         0.02),
                        //             Container(
                        //               child:const Text(
                        //                 'Overall Totals',
                        //                 style: TextStyle(
                        //                   fontSize: 14.0,
                        //                   fontWeight: FontWeight.bold,
                        //                   fontFamily: 'Nunito Sans',
                        //                   color:
                        //                       Color.fromRGBO(255, 255, 255, 1),
                        //                 ),
                        //               ),
                        //             ),
                        //             SizedBox(
                        //                 height:
                        //                     MediaQuery.of(context).size.height *
                        //                         0.02),
                        //             Container(
                        //               child: Row(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.spaceAround,
                        //                 children: [
                        //                   Container(
                        //                     child: Column(
                        //                       crossAxisAlignment:
                        //                           CrossAxisAlignment.baseline,
                        //                       textBaseline:
                        //                           TextBaseline.alphabetic,
                        //                       children: [
                        //                         Container(
                        //                           child:const Text(
                        //                             'Regular',
                        //                             style: TextStyle(
                        //                               fontSize: 10.0,
                        //                               fontFamily: 'Nunito Sans',
                        //                               color: Color.fromRGBO(
                        //                                   255, 255, 255, 1),
                        //                               //     fontWeight: FontWeight.bold,
                        //                             ),
                        //                           ),
                        //                         ),
                        //                      const   Row(
                        //                           children: [
                        //                             Text(
                        //                               '00',
                        //                               style: TextStyle(
                        //                                 fontSize: 14.0,
                        //                                 fontFamily:
                        //                                     'Nunito Sans',
                        //                                 color: Color.fromRGBO(
                        //                                     255, 255, 255, 1),
                        //                                 fontWeight:
                        //                                     FontWeight.bold,
                        //                               ),
                        //                             ),
                        //                             Text(
                        //                               '.',
                        //                               style: TextStyle(
                        //                                 fontSize: 14.0,
                        //                                 fontFamily:
                        //                                     'Nunito Sans',
                        //                                 color: Color.fromRGBO(
                        //                                     255, 255, 255, 1),
                        //                                 fontWeight:
                        //                                     FontWeight.bold,
                        //                               ),
                        //                             ),
                        //                             Text(
                        //                               '00',
                        //                               style: TextStyle(
                        //                                 fontSize: 14.0,
                        //                                 fontFamily:
                        //                                     'Nunito Sans',
                        //                                 color: Color.fromRGBO(
                        //                                     255, 255, 255, 1),
                        //                                 fontWeight:
                        //                                     FontWeight.bold,
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                   Container(
                        //                     child: Column(
                        //                       crossAxisAlignment:
                        //                           CrossAxisAlignment.baseline,
                        //                       textBaseline:
                        //                           TextBaseline.alphabetic,
                        //                       children: [
                        //                         Container(
                        //                           child:const Text(
                        //                             'Overtime',
                        //                             style: TextStyle(
                        //                               fontSize: 10.0,
                        //                               fontFamily: 'Nunito Sans',
                        //                               color: Color.fromRGBO(
                        //                                   255, 255, 255, 1),
                        //                               //    fontWeight: FontWeight.bold,
                        //                             ),
                        //                           ),
                        //                         ),
                        //                       const  Row(
                        //                           children: [
                        //                             Text(
                        //                               '00',
                        //                               style: TextStyle(
                        //                                 fontSize: 14.0,
                        //                                 fontFamily:
                        //                                     'Nunito Sans',
                        //                                 color: Color.fromRGBO(
                        //                                     255, 255, 255, 1),
                        //                                 fontWeight:
                        //                                     FontWeight.bold,
                        //                               ),
                        //                             ),
                        //                             Text(
                        //                               '.',
                        //                               style: TextStyle(
                        //                                 fontSize: 14.0,
                        //                                 fontFamily:
                        //                                     'Nunito Sans',
                        //                                 color: Color.fromRGBO(
                        //                                     255, 255, 255, 1),
                        //                                 fontWeight:
                        //                                     FontWeight.bold,
                        //                               ),
                        //                             ),
                        //                             Text(
                        //                               '00',
                        //                               style: TextStyle(
                        //                                 fontSize: 14.0,
                        //                                 fontFamily:
                        //                                     'Nunito Sans',
                        //                                 color: Color.fromRGBO(
                        //                                     255, 255, 255, 1),
                        //                                 fontWeight:
                        //                                     FontWeight.bold,
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                   Container(
                        //                     child: Column(
                        //                       crossAxisAlignment:
                        //                           CrossAxisAlignment.baseline,
                        //                       textBaseline:
                        //                           TextBaseline.alphabetic,
                        //                       children: [
                        //                         Container(
                        //                           child:const Text(
                        //                             'Total',
                        //                             style: TextStyle(
                        //                               fontSize: 10.0,
                        //                               fontFamily: 'Nunito Sans',
                        //                               color: Color.fromRGBO(
                        //                                   255, 255, 255, 1),
                        //                               // fontWeight: FontWeight.bold,
                        //                             ),
                        //                           ),
                        //                         ),
                        //                       const  Row(
                        //                           children: [
                        //                             Text(
                        //                               '00',
                        //                               style: TextStyle(
                        //                                 fontSize: 14.0,
                        //                                 fontFamily:
                        //                                     'Nunito Sans',
                        //                                 color: Color.fromRGBO(
                        //                                     255, 255, 255, 1),
                        //                                 fontWeight:
                        //                                     FontWeight.bold,
                        //                               ),
                        //                             ),
                        //                             Text(
                        //                               '.',
                        //                               style: TextStyle(
                        //                                 fontSize: 14.0,
                        //                                 fontFamily:
                        //                                     'Nunito Sans',
                        //                                 color: Color.fromRGBO(
                        //                                     255, 255, 255, 1),
                        //                                 fontWeight:
                        //                                     FontWeight.bold,
                        //                               ),
                        //                             ),
                        //                             Text(
                        //                               '00',
                        //                               style: TextStyle(
                        //                                 fontSize: 14.0,
                        //                                 fontFamily:
                        //                                     'Nunito Sans',
                        //                                 color: Color.fromRGBO(
                        //                                     255, 255, 255, 1),
                        //                                 fontWeight:
                        //                                     FontWeight.bold,
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ),
                                     
                        //                 ],
                        //               ),
                        //             ),
                        //             SizedBox(
                        //                 height:
                        //                     MediaQuery.of(context).size.height *
                        //                         0.02),
                        //           ],
                        //         )),
                        //    const Padding(
                        //       padding: EdgeInsets.only(top: 50),
                        //       child: Text(
                        //         'No Time Sheet',
                        //         style: TextStyle(
                        //             fontSize: 14,
                        //             fontWeight: FontWeight.bold,
                        //             fontFamily: 'Nunito Sans',
                        //             color: Color.fromRGBO(112, 112, 112, 1)),
                        //       ),
                        //     )
                        //   ]);
                        //   }
                        
                          ),
                );
           }
           return Container();
          }
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add,color: Style.Colors.background,),
          backgroundColor: Style.Colors.secondaryColor,
          onPressed: (){Navigator.push(context, MaterialPageRoute(builder:(context) => Addtimesheet(), ),
          );}),
        );
  }
  
  _selectStart(BuildContext context) async {
  final selected = await showDatePicker(
    context: context,
    initialDate: DateFormat('MMMM d,yyyy').parse(startDate), // Parse start_date
    firstDate: DateTime(1970),
    lastDate: DateTime(2025),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: const Color.fromRGBO(13, 91, 196, 1),
          hintColor: const Color.fromRGBO(13, 91, 196, 1),
          colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(13, 91, 196, 1),
          ),
        ),
        child: child ?? Container(),
      );
    },
  );
  if (selected != null) {
    setState(() {
      startDate = DateFormat('MMMM d,yyyy').format(selected);
      print('Selected Start Date: $startDate');
      context.read<TimeSheetBloc>().add(GetTimeSheetDataEvent(startDate, endDate));
    });
  }
}

_selectEnd(BuildContext context) async {
  final selected = await showDatePicker(
    context: context,
    initialDate: DateFormat('MMMM d,yyyy').parse(endDate),
    firstDate: DateTime(2010),
    lastDate: DateTime(2025),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: const Color.fromRGBO(13, 91, 196, 1),
          hintColor: const Color.fromRGBO(13, 91, 196, 1),
          colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(13, 91, 196, 1),
          ),
        ),
        child: child ?? Container(),
      );
    },
  );
  if (selected != null) {
    setState(() {
      endDate = DateFormat('MMMM d,yyyy').format(selected);
      print('Selected End Date: $endDate');
      context.read<TimeSheetBloc>().add(GetTimeSheetDataEvent(startDate, endDate));
    });
  }
}

  Weektotal() {
    print('ccccccccccc$rugular cccccccccccccc$over');

    var regularWeek = rugular.split('.');
    var overWeek = over.split('.');
  
    Duration regWeek =  Duration(
      hours: int.parse(regularWeek[0]),
      minutes: int.parse(regularWeek[1]),
    );
    //print('ssssssssss$reg_week');
    Duration ove_week =  Duration(
      hours: int.parse(overWeek[0]),
      minutes: int.parse(overWeek[1]),
    );

    Duration totalRegOver =  Duration(
        hours: int.parse(regularWeek[0]) + int.parse(overWeek[0]),
        minutes: int.parse(regularWeek[1]) + int.parse(overWeek[1]));

    print(totalRegOver);

    totalweek = totalRegOver;
    //String duration = DateFormat('hh:mm').format(totalweek);

    print(
        'iiiiiiiiiiiiiiiiiiiii${totalRegOver.inMinutes} dddddddddddddddddddddddddd${totalweek}');
  }

  // ignore: non_constant_identifier_names
  Regulartotalfunction(reg) {
    print('pppppp $reg');
    var m_reg = reg.split('.');
    print('object${m_reg[0]}jjjjjjjj${m_reg[1]}');

    if (val_month_reg == false) {
      month_reg =  Duration(
          hours: int.parse(m_reg[0]), minutes: int.parse(m_reg[1]), seconds: 0);
      val_month_reg = true;
    } else {
      month_reg =  Duration(
          hours: int.parse(m_reg[0]),
          minutes:
              int.parse(m_reg[1]) + int.parse(month_reg.inMinutes.toString()),
          seconds: 0);
    }
    print('dddddddddddddddddddddd$month_reg');
  }

  // ignore: non_constant_identifier_names
  Overtotalfunction(ov) {
    print('iiiiiiiiiiiiiiiiiiiiiiiiii $ov');
    var m_reg = ov.split('.');
    print('object${m_reg[0]}nnnnnnnn${m_reg[1]}');
    if (val_month_over == false) {
      month_over =  Duration(
          hours: int.parse(m_reg[0]), minutes: int.parse(m_reg[1]), seconds: 0);
      val_month_over = true;
      print('hhhhhhhhhhhhhhhhhhhhhh$month_over');
    } else {
      month_over =  Duration(
          hours: int.parse(m_reg[0]),
          minutes:
              int.parse(m_reg[1]) + int.parse(month_over.inMinutes.toString()),
          seconds: 0);
      print('hhhhhhhhhhhhhhhhhhhhhh$month_over');
    }
  }

  // ignore: non_constant_identifier_names
  Monthtotalfuction(Duration d1, Duration d2) {
    print('yyyyyyyyyyyyyyyyyyyyyy$d1 yyyyyyyyyyyyyyyyyyyyyy$d2');

    month_toal =  Duration(
      hours:
          int.parse(d1.inHours.toString()) + int.parse(d2.inHours.toString()),
      minutes: int.parse(d1.inMinutes.remainder(60).toString()) +
          int.parse(d2.inMinutes.remainder(60).toString()),
    );
  }

  dispos() {
    month_reg = const Duration(hours: 0, minutes: 0, seconds: 0);
    month_over =  const Duration(hours: 0, minutes: 0, seconds: 0);

  }
}
