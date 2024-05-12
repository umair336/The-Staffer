import 'dart:ffi';
import 'package:TheStafferEmployee/screens/assignment/Model/Network_Calls/assignment_Network_call.dart';
import 'package:TheStafferEmployee/screens/assignment/assignment_bloc/bloc/assignment_bloc.dart';
import 'package:TheStafferEmployee/screens/assignment/assignment_bloc/bloc/assignment_event.dart';
import 'package:TheStafferEmployee/screens/assignment/assignment_bloc/bloc/assignment_state.dart';
import 'package:TheStafferEmployee/screens/home/home_bloc/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../constants/formate.dart';
import '../Model/assignment_model/assignmentapi.dart';
import 'assignmentdetail.dart';
import 'package:TheStafferEmployee/style/theme.dart' as Style;

class PastAssignment extends StatefulWidget {
  @override
  _PastAssignmentState createState() => _PastAssignmentState();
}

class _PastAssignmentState extends State<PastAssignment> {
  String valueexist = "";

@override
  void initState() {
    // TODO: implement initState
    super.initState();
        context.read<AssignmentBloc>().add(GetAssignmentDataEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AssignmentBloc, AssignmentState>(
        builder: (context, state) {
          if (state is AssignmentLoadingState) {
            print('Past assignment is loading');
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [CircularProgressIndicator()],
              ),
            );
          }
          else if(state is AssignmentErrorState){
                print('Assignment data error');
                return Center(
                  child: Column(
                    children: [Text('data not fetch${state.message}')],
                  ),
                );
              }
           else if (state is AssignmentLoadedState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      child: SingleChildScrollView(
                          physics: const ScrollPhysics(),
                          child: Column(
                            children: <Widget>[
                              if (state.assignmentResponse.data.length >= 1)
                                for (int i = 0;
                                    i < state.assignmentResponse.data.length;
                                    i++)
                                  Container(
                                    child: _checkexist(
                                       state.assignmentResponse.data[i].empStatus,
                                       state.assignmentResponse.data[i].jobId),
                                  ),
                              ListView.builder(
                                  physics:
                                      const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.assignmentResponse.data.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        if (state.assignmentResponse.data[index]
                                                .empStatus ==
                                            'Completed')
                                          Padding(
                                              // padding: const EdgeInsets.all(20.0),
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 20, 5),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Assignmentdetail(
                                                                jobid: state.assignmentResponse
                                                                    .data[
                                                                        index]
                                                                    .jobId,
                                                              )));
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: const Color
                                                          .fromRGBO(
                                                          255, 255, 255, 1),
                                                      //   color: Colors.white60,
                                                      border: Border.all(
                                                          color: const Color
                                                              .fromRGBO(79,
                                                              171, 247, 1)),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  5))),
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                10, 0, 10, 0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                          8),
                                                              child:
                                                                  Container(
                                                                child: Text(
                                                                    state.assignmentResponse.data[index].jobPosition !=
                                                                            null? state.assignmentResponse.data[index].jobPosition: ' ',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight: FontWeight
                                                                            .w600,
                                                                        fontSize:
                                                                            19.0)),
                                                              ),
                                                            ),
                                                            Image.asset(
                                                              "images/Path 58358@2x.png",
                                                              height: 15,
                                                              // fit: BoxFit.cover,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 20),
                                                        child: Container(
                                                          alignment: Alignment
                                                              .topLeft,
                                                          child: Text(
                                                              state.assignmentResponse.data[index].customer !=
                                                                      null? state.assignmentResponse.data[index].customer: '',
                                                              style:
                                                                  const TextStyle(
                                                                      color: Color.fromRGBO(
                                                                          112,
                                                                          112,
                                                                          112,
                                                                          1),
                                                                      //fontWeight: FontWeight.w600,
                                                                      fontSize:
                                                                          10.0)),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                18, 0, 20, 0),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .baseline,
                                                                textBaseline:
                                                                    TextBaseline
                                                                        .alphabetic,
                                                                children: [
                                                                  const Text(
                                                                      "Start Date ",
                                                                      style: TextStyle(
                                                                          color: Color.fromRGBO(112, 112, 112, 1),
                                                                          //fon textAlign: TextAlign.left,tWeight: FontWeight.w600,
                                                                          fontSize: 10.0)),
                                                                  const SizedBox(
                                                                    height: 2,
                                                                  ),
                                                                  Container(
                                                                      child:Text(state.assignmentResponse.data[index].startDate.toString() != null ? 
                                                                              DateFormat(state.formateResponse.data[0].currentDateFormat).
                                                                              format(DateTime.parse(state.assignmentResponse.data.first.startDate.toString())) : ' - - - ',
                                                                                  style: const TextStyle(
                                                                                      color: Color.fromRGBO(0, 0, 0, 1),
                                                                                      //fontWeight: FontWeight.w600,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontSize: 14.0))),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                          60),
                                                              child:
                                                                  Container(
                                                                child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .baseline,
                                                                    textBaseline:
                                                                        TextBaseline
                                                                            .alphabetic,
                                                                    children: [
                                                                      const Text(
                                                                          "End Date   ",
                                                                          style: TextStyle(
                                                                              color: Color.fromRGBO(112, 112, 112, 1),
      
                                                                              //fontWeight: FontWeight.w600,
                                                                              fontSize: 10.0)),
                                                                      const SizedBox(
                                                                        height:
                                                                            2,
                                                                      ),
                                                                      state.assignmentResponse.data[index].endDate !=
                                                                              null
                                                                          ? Container(
                                                                              child: Text(DateFormat(state.formateResponse.data[0].currentDateFormat).
                                                                              format(DateTime.parse(state.assignmentResponse.data[index].endDate)),
                                                                                          style: const TextStyle(
                                                                                              color: Color.fromRGBO(0, 0, 0, 1),
                                                                                              //fontWeight: FontWeight.w600,
                                                                                              fontWeight: FontWeight.bold,
                                                                                              fontSize: 14.0)))
                                                                          : Container(
                                                                              child:Text(DateFormat(state.formateResponse.data[0].currentDateFormat).
                                                                              format(DateTime.parse(state.assignmentResponse.data[index].jobEndDate)),
                                                                                          style: const TextStyle(
                                                                                              color: Color.fromRGBO(0, 0, 0, 1),
                                                                                              //fontWeight: FontWeight.w600,
                                                                                              fontWeight: FontWeight.bold,
                                                                                              fontSize: 14.0)))
                                                                    ]),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ))
                                      ],
                                    );
                                  }),
                              const SizedBox(
                                height: 20,
                              ),
                              valueexist == ''
                                  ? const Text(
                                      'No Finished Assignment',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Nunito Sans',
                                          color: Color.fromRGBO(
                                              112, 112, 112, 1)),
                                    )
                                  : const Text('')
                            ],
                          ))),
                ],
              ),
            );
          }return Container();
        },
      ),
    );
  }
    _checkexist(var value, var value2) {
    print('yyyyyyyyyyyyyy$value yyyyyyyyy $value2');
    // valueexist
    if (value == "Completed") {
      print('aaaaaaaaaaaa');
      valueexist = "qqqqqq".toString();
    } else {
      print('vvvvvvvvvv');
    }
  }
}
        



