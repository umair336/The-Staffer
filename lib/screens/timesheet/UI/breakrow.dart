import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Model/breakmodelclasss.dart';
import 'addtimesheet.dart';
import 'dart:ffi';

class Contact extends StatefulWidget {
  Breaktimeing timer;
  Contact(this.timer);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  late TimeOfDay _t;
  late TimeOfDay _pp;
  String s = '00:00';
  String e = '00:00';
  bool selectstart = false;
  bool selectend = false;
  bool timeount_false = false;
  String breakdifference = "";
  bool isSwitched = false;

  var textValue = 'Unpaid';

  void toggleSwitch(bool value) {
    if (widget.timer.switched == false) {
      setState(() {
        widget.timer.switched = true;
        widget.timer.switchedvalue = 'Paid';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        widget.timer.switched = false;
        widget.timer.switchedvalue = 'Unpaid';
      });
      print('Switch Button is OFF');
    }
  }

  @override
  void initState() {
    super.initState();

    _t = TimeOfDay.now();
    _pp = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _openTimePiker(BuildContext context) async {
      final t = await showTimePicker(context: context, initialTime: _t);

      if (t != null) {
        setState(() {
          widget.timer.selectTime = t.format(context);
          _t = t;
          selectstart = true;
          if (timeount_false == true) {
            ////
          }

          timeount_false = true;
        });
      }
    }

    Future<void> _openTimePikerr(BuildContext context) async {
      if (timeount_false == true) {
        final p = await showTimePicker(context: context, initialTime: _pp);
        if (p != null) {
          setState(() {
            widget.timer.seletedTime = p.format(context);
            _pp = p;
            selectend = true;
            ////
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Select Start time"),
            backgroundColor: Color.fromRGBO(183, 14, 105, 1)));
      }
    }

    return Container(
      child: Stack(
        //  fit: StackFit.passthrough,
        clipBehavior: Clip.none,
        children: <Widget>[
          // Max Size
          Positioned(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
              child: Container(
                //  color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _openTimePiker(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 5, 0, 0),
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                // time,
                                                'Start Time',
                                                // widget.timer.paidunpaid,
                                                style: TextStyle(
                                                    //    fontWeight: FontWeight.bold,
                                                    fontSize: 10.0,
                                                    color: Color.fromRGBO(
                                                        112, 112, 112, 1)),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 5, 0, 0),
                                            child: Container(
                                              child: selectstart == true
                                                  ? Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        widget.timer.selectTime,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14.0,
                                                            color:
                                                                Color.fromRGBO(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    1)),
                                                      ),
                                                    )
                                                  : Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        s,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14.0,
                                                            color:
                                                                Color.fromRGBO(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    1)),
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              _openTimePikerr(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 5, 0, 0),
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              'End Time',
                                              style: TextStyle(
                                                  //    fontWeight: FontWeight.bold,
                                                  fontSize: 10.0,
                                                  color: Color.fromRGBO(
                                                      112, 112, 112, 1)),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 5, 0, 0),
                                          child: Container(
                                            child: selectend == true
                                                ? Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      widget.timer.seletedTime,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14.0,
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1)),
                                                    ),
                                                  )
                                                : Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      e,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14.0,
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1)),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  )
                                ],
                              ),
                            ),
                          )),
                          const SizedBox(
                            width: 25,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 7,
            bottom: 0,
            left: 208,
            right: -25,
            child: Text(
              '${widget.timer.switchedvalue}',
              style: const TextStyle(fontSize: 6),
            ),
          ),
          Positioned(
              top: 5,
              bottom: 5,
              left: 190,
              right: -25,
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.scale(
                          scale: 1,
                          child: Switch(
                            onChanged: toggleSwitch,
                            value: widget.timer.switched,
                            activeColor: Colors.white,
                            activeTrackColor: Color.fromRGBO(183, 14, 105, 1),
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor:
                                Color.fromRGBO(112, 112, 112, 1),
                          )),
                    ]),
              ))
        ],
      ),
    );
  }
}
