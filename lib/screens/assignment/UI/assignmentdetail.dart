import 'dart:async';
import 'dart:ffi';
import 'package:TheStafferEmployee/screens/assignment/assignment_bloc/bloc/assignment_bloc.dart';
import 'package:TheStafferEmployee/screens/assignment/assignment_bloc/bloc/assignment_event.dart';
import 'package:TheStafferEmployee/screens/assignment/assignment_bloc/bloc/assignment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Assignmentdetail extends StatefulWidget {
  int jobid;
  Assignmentdetail({ required this.jobid}) : super(key: null);
  @override
  _AssignmentdetailState createState() => _AssignmentdetailState();
}

class _AssignmentdetailState extends State<Assignmentdetail> {
  bool timeount_false = false;
  bool in_out = true;
  bool break_start_end = true;
  var workingStart;
  var workingOff;
  var breakstart;
  var breakoff;
  late TimeOfDay _t;
  late TimeOfDay _pp;
  var time;
  var breaak;
  late Duration breaktime;
  var totaltime = [];
  var breaks;
  // ignore: non_constant_identifier_names
  var Breaklist = [];
  var breakStartList = [];
  var braeakEndList = [];
  var starttime = [];
  var offtime = [];
  var now = DateTime.now();
  var payrate;
  var otPayrate;
  late int jobid;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AssignmentBloc>().add(GetAssignmentDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<AssignmentBloc, AssignmentState>(
            builder: (context, state) {
               if(state is AssignmentErrorState){
                print('Assignment data error');
                return Center(
                  child: Column(
                    children: [Text('data not fetch${state.message}')],
                  ),
                );
              }
            if(state is AssignmentLoadedState){
               return RefreshIndicator(
                  backgroundColor: Colors.white,
                  color:const Color.fromRGBO(13, 91, 196, 1),
                  //  strokeWidth: 2,
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  onRefresh: () {
                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (a, b, c) => Assignmentdetail(
                                  jobid: widget.jobid,
                                ),
                            transitionDuration: Duration(seconds: 0)));
                    return Future.value(false);
                  },
                  child: SingleChildScrollView(
                    child:Column(
                            children: [
                              Column(
                                children: [
                                  Container(
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
                                     const   SizedBox(
                                          height: 30,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(14, 0, 7, 0),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                icon:const Icon(
                                                  Icons.arrow_back,
                                                  color: Color.fromRGBO(255, 255, 255, 1),
                                                  size: 20,
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            const  SizedBox(
                                                width: 10,
                                              ),
                                           const   Text(
                                                'Assignments Detail',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0,
                                                  color: Color.fromRGBO(255, 255, 255, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                const  SizedBox(
                                    height: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(23, 0, 23, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                          width: 1,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                        const  SizedBox(height: 12),
                                          Padding(
                                            padding:
                                                const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                          
                                             const   SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.baseline,
                                                    textBaseline: TextBaseline.alphabetic,
                                                    children: [
                                                   const   SizedBox(
                                                        height: 9,
                                                      ),
                                                      Text(
                                                        // 'Job Title will come here',
                                                        state.detailResponse.detail.record
                                                                    .positionName !=null
                                                            ? state.detailResponse.detail.record.positionName: '',
                                                        style:const TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight: FontWeight.bold,
                                                          color: Color.fromRGBO(
                                                              13, 91, 196, 1),
                                                        ),
                                                      ),
                                                     const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        //  'Department name will come here',
                                                        state.detailResponse.detail.record.departmentNames !=
                                                                null? state.detailResponse.detail.record
                                                                .departmentNames: '',
          
                                                        style:const TextStyle(
                                                          fontFamily: 'Nunito Sans',
                                                          // fontWeight: FontWeight.semibold,
                                                          fontSize: 10.0,
                                                          color: Color.fromRGBO(
                                                              83, 83, 83, 1),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                       const   SizedBox(
                                            height: 20,
                                          ),
          
                                          Padding(
                                            padding:
                                                const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        "images/Applicant@2x.png",
                                                        height: size.height * 0.02,
                                                        // fit: BoxFit.cover,
                                                      ),
                                                    const  SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        state.detailResponse.detail.record
                                                                    .customerName !=null
                                                            ? state.detailResponse.detail.record
                                                                .customerName: ' ',
                                                        //  'Customer Name Here',
                                                        style:const TextStyle(
                                                          fontFamily: 'Nunito Sans',
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 12.0,
                                                          color:
                                                              Color.fromRGBO(0, 0, 0, 1),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        "images/placeholder@2x.png",
                                                        height: size.height * 0.02,
                                                        // fit: BoxFit.cover,
                                                      ),
                                                    const  SizedBox(
                                                        width: 5,
                                                      ),
                                                      Container(
                                                        //  height: 20,
                                                        width: 130,
                                                        child: Text(
                                                          //'New York, NY',
          
                                                          state.detailResponse.detail.address
                                                                      .address !=
                                                                  null
                                                              ? state.detailResponse.detail
                                                                  .address.address
                                                              : ' ',
          
                                                          style:const TextStyle(
                                                            fontFamily: 'Nunito Sans',
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 12.0,
                                                            color: Color.fromRGBO(
                                                                0, 0, 0, 1),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                         const SizedBox(
                                            height: 20,
                                          ),
          
                                          Container(
                                            height: 50,
                                            child: Padding(
                                              padding:const EdgeInsets.only(top: 0),
                                              child: Stack(
                                                alignment: AlignmentDirectional.center,
                                                children: <Widget>[
                                                  /** Positioned WIdget **/
                                                  Positioned(
                                                    top: 0,
                                                    left: 20,
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.baseline,
                                                        textBaseline:
                                                            TextBaseline.alphabetic,
                                                        children: [
                                                        const  Text("Start Date ",
                                                              style: TextStyle(
                                                                fontFamily: 'Nunito Sans',
                                                                //  fontWeight: FontWeight.bold,
                                                                fontSize: 10.0,
                                                                color: Color.fromRGBO(
                                                                    112, 112, 112, 1),
                                                              )),
                                                        const  SizedBox(
                                                            height: 2,
                                                          ),
                                                          Container(
                                                              child:
                                                                  Text(
                                                                            state.detailResponse.detail.record
                                                                               .startDate
                                                                               .toString() !=
                                                                           null
                                                                        ? DateFormat(state.formateResponse!.data[0].currentDateFormat)
                                                                        .format(DateTime.parse(state.detailResponse.detail.record.startDate.toString()))
                                                                                : ' - - - ',
                                                                            style:
                                                                            const    TextStyle(
                                                                              fontFamily:
                                                                                  'Nunito Sans',
                                                                              fontWeight:
                                                                                  FontWeight
                                                                                      .bold,
                                                                              fontSize:
                                                                                  14.0,
                                                                              color: Color
                                                                                  .fromRGBO(
                                                                                      0,
                                                                                      0,
                                                                                      0,
                                                                                      1),
                                                                            ),
                                                                          )),
                                                        ],
                                                      ),
                                                    ), //Icon
                                                  ), //Positioned
                                                  /** Positioned WIdget **/
          
                                                  Positioned(
                                                    top: 0,
                                                    left: 160,
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.baseline,
                                                        textBaseline:
                                                            TextBaseline.alphabetic,
                                                        children: [
                                                         const Text("End Date ",
                                                              style: TextStyle(
                                                                fontFamily: 'Nunito Sans',
                                                                //  fontWeight: FontWeight.bold,
                                                                fontSize: 10.0,
                                                                color: Color.fromRGBO(
                                                                    112, 112, 112, 1),
                                                              )),
                                                       const   SizedBox(
                                                            height: 2,
                                                          ),
                                                          if (state.detailResponse.detail.record
                                                                      .endDate ==
                                                                  null ||
                                                              state.detailResponse.detail.record
                                                                      .endDate ==
                                                                  "")
                                                            Text('')
                                                          else
                                                           Text(
                                                                      state.detailResponse.detail
                                                                                  .record
                                                                                  .endDate
                                                                                  .toString() !=
                                                                              null
                                                                          ? DateFormat(state.formateResponse
                                                                                  .data[0]
                                                                                  .currentDateFormat)
                                                                              .format(DateTime.parse(
                                                                                state.detailResponse.detail
                                                                                  .record
                                                                                  .endDate))
                                                                          : ' - - - ',
                                                                      style:const TextStyle(
                                                                        fontFamily:
                                                                            'Nunito Sans',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize: 14.0,
                                                                        color: Color
                                                                            .fromRGBO(0,
                                                                                0, 0, 1),
                                                                      ),
                                                                    )
                                                        ],
                                                      ),
                                                    ),
                                                  ), //Positioned
                                                ], //<Widget>[]
                                              ), //Stack
                                            ),
                                          ),
                                          ///////////////////////////////
                                          Container(
                                            height: 50,
                                            child: Padding(
                                              padding:const EdgeInsets.only(top: 0),
                                              child: Stack(
                                                alignment: AlignmentDirectional.center,
                                                children: <Widget>[
                                                  /** Positioned WIdget **/
                                                  Positioned(
                                                    top: 0,
                                                    left: 20,
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.baseline,
                                                        textBaseline:
                                                            TextBaseline.alphabetic,
                                                        children: [
                                                        const  Text(
                                                            'Pay Rate',
                                                            style: TextStyle(
                                                              fontFamily: 'Nunito Sans',
                                                              //  fontWeight: FontWeight.bold,
                                                              fontSize: 10.0,
                                                              color: Color.fromRGBO(
                                                                  112, 112, 112, 1),
                                                            ),
                                                          ),
                                                         const SizedBox(
                                                            height: 5,
                                                          ),
                                                          if (state.detailResponse.detail.payRate !=
                                                              null)
                                                            Column(
                                                              children: [
                                                                Container(
                                                                  child: _FunctionPayrate(
                                                                      state.detailResponse.detail
                                                                          .payRate),
                                                                ),
                                                                Text(
                                                                  //  '\.00/hr',
          
                                                                  payrate,
                                                                  style:const TextStyle(
                                                                    fontFamily:
                                                                        'Nunito Sans',
                                                                    fontWeight:
                                                                        FontWeight.bold,
                                                                    fontSize: 14.0,
                                                                    color: Color.fromRGBO(
                                                                        0, 0, 0, 1),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          else
                                                          const  Text(
                                                              '00',
                                                              style: TextStyle(
                                                                fontFamily: 'Nunito Sans',
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                                fontSize: 14.0,
                                                                color: Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                              ),
                                                            )
                                                        ],
                                                      ),
                                                    ), //Icon
                                                  ), //Positioned
                                                  /** Positioned WIdget **/
          
                                                  Positioned(
                                                    top: 0,
                                                    left: 160,
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.baseline,
                                                        textBaseline:
                                                            TextBaseline.alphabetic,
                                                        children: [
                                                      const    Text(
                                                            'OT Pay Rate',
                                                            style: TextStyle(
                                                              fontFamily: 'Nunito Sans',
                                                              //  fontWeight: FontWeight.bold,
                                                              fontSize: 10.0,
                                                              color: Color.fromRGBO(
                                                                  112, 112, 112, 1),
                                                            ),
                                                          ),
                                                       const   SizedBox(
                                                            height: 5,
                                                          ),
                                                          if (state.detailResponse.detail
                                                                  .overtimePayRate !=
                                                              null)
                                                            Column(
                                                              children: [
                                                                Container(
                                                                  child: _FunctionOtPayrate(
                                                                      state.detailResponse.detail
                                                                          .overtimePayRate),
                                                                ),
                                                                Text(
                                                                  //  '\.00/hr',
          
                                                                  otPayrate,
                                                                  style:const TextStyle(
                                                                    fontFamily:
                                                                        'Nunito Sans',
                                                                    fontWeight:
                                                                        FontWeight.bold,
                                                                    fontSize: 14.0,
                                                                    color: Color.fromRGBO(
                                                                        0, 0, 0, 1),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          else
                                                           const Text(
                                                              '00',
                                                              style: TextStyle(
                                                                fontFamily: 'Nunito Sans',
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                                fontSize: 14.0,
                                                                color: Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                              ),
                                                            )
                                                        ],
                                                      ),
                                                    ),
                                                  ), //Positioned
                                                ], //<Widget>[]
                                              ), //Stack
                                            ),
                                          ),
          
                                      const    SizedBox(
                                            height: 3,
                                          ),
          
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(right: 0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                  const    Text(
                                                        'Status',
                                                        style: TextStyle(
                                                          fontFamily: 'Nunito Sans',
                                                          //  fontWeight: FontWeight.bold,
                                                          fontSize: 10.0,
                                                          color: Color.fromRGBO(
                                                              112, 112, 112, 1),
                                                        ),
                                                      ),
                                                   const   SizedBox(
                                                        height: 5,
                                                      ),
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(5.0),
                                                        child: Container(
                                                          height: 20,
                                                          width: 70,
                                                          margin: const EdgeInsets.only(
                                                              left:
                                                                  6.0), //Same as `blurRadius` i guess
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    5.0),
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: const Color.fromRGBO(
                                                                    27, 185, 31, 1)),
                                                            boxShadow:const [
                                                              BoxShadow(
                                                                color: Color.fromRGBO(
                                                                    27, 185, 31, 1),
                                                                offset: Offset(
                                                                    0.0, 0.9), //(x,y)
                                                                blurRadius: 12.0,
                                                                spreadRadius: 5,
                                                              ),
                                                            ],
                                                          ),
          
                                                          child: Center(
                                                            child: state.detailResponse.detail
                                                                        .record.status !=
                                                                    null
                                                                ? Text(
                                                                    state.detailResponse.detail
                                                                                .record
                                                                                .status ==
                                                                            "Completed"
                                                                        ? "Finished"
                                                                        :state.detailResponse.detail
                                                                            .record
                                                                            .status,
                                                                    style:const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize: 10.0,
                                                                        color: Color
                                                                            .fromRGBO(
                                                                                27,
                                                                                185,
                                                                                31,
                                                                                1)),
                                                                  )
                                                                : Container(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (state.detailResponse.detail.record.status !=
                                                    'Upcoming')
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      children: [
                                                     const   Text(
                                                          'Total Break Time',
                                                          style: TextStyle(
                                                            fontFamily: 'Nunito Sans',
                                                            //  fontWeight: FontWeight.bold,
                                                            fontSize: 10.0,
                                                            color: Color.fromRGBO(
                                                                112, 112, 112, 1),
                                                          ),
                                                        ),
                                                     const   SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          //  '\OT Pay Rate',
                                                          breaak == null
                                                              ? '0:00:00'
                                                              : breaak
                                                                  .toString()
                                                                  .split('.')
                                                                  .first,
                                                          style:const TextStyle(
                                                            fontFamily: 'Nunito Sans',
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 14.0,
                                                            color: Color.fromRGBO(
                                                                0, 0, 0, 1),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                if (state.detailResponse.detail.record.status !=
                                                    'Upcoming')
                                                  Padding(
                                                    padding:const EdgeInsets.only(right: 30),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      children: [
                                                      const  Text(
                                                          'Total Work Time',
                                                          style: TextStyle(
                                                            fontFamily: 'Nunito Sans',
                                                            //  fontWeight: FontWeight.bold,
                                                            fontSize: 10.0,
                                                            color: Color.fromRGBO(
                                                                112, 112, 112, 1),
                                                          ),
                                                        ),
                                                      const  SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          //  '\OT Pay Rate',
                                                          time == null
                                                              ? '0:00:00'
                                                              : time
                                                                  .toString()
                                                                  .split('.')
                                                                  .first,
                                                          style:const TextStyle(
                                                            fontFamily: 'Nunito Sans',
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 14.0,
                                                            color: Color.fromRGBO(
                                                                0, 0, 0, 1),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
          
                                        const  SizedBox(
                                            height: 25,
                                          ),
                                          
                                          if (state.detailResponse.detail.record.status ==
                                              'Active')
                                            Column(children: [
                                              in_out
                                                  ? Container(
                                                      height: 45,
                                                      width: MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.75,
                                                      child: ElevatedButton(
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty.all<
                                                                      Color>(
                                                                  Color.fromRGBO(
                                                                      13, 91, 196, 1)),
                                                          shape:
                                                              MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      10.0),
                                                              //   side: BorderSide(color: Colors.red.shade900),
                                                            ),
                                                          ),
                                                        ),
                                                        child:const Text(
                                                          'Punch-In',
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 14.0,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        onPressed: () {
          
                                                          setState(() {
                                                            jobid = state.detailResponse.detail.shifts[0].jobId;
                                                            print(
                                                                'eeeeeeeeeeeeeee$jobid');
                                                            DialogStarttime();
                                                            //  in_out = !in_out;
                                                          });
                                                        },
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding:const EdgeInsets.fromLTRB(
                                                          20, 0, 20, 0),
                                                      child: Row(
                                                        children: [
                                                          break_start_end
                                                              ? Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.30,
                                                                  height: 45,
          
                                                                  child: TextButton(
                                                                    style: ButtonStyle(
                                                                      backgroundColor:
                                                                          MaterialStateProperty
                                                                              .all<Color>(
                                                                                  Colors
                                                                                      .white),
                                                                      shape: MaterialStateProperty
                                                                          .all<
                                                                              RoundedRectangleBorder>(
                                                                        RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius
                                                                                  .circular(
                                                                                      10.0),
                                                                          side:const BorderSide(
                                                                              color: Color
                                                                                  .fromRGBO(
                                                                                      13,
                                                                                      91,
                                                                                      196,
                                                                                      1),
                                                                              width: 1),
          
                                                                          //   side: BorderSide(color: Colors.red.shade900),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                       child:const Text(
                                                                      'Break Start',
                                                                      style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize: 14.0,
                                                                        color: Color
                                                                            .fromRGBO(
                                                                                13,
                                                                                91,
                                                                                196,
                                                                                1),
                                                                      ),
                                                                    ),
                                                                    onPressed: () {
                                                                      //          Navigator.push(context,
                                                                      //            MaterialPageRoute(builder: (context) => Profile()));
                                                                      setState(() {
                                                                        break_start_end =
                                                                            !break_start_end;
                                                                        breakstart =
                                                                            DateTime.now()
                                                                                .toString();
          
                                                                        breakStartList.add(
                                                                            breakstart);
                                                                      });
                                                                    },
                                                                  ),
                                                                )
                                                              : Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.30,
                                                                  height: 45,
          
                                                                  child: TextButton(
                                                                    style: ButtonStyle(
                                                                      backgroundColor:
                                                                          MaterialStateProperty
                                                                              .all<Color>(
                                                                                  Colors
                                                                                      .white),
                                                                      shape: MaterialStateProperty
                                                                          .all<
                                                                              RoundedRectangleBorder>(
                                                                        RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius
                                                                                  .circular(
                                                                                      10.0),
                                                                          side:const BorderSide(
                                                                              color: Color
                                                                                  .fromRGBO(
                                                                                      13,
                                                                                      91,
                                                                                      196,
                                                                                      1),
                                                                              width: 1),
          
                                                                          //   side: BorderSide(color: Colors.red.shade900),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                      child:const Text(
                                                                      'Break End',
                                                                      style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize: 14.0,
                                                                        color: Color
                                                                            .fromRGBO(
                                                                                13,
                                                                                91,
                                                                                196,
                                                                                1),
                                                                      ),
                                                                    ),
                                                                    onPressed: () {
                                                                      //          Navigator.push(context,
                                                                      //            MaterialPageRoute(builder: (context) => Profile()));
          
                                                                      setState(() {
                                                                        break_start_end =
                                                                            !break_start_end;
                                                                        breakoff = DateTime
                                                                                .now()
                                                                            .toString();
                                                                        braeakEndList.add(
                                                                            breakoff);
                                                                        // BreakStartEndTimeRequest(
                                                                        //     breakstart,
                                                                        //     breakoff,
                                                                        //     jobid);
                                                                        _FunctionBreakCalutate();
          
                                                                        //   FunctionBreakCalculate();
                                                                        //  DialogFininshTime();
                                                                      });
                                                                    },
                                                                  ),
                                                                ),
                                                       const   SizedBox(
                                                            width: 10,
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              //    margin: EdgeInsets.symmetric(horizontal: 15 ,vertical: 14),
                                                              //   color: Color.fromRGBO(23, 197, 204, 1),
                                                              height: 45,
          
                                                              child: TextButton(
                                                                style: ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStateProperty
                                                                          .all<Color>(const Color
                                                                              .fromRGBO(
                                                                                  13,
                                                                                  91,
                                                                                  196,
                                                                                  1)),
                                                                  shape: MaterialStateProperty
                                                                      .all<
                                                                          RoundedRectangleBorder>(
                                                                    RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                                  10.0),
          
                                                                      //   side: BorderSide(color: Colors.red.shade900),
                                                                    ),
                                                                  ),
                                                                ),
                                                                  child:const Text(
                                                                  'Punch-Out',
                                                                  style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight.bold,
                                                                    fontSize: 14.0,
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  //          Navigator.push(context,
                                                                  //            MaterialPageRoute(builder: (context) => Profile()));
          
                                                                  setState(() {
                                                                    DialogFininshTime();
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                       const       SizedBox(
                                                height: 25,
                                              )
                                            ]),
                                          if (state.detailResponse.detail.record.status !=
                                              'Upcoming')
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.baseline,
                                                textBaseline: TextBaseline.alphabetic,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.baseline,
                                                        textBaseline:
                                                            TextBaseline.alphabetic,
                                                        children: [
                                                       const   Text(
                                                            'Start Time',
                                                            style: TextStyle(
                                                              fontFamily: 'Nunito Sans',
                                                              //  fontWeight: FontWeight.bold,
                                                              fontSize: 10.0,
                                                              color: Color.fromRGBO(
                                                                  112, 112, 112, 1),
                                                            ),
                                                          ),
                                                      const    SizedBox(
                                                            height: 10,
                                                          ),
                                                          if ( starttime.length >= 1)
                                                            for (int i = 0;
                                                                i < starttime.length;
                                                                i++)
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets.only(
                                                                        bottom: 9),
                                                                child: Text(
                                                                  starttime[i] != null
                                                                      ? DateFormat(
                                                                              'hh:mm:ss')
                                                                          .format(DateTime
                                                                              .parse(
                                                                                  starttime[
                                                                                      i]))
                                                                      : '',
                                                                  style:const TextStyle(
                                                                    fontFamily:
                                                                        'Nunito Sans',
                                                                    fontWeight:
                                                                        FontWeight.bold,
                                                                    fontSize: 14.0,
                                                                    color: Color.fromRGBO(
                                                                        0, 0, 0, 1),
                                                                  ),
                                                                ),
                                                              ),
                                                          if (starttime.length == 0)
                                                           const Text(
                                                              '0:00:00',
                                                              style: TextStyle(
                                                                fontFamily: 'Nunito Sans',
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                                fontSize: 14.0,
                                                                color: Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                              ),
                                                            )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.baseline,
                                                      textBaseline:
                                                          TextBaseline.alphabetic,
                                                      children: [
                                                     const   Text(
                                                          'End Time',
                                                          style: TextStyle(
                                                            fontFamily: 'Nunito Sans',
                                                            //  fontWeight: FontWeight.bold,
                                                            fontSize: 10.0,
                                                            color: Color.fromRGBO(
                                                                112, 112, 112, 1),
                                                          ),
                                                        ),
                                                      const  SizedBox(
                                                          height: 10,
                                                        ),
                                                        if (offtime.length >= 1)
                                                          for (int i = 0;
                                                              i < offtime.length;
                                                              i++)
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets.only(
                                                                      bottom: 9),
                                                              child: Text(
                                                                offtime[i] != null
                                                                    ? DateFormat(
                                                                            'hh:mm:ss')
                                                                        .format(DateTime
                                                                            .parse(
                                                                                offtime[
                                                                                    i]))
                                                                    : '',
                                                                style:const TextStyle(
                                                                  fontFamily:
                                                                      'Nunito Sans',
                                                                  fontWeight:
                                                                      FontWeight.bold,
                                                                  fontSize: 14.0,
                                                                  color: Color.fromRGBO(
                                                                      0, 0, 0, 1),
                                                                ),
                                                              ),
                                                            ),
                                                        if (offtime.length == 0)
                                                        const  Text(
                                                            '0:00:00',
                                                            style: TextStyle(
                                                              fontFamily: 'Nunito Sans',
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 14.0,
                                                              color: Color.fromRGBO(
                                                                  0, 0, 0, 1),
                                                            ),
                                                          )
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.baseline,
                                                      textBaseline:
                                                          TextBaseline.alphabetic,
                                                      children: [
                                                       const Text(
                                                          'Total Time',
                                                          style: TextStyle(
                                                            fontFamily: 'Nunito Sans',
                                                            //  fontWeight: FontWeight.bold,
                                                            fontSize: 10.0,
                                                            color: Color.fromRGBO(
                                                                112, 112, 112, 1),
                                                          ),
                                                        ),
                                                     const   SizedBox(
                                                          height: 10,
                                                        ),
                                                        for (int i = 0;
                                                            i < totaltime.length;
                                                            i++)
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets.only(
                                                                    bottom: 9),
                                                            child: Text(
                                                              totaltime[i]
                                                                  .toString()
                                                                  .split('.')
                                                                  .first,
                                                              style:const TextStyle(
                                                                fontFamily: 'Nunito Sans',
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                                fontSize: 14.0,
                                                                color: Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                              ),
                                                            ),
                                                          ),
                                                        if (totaltime.length == 0)
                                                      const    Text(
                                                            '0:00:00',
                                                            style: TextStyle(
                                                              fontFamily: 'Nunito Sans',
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 14.0,
                                                              color: Color.fromRGBO(
                                                                  0, 0, 0, 1),
                                                            ),
                                                          )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          if (state.detailResponse.detail.record.status !=
                                              'Upcoming')
                                         const   SizedBox(
                                              height: 15,
                                            ),
                                          if (state.detailResponse.detail.record.status !=
                                              'Upcoming')
                                            Padding(
                                              padding: const EdgeInsets.only(left: 20),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        alignment: Alignment.centerLeft,
                                                        child:const Text(
                                                          'Breaks',
                                                          style: TextStyle(
                                                            fontFamily: 'Nunito Sans',
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 14.0,
                                                            color: Color.fromRGBO(
                                                                13, 91, 196, 1),
                                                          ),
                                                        ),
                                                      ),
                                                   const   SizedBox(
                                                        width: 15,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          if (state.detailResponse.detail.record.status !=
                                              'Upcoming')
                                           const SizedBox(
                                              height: 10,
                                            ),
                                          if (state.detailResponse.detail.record.status !=
                                              'Upcoming')
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(20, 0, 8, 0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.baseline,
                                                textBaseline: TextBaseline.alphabetic,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.baseline,
                                                        textBaseline:
                                                            TextBaseline.alphabetic,
                                                        children: [
                                                    const      SizedBox(
                                                            height: 5,
                                                          ),
                                                      const    Text(
                                                            'Start Time',
                                                            style: TextStyle(
                                                              fontFamily: 'Nunito Sans',
                                                              //  fontWeight: FontWeight.bold,
                                                              fontSize: 10.0,
                                                              color: Color.fromRGBO(
                                                                  112, 112, 112, 1),
                                                            ),
                                                          ),
                                                         const SizedBox(
                                                            height: 5,
                                                          ),
                                                          if (breakStartList.length >= 1)
                                                            for (int i = 0;
                                                                i < breakStartList.length;
                                                                i++)
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .fromLTRB(0, 5, 0, 5),
                                                                child: Text(
                                                                  breakStartList[i] !=
                                                                          null
                                                                      ? DateFormat(
                                                                              'hh:mm:ss')
                                                                          .format(DateTime
                                                                              .parse(
                                                                                  breakStartList[
                                                                                      i]))
                                                                      : '---',
                                                                  style:const TextStyle(
                                                                    fontFamily:
                                                                        'Nunito Sans',
                                                                    fontWeight:
                                                                        FontWeight.bold,
                                                                    fontSize: 14.0,
                                                                    color: Color.fromRGBO(
                                                                        0, 0, 0, 1),
                                                                  ),
                                                                ),
                                                              ),
                                                          if (breakStartList.length == 0)
                                                         const   Text(
                                                              '0:00:00',
                                                              style: TextStyle(
                                                                fontFamily: 'Nunito Sans',
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                                fontSize: 14.0,
                                                                color: Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                              ),
                                                            ),
                                                      const    SizedBox(
                                                            height: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.baseline,
                                                      textBaseline:
                                                          TextBaseline.alphabetic,
                                                      children: [
                                                      const  Text(
                                                          'End Time',
                                                          style: TextStyle(
                                                            fontFamily: 'Nunito Sans',
                                                            //  fontWeight: FontWeight.bold,
                                                            fontSize: 10.0,
                                                            color: Color.fromRGBO(
                                                                112, 112, 112, 1),
                                                          ),
                                                        ),
                                                      const  SizedBox(
                                                          height: 5,
                                                        ),
                                                        if (braeakEndList.length >= 1)
                                                          for (int i = 0;
                                                              i < braeakEndList.length;
                                                              i++)
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .fromLTRB(0, 5, 0, 5),
                                                              child: Text(
                                                                braeakEndList[i] != null
                                                                    ? DateFormat(
                                                                            'hh:mm:ss')
                                                                        .format(DateTime
                                                                            .parse(
                                                                                braeakEndList[
                                                                                    i]))
                                                                    : '---',
                                                                style:const TextStyle(
                                                                  fontFamily:
                                                                      'Nunito Sans',
                                                                  fontWeight:
                                                                      FontWeight.bold,
                                                                  fontSize: 14.0,
                                                                  color: Color.fromRGBO(
                                                                      0, 0, 0, 1),
                                                                ),
                                                              ),
                                                            ),
                                                        if (braeakEndList.length == 0)
                                                         const Text(
                                                            '0:00:00',
                                                            style: TextStyle(
                                                              fontFamily: 'Nunito Sans',
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 14.0,
                                                              color: Color.fromRGBO(
                                                                  0, 0, 0, 1),
                                                            ),
                                                          )
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.baseline,
                                                      textBaseline:
                                                          TextBaseline.alphabetic,
                                                      children: [
                                                    const    Text(
                                                          'Total Time',
                                                          style: TextStyle(
                                                            fontFamily: 'Nunito Sans',
                                                            //  fontWeight: FontWeight.bold,
                                                            fontSize: 10.0,
                                                            color: Color.fromRGBO(
                                                                112, 112, 112, 1),
                                                          ),
                                                        ),
                                                    const    SizedBox(
                                                          height: 5,
                                                        ),
                                                        if (Breaklist.length >= 1)
                                                          for (int i = 0;
                                                              i < Breaklist.length;
                                                              i++)
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .fromLTRB(0, 5, 0, 5),
                                                              child: Text(
                                                                Breaklist[i]
                                                                    .toString()
                                                                    .split('.')
                                                                    .first,
                                                                style:const TextStyle(
                                                                  fontFamily:
                                                                      'Nunito Sans',
                                                                  fontWeight:
                                                                      FontWeight.bold,
                                                                  fontSize: 14.0,
                                                                  color: Color.fromRGBO(
                                                                      0, 0, 0, 1),
                                                                ),
                                                              ),
                                                            ),
                                                        if (Breaklist.length == 0)
                                                       const   Text(
                                                            '0:00:00',
                                                            style: TextStyle(
                                                              fontFamily: 'Nunito Sans',
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 14.0,
                                                              color: Color.fromRGBO(
                                                                  0, 0, 0, 1),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          if (state.detailResponse.detail.record.status !=
                                              'Upcoming')
                                        const    SizedBox(
                                              height: 10,
                                            ),
                                          if (state.detailResponse.detail.record.status !=
                                              'Upcoming')
                                            const Divider(
                                              height: 5,
                                              color: Colors.grey,
                                            ),
                                          if (state.detailResponse.detail.record.status !=
                                              'Upcoming')
                                          const  SizedBox(
                                              height: 10,
                                            ),
                                        const  SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      alignment: Alignment.centerLeft,
                                                      child:const Text(
                                                        'Shift Details',
                                                        style: TextStyle(
                                                          fontFamily: 'Nunito Sans',
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 14.0,
                                                          color: Color.fromRGBO(
                                                              13, 91, 196, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  const  SizedBox(
                                                      width: 15,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  state.detailResponse.detail.shifts.length,
                                              itemBuilder:
                                                  (BuildContext context, int index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(left: 20),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.baseline,
                                                    textBaseline: TextBaseline.alphabetic,
                                                    children: [
                                                      Expanded(
                                                          child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.baseline,
                                                        textBaseline:
                                                            TextBaseline.alphabetic,
                                                        children: [
                                                        const  Text(
                                                            'Shift Name',
                                                            style: TextStyle(
                                                              fontFamily: 'Nunito Sans',
                                                              //  fontWeight: FontWeight.bold,
                                                              fontSize: 10.0,
                                                              color: Color.fromRGBO(
                                                                  112, 112, 112, 1),
                                                            ),
                                                          ),
                                                         const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            //'Morning',
                                                            state.detailResponse.detail.shifts[index].name !=
                                                                    null
                                                                ? state.detailResponse.detail.shifts[index].name: ' ',
                                                            style:const TextStyle(
                                                              fontFamily: 'Nunito Sans',
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 14.0,
                                                              color: Color.fromRGBO(
                                                                  0, 0, 0, 1),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                      Expanded(
                                                          child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.baseline,
                                                        textBaseline:
                                                            TextBaseline.alphabetic,
                                                        children: [
                                                        const  Text(
                                                            'Start',
                                                            style: TextStyle(
                                                              fontFamily: 'Nunito Sans',
                                                              //  fontWeight: FontWeight.bold,
                                                              fontSize: 10.0,
                                                              color: Color.fromRGBO(
                                                                  112, 112, 112, 1),
                                                            ),
                                                          ),
                                                        const  SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            state.detailResponse.detail.shifts[index].timeFrom !=null
                                                                ? state.detailResponse.detail.shifts[index].timeFrom: ' ',
                                                            style:const TextStyle(
                                                              fontFamily: 'Nunito Sans',
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 14.0,
                                                              color: Color.fromRGBO(
                                                                  0, 0, 0, 1),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                      Expanded(
                                                          child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.baseline,
                                                        textBaseline:
                                                            TextBaseline.alphabetic,
                                                        children: [
                                                       const   Text(
                                                            'End',
                                                            style: TextStyle(
                                                              fontFamily: 'Nunito Sans',
                                                              //  fontWeight: FontWeight.bold,
                                                              fontSize: 10.0,
                                                              color: Color.fromRGBO(
                                                                  112, 112, 112, 1),
                                                            ),
                                                          ),
                                                         const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            state.detailResponse.detail.shifts[index].timeTo !=
                                                                    null
                                                                ? state.detailResponse.detail.shifts[index].timeTo: ' ',
                                                            style:const TextStyle(
                                                              fontFamily: 'Nunito Sans',
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 14.0,
                                                              color: Color.fromRGBO(
                                                                  0, 0, 0, 1),
                                                            ),
                                                          ),
                                                        ],
                                                      ))
                                                    ],
                                                  ),
                                                );
                                              }),
                                        const  SizedBox(
                                            height: 25,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.baseline,
                                              textBaseline: TextBaseline.alphabetic,
                                              children: [
                                                Container(
                                                  alignment: Alignment.centerLeft,
                                                  child:const Text(
                                                    'Shift Notes',
                                                    style: TextStyle(
                                                      fontFamily: 'Nunito Sans',
                                                      //  fontWeight: FontWeight.bold,
                                                      fontSize: 10.0,
                                                      color: Color.fromRGBO(
                                                          112, 112, 112, 1),
                                                    ),
                                                  ),
                                                ),
                                              const  SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(bottom: 37),
                                                  child: Text(
                                                    state.detailResponse.detail.record
                                                                .shiftNotes !=
                                                            ' '
                                                        ? state.detailResponse.detail.record.shiftNotes
                                                        : 'No Note',
                                                    style:const TextStyle(
                                                      fontFamily: 'Nunito Sans',
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 14.0,
                                                      color: Color.fromRGBO(0, 0, 0, 1),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                         const SizedBox(
                                            height: 25,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            const  SizedBox(
                                height: 35,
                              ),
                            ],
                          )
                  ),
                );
            }
            return Container();
            }      ),
    );
              }
  DialogStarttime() {
    DateTime now = DateTime.now();
    String showtimeStart = DateFormat('kk:mm').format(now);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return  AlertDialog(
            title: Column(
              children: [
             const   SizedBox(
                  height: 3,
                ),
                Text(
                  showtimeStart,
                  style:const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              const  SizedBox(
                  height: 8,
                ),
             const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 35,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side:const BorderSide(
                                    color: Color.fromRGBO(13, 91, 196, 1),
                                    width: 1),
                              ),
                            ),
                          ),
                           child:const Text(
                            '  Cancel  ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Color.fromRGBO(13, 91, 196, 1),
                            ),
                          ),
                          onPressed: () { Navigator.pop(context);
                            //          Navigator.push(context,
                            //            MaterialPageRoute(builder: (context) => Profile()));

                            // setState(() {
                            //   Navigator.pop(context);
                            // });
                          },
                        ),
                      ),
                    ),
               const     SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        //    margin: EdgeInsets.symmetric(horizontal: 15 ,vertical: 14),
                        //   color: Color.fromRGBO(23, 197, 204, 1),
                        height: 35,

                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(13, 91, 196, 1)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                           child:const Text(
                            '  Ok  ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            //          Navigator.push(context,
                            //            MaterialPageRoute(builder: (context) => Profile()));

                            setState(() {
                              in_out = !in_out;
                              workingStart = DateTime.now().toString();
                              starttime.add(workingStart);
                              Navigator.pop(context);

                              // StartEndTimeRequest(
                              //   workingStart,
                              //   workingOff,
                              //   jobid,
                              // );
                              // Navigator.pop(context);
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  DialogFininshTime() {
    DateTime now = DateTime.now();
    String showtimeEnd = DateFormat('kk:mm').format(now);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return  AlertDialog(
            title: Column(
              children: [
            const    SizedBox(
                  height: 3,
                ),
                Text(
                  showtimeEnd,
                  style:const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
           const     SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        //    margin: EdgeInsets.symmetric(horizontal: 15 ,vertical: 14),
                        //   color: Color.fromRGBO(23, 197, 204, 1),
                        height: 35,

                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side:const BorderSide(
                                    color: Color.fromRGBO(13, 91, 196, 1),
                                    width: 1),
                                //   side: BorderSide(color: Colors.red.shade900),
                              ),
                            ),
                          ),
                           child:const Text(
                            'Cancel',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Color.fromRGBO(13, 91, 196, 1),
                            ),
                          ),
                          onPressed: () {
                            //          Navigator.push(context,
                            //            MaterialPageRoute(builder: (context) => Profile()));
                            // setState(() {
                            //   Navigator.pop(context);
                            // });
                          },
                        ),
                      ),
                    ),
               const     SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        //    margin: EdgeInsets.symmetric(horizontal: 15 ,vertical: 14),
                        //   color: Color.fromRGBO(23, 197, 204, 1),
                        height: 35,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                               const Color.fromRGBO(13, 91, 196, 1)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                               ),
                               ),
                               ), 
                           child:const Text(
                            'Ok',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ), 
                          //      color: Colors.black,
                          //  textColor: Colors.white,
                          //     shape: RoundedRectangleBorder(
                          //borderRadius: BorderRadius.circular(30)),
                          onPressed: () {
                            //          Navigator.push(context,
                            //            MaterialPageRoute(builder: (context) => Profile()));

                            setState(() {
                              in_out = !in_out;
                              workingOff = DateTime.now().toString();
                              offtime.add(workingOff);
                              print(
                                  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa$break_start_end');
                              if (break_start_end == false) {
                                breakoff = DateTime.now().toString();
                                braeakEndList.add(breakoff);
                                DateTime v1 = DateTime.parse(breakstart);
                                DateTime v2 = DateTime.parse(breakoff);
                                breaks = v1.difference(v2);
                                print(
                                    'wwwwwwwww$v1 wwwwwwwwww$v2 wwwwwwwwwwwww$breaks');

                                Breaklist.add(breaks);
                                break_start_end = !break_start_end;
                              }
                              // _FunctionStartOffCalcutlate();
                              // _FunctionTotalCalculate();
                              // StartEndTimeRequest(
                              //     workingStart, workingOff, jobid);
                              workingOff = '';
                              Navigator.pop(context);
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
          _FunctionBreakCalutate() {
    int prevaluebreak = 0;
    Duration total_breaks;
    print('bbbbbbb$breakstart');
    print('bbbbbbb$breakoff');
    DateTime v1 = DateTime.parse(breakstart);
    DateTime v2 = DateTime.parse(breakoff);
    breaks = v1.difference(v2);
    print('wwwwwwwww$v1 wwwwwwwwww$v2 wwwwwwwwwwwww$breaks');

    Breaklist.add(breaks);
    for (int i = 0; i < Breaklist.length; i++) {
      print('ppppp${Breaklist[i]}');
      Breaklist[i] = Breaklist[i].toString().split('.').first;
      print('aaaaaaaaaaaaaa${Breaklist[i]}');
    }

    for (int i = 0; i < Breaklist.length; i++) {
      var breakbrakdown = Breaklist[i].toString().split(':');
      total_breaks =  Duration(
          hours: int.parse(breakbrakdown[0]),
          minutes: int.parse(breakbrakdown[1]),
          seconds: int.parse(breakbrakdown[2]) + prevaluebreak);
      prevaluebreak = total_breaks.inSeconds;
      print('ooooooo$prevaluebreak');
      breaak = total_breaks.toString();
      print('/////////////////////////////////////////////////////');
    }
    breakoff = '';
  }

  _FunctionStartOffCalcutlate() {
    var timeworking;
    print('ccccc$workingStart');
    print('cccc$workingOff');
    DateTime work = DateTime.parse(workingStart);
    DateTime finish = DateTime.parse(workingOff);
    timeworking = work.difference(finish);
    totaltime.add(timeworking);
  }

  _FunctionTotalCalculate() {
    int prevalue = 0;
    int prevaluebreak = 0;
   late Duration workhours;
   late Duration total_breaks;
    print('qqqqqqqqqqqqqq$totaltime');
    print('qqqqqqqqqqqqqq$Breaklist');
    for (int i = 0; i < totaltime.length; i++) {
      print('ppppp${totaltime[i]}');
      totaltime[i] = totaltime[i].toString().split('.').first;
      print('aaaaaaaaaaaaaa${totaltime[i]}');
    }
    for (int i = 0; i < totaltime.length; i++) {
      print('vvvvv${totaltime[i]}');
      var totalwoking = totaltime[i].split(':');

      workhours =  Duration(
          hours: int.parse(totalwoking[0]),
          minutes: int.parse(totalwoking[1]),
          seconds: int.parse(totalwoking[2]) + prevalue);
      prevalue = workhours.inSeconds;

      print('sssssss${workhours} ssssssssssss$prevalue ssssssssssssss');
    }
    for (int i = 0; i < Breaklist.length; i++) {
      print('ppppp${Breaklist[i]}');
      Breaklist[i] = Breaklist[i].toString().split('.').first;
      print('aaaaaaaaaaaaaa${Breaklist[i]}');
    }

    for (int i = 0; i < Breaklist.length; i++) {
      var breakbrakdown = Breaklist[i].toString().split(':');
      total_breaks =  Duration(
          hours: int.parse(breakbrakdown[0]),
          minutes: int.parse(breakbrakdown[1]),
          seconds: int.parse(breakbrakdown[2]) + prevaluebreak);
      prevaluebreak = total_breaks.inSeconds;
      print('ooooooo$prevaluebreak');

      print('/////////////////////////////////////////////////////');
    }
    print('jjjjjjjjjjj$workhours jjjjjjjjjjjjjjj$total_breaks');
    if (total_breaks == null) {
      //var c = DateFormat('hh:mm:ss').parse(workhours.toString());
      time = workhours.toString();
      print('eeeeeeeeeee$time');
    } else {
      breaak = total_breaks.toString();
      var a = DateFormat('hh:mm:ss').parse(workhours.toString());
      var b = DateFormat('hh:mm:ss').parse(total_breaks.toString());
      print('sssssss$a ssssssssssssss$b');
      time = a.difference(b);
      print('eeeeeeeeeee$time');
    }
  }

  _FunctionPayrate(var a) {
    print('aaaaaaaaaaaaaaaaaaaaaaaa$a');
    //  double d = double.parse(a);
    payrate = double.parse(a).toStringAsFixed(2); // '2.35'
    //  double inDouble = double.parse(inString);
    print('dddddddddds$payrate');
  }

  _FunctionOtPayrate(var b) {
    print('aaaaaaaaaaaaaaaaaaaaaaaa$b');
    //  double d = double.parse(a);
    otPayrate = double.parse(b).toStringAsFixed(2); // '2.35'
    //  double inDouble = double.parse(inString);
    print('dddddddddds$otPayrate');
  }

  }
  _FunctionPayrate(var a) {
    print('aaaaaaaaaaaaaaaaaaaaaaaa$a');
    //  double d = double.parse(a);
    payrate = double.parse(a).toStringAsFixed(2); // '2.35'
    //  double inDouble = double.parse(inString);
    print('dddddddddds$payrate');
  }

  _FunctionOtPayrate(var b) {
   try {
    print('aaaaaaaaaaaaaaaaaaaaaaaa$b');
    otPayrate = double.parse(b).toStringAsFixed(2);
    print('dddddddddds$otPayrate');
  } catch (e) {
    print('Error parsing double: $e');
    // Handle the error here, such as setting otPayrate to a default value or showing an error message.
  }
}
_FunctionBreakCalutate() {
    int prevaluebreak = 0;
    Duration total_breaks;
    print('bbbbbbb$breakstart');
    print('bbbbbbb$breakoff');
    DateTime v1 = DateTime.parse(breakstart);
    DateTime v2 = DateTime.parse(breakoff);
    breaks = v1.difference(v2);
    print('wwwwwwwww$v1 wwwwwwwwww$v2 wwwwwwwwwwwww$breaks');

    Breaklist.add(breaks);
    for (int i = 0; i < Breaklist.length; i++) {
      print('ppppp${Breaklist[i]}');
      Breaklist[i] = Breaklist[i].toString().split('.').first;
      print('aaaaaaaaaaaaaa${Breaklist[i]}');
    }

    for (int i = 0; i < Breaklist.length; i++) {
      var breakbrakdown = Breaklist[i].toString().split(':');
      total_breaks = new Duration(
          hours: int.parse(breakbrakdown[0]),
          minutes: int.parse(breakbrakdown[1]),
          seconds: int.parse(breakbrakdown[2]) + prevaluebreak);
      prevaluebreak = total_breaks.inSeconds;
      print('ooooooo$prevaluebreak');
      breaak = total_breaks.toString();
      print('/////////////////////////////////////////////////////');
    }
    breakoff = '';
  }
  }

  