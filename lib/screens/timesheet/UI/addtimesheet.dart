import 'dart:math';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:intl/date_symbol_data_local.dart';
import '../Model/breakmodelclasss.dart';
import 'breakrow.dart';

class Addtimesheet extends StatefulWidget {
  @override
  _AddtimesheetState createState() => _AddtimesheetState();
}

class ListItem {
  int value;
  String name;
  ListItem(this.value, this.name);
}

class _AddtimesheetState extends State<Addtimesheet> {
  final List<Contact> _items = [];
  String time = "";
  int _count = 1;
  int _value = 1;
  List totalbreak = [];
  List breaktime = [];
  List<String> numbers = [];
  List<ListItem> _dropdownItems = [
    ListItem(1, "one Value"),
    ListItem(2, "Second Item"),
    ListItem(3, "Third Item"),
    ListItem(4, "Fourth Item")
  ];
  DateTime now = DateTime.now();
  // String _seletedTime = DateFormat('h:mm a').format(DateTime.now());
  //String _seletTime = DateFormat('h:mm a').format(DateTime.now());
  String _seletedTime = "00:00 ";
  String _seletTime = "00:00";

  String start = "";
  String startDate = DateFormat('EEE d MMM, y ').format(DateTime.now());
  late TimeOfDay _t;
  late TimeOfDay _pp;

  bool timeount_false = false;
  bool save = false;

  late String paidunpaid;

  String checkstart = "";
  String checkend = "";
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    loadData(startDate);
    _t = TimeOfDay.now();
    _pp = TimeOfDay.now();
  }

  void loadData(start) {
    print('------date-----');
    print(start);
    print('------time-----');
    // var now = new DateTime.now();

    //  String formattedTime = DateFormat('kk:mm:a').format(now);
    // print(formattedTime);

    final Object _data = {
      "customer": "",
      "start_date": "Aug 22, 2021",
      "end_date": "Sep 04, 2021",
      //"start_date": start,
      //"end_date": end,
      "vendors": "",
      "week_ends": "",
      "branch": "",
      "date_format": "M",
    };
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Future<void> _openTimePicker(BuildContext context) async {
      final t = await showTimePicker(context: context, initialTime: _t);

      if (t != null) {
        setState(() {
          _seletedTime = t.format(context);
          checkstart = _seletedTime;
          _t = t;
          print('aaaaaaaaaaaaaaaaaa $t');

          print(_seletedTime);
          if (timeount_false == true) {
            timecalculate();
            breekcalculation();
            checkbreaktime();
            //  removeTrailingZeros();
          }

          timeount_false = true;
        });
      }
    }

    Future<void> _openTimePiker(BuildContext context) async {
      if (timeount_false == true) {
        final p = await showTimePicker(context: context, initialTime: _pp);

        if (p != null) {
          setState(() {
            _seletTime = p.format(context);
            checkend = _seletTime;
            _pp = p;
            print('aaaaaaaaaaaaa');
            print(_seletTime);
            timecalculate();
            breekcalculation();
            checkbreaktime();
            print('iiiiiiiiiiiiii$time');
            save = true;
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Select Start time"),
          backgroundColor: Color.fromRGBO(183, 14, 105, 1),
        ));
      }
    }

    // final items = ContactRow();
    //  ContactRow contactRow = new ContactRow();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
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
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 7, 0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Color.fromRGBO(255, 255, 255, 1),
                            size: 20,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          'Add Time Sheet',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35,
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
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Date',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Color.fromRGBO(13, 91, 196, 1)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          child: InkWell(
                            onTap: () {
                              _selectStart(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            'Date',
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
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            startDate,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0,
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1)),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 5, 20, 0),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Image.asset(
                                      "images/Path 57123@2x.png",
                                      height: size.height * 0.02,
                                      // fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Time Out',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Color.fromRGBO(13, 91, 196, 1)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                child: InkWell(
                                  onTap: () {
                                    _openTimePicker(context);
                                  },
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
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 5, 0, 0),
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: const Text(
                                                  'Start Time',
                                                  style: TextStyle(
                                                      //    fontWeight: FontWeight.bold,
                                                      fontSize: 10.0,
                                                      color: Color.fromRGBO(
                                                          112, 112, 112, 1)),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 5, 0, 0),
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  _seletedTime,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.0,
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1)),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 5, 10, 0),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Image.asset(
                                            "images/Path 57125@2x.png",
                                            height: size.height * 0.02,
                                            // fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                child: InkWell(
                                  onTap: () {
                                    _openTimePiker(context);
                                  },
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
                                              padding:
                                                  const EdgeInsets.fromLTRB(
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
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 5, 0, 0),
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  _seletTime,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.0,
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1)),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 5, 10, 0),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Image.asset(
                                            "images/Path 57125@2x.png",
                                            height: size.height * 0.02,
                                            // fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Breaks',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color: Color.fromRGBO(13, 91, 196, 1)),
                              ),
                            ),
                            Container(
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    bool switched = false;
                                    var switchedvalue = 'Unpaid';
                                    String _seletedTime = DateFormat('h:mm a')
                                        .format(DateTime.now());
                                    String _seletTime = DateFormat('h:mm a')
                                        .format(DateTime.now());
                                    _items.add(Contact(Breaktimeing(
                                        _seletTime,
                                        _seletedTime,
                                        switched,
                                        switchedvalue)));
                                    debugPrint(_items.length.toString());
                                    //                        timecalculate();
                                    //   breekcalculation();
                                  });
                                },
                                child: Image.asset(
                                  "images/Group 12823@2x.png",
                                  height: size.height * 0.04,
                                  //fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        )),
                    ListView.builder(
                      padding: const EdgeInsets.only(top: 3),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: _items[index],
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                _items.removeAt(index);
                                var snackBar =
                                    SnackBar(content: Text('$index deleted!'));
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);
                                // timecalculate();
                                // breekcalculation();
                              });
                            },
                            icon: Image.asset(
                              "images/003-trash@2x.png",
                              height: 22,
                              width: 18,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              'Total Time:',
                              style: TextStyle(
                                  //    fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                  color: Color.fromRGBO(112, 112, 112, 1)),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  time.toString() ?? "select time",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                      color: Color.fromRGBO(13, 91, 196, 1)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 13,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 70,
                            ),
                            Positioned(
                              bottom: 0,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Container(
                                    width: 300,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      border: Border.all(
                                          color: Colors.grey.shade200,
                                          width: 1.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: DropdownButton(
                                            value: _value,
                                            items: _dropdownItems
                                                .map((ListItem item) {
                                              return DropdownMenuItem<int>(
                                                child: Text(item.name),
                                                value: item.value,
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                _value = value!;
                                              });
                                            },
                                            hint: Text("Select item"),
                                            disabledHint: Text("Disabled"),
                                            elevation: 8,
                                            style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    112, 112, 112, 1),
                                                fontSize: 16),
                                            //  icon: Icon(Icons.arrow_drop_down_circle),
                                            iconDisabledColor: Colors.red,
                                            iconEnabledColor:
                                                Color.fromRGBO(183, 14, 105, 1),
                                            isExpanded: true,
                                            underline: Container(
                                                color: Colors.transparent),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: 13,
                              child: Container(
                                  color: Colors.white,
                                  child: const Text(
                                    'Assignments',
                                    style: TextStyle(

                                        // fontWeight: FontWeight.bold,

                                        fontSize: 13.0,
                                        color: Color.fromRGBO(83, 83, 83, 1)),
                                  )),
                            ),
                            Positioned(
                              right: 20,
                              top: 35,
                              child: Container(
                                color: Colors.white,
                                child: Image.asset(
                                  "images/icon-navigation-chevron_left_24px@2x.png",
                                  height: size.height * 0.03,
                                  // fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 82,
                            ),
                            Positioned(
                              bottom: 0,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Container(
                                    width: 300,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      border: Border.all(
                                          color: Colors.grey.shade200,
                                          width: 1.0),
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Container(
                                            height: 60,
                                            child: const TextField(
                                              maxLines: 3,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: '',
                                                //      maxLines: 3,
                                                hintStyle: TextStyle(

                                                    // fontWeight: FontWeight.bold,

                                                    fontSize: 14.0,
                                                    color: Color.fromRGBO(
                                                        112, 112, 112, 1)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              bottom: 69,
                              child: Container(
                                  color: Colors.white,
                                  child: const Text(
                                    'Shift Notes',
                                    style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 13.0,
                                        color: Color.fromRGBO(83, 83, 83, 1)),
                                  )),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                height: 45,
                // height: MediaQuery.of(context).size.height * 0.08,
                width: 315,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(13, 91, 196, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    breaktime.add(
                      _seletedTime,
                    );
                    breaktime.add(
                      _seletTime,
                    );

                    if (save == true) {
                      setState(() {
                        timecalculate();
                        breekcalculation();
                        checkbreaktime();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Time saved successfully"),
                          backgroundColor: Color.fromRGBO(183, 14, 105, 1),
                        ));
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Select timeing of job"),
                        backgroundColor: Color.fromRGBO(183, 14, 105, 1),
                      ));
                    }
                    totalbreak.add(breaktime);

                    print("start Date is $startDate");
                    print("check in $_seletedTime");
                    print("check out $_seletTime,");
                    print("Assignment is $_value,");
                    print("Break timings is  $totalbreak ");
                    breaktime.removeLast();
                    breaktime.removeLast();

                    print('&&&&&&&&&&');
                  },
                  child: const Text(
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
            const SizedBox(
              height: 25,
            ),
            /*
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                //    margin: EdgeInsets.symmetric(horizontal: 15 ,vertical: 14),
                //   color: Color.fromRGBO(23, 197, 204, 1),
                height: 45,
                // height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.92,
                child: TextButton(
                  child: Text(
                    _seletedTime,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),

                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(13, 91, 196, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),

                        //   side: BorderSide(color: Colors.red.shade900),
                      ),
                    ),
                  ),
                  //      color: Colors.black,
                  //  textColor: Colors.white,
                  //     shape: RoundedRectangleBorder(
                  //borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    _openTimePicker(context);
                  },
                ),
              ),
            ),*/
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  _selectStart(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
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
            child: child ?? Container());
      },
    );
    if (selected != null)
      setState(() {
        startDate = DateFormat('EEE d, y').format(selected);
      });
  }

  void _addNewContactRow() {
    setState(() {
      _count = _count + 1;
    });
  }

  timecalculate() {
    print("gggggggggg$_seletTime gggggggggg$_seletedTime");
    var format = DateFormat("hh:mm a");
    var starttime = format.parse(_seletedTime);
    var endtime = format.parse(_seletTime);
    print('bbbbbbbbbbbbb$starttime and $endtime');
    if (starttime.isAfter(endtime)) {
      print('start is big');
      print('difference = ${starttime.difference(endtime)}');
      time = starttime.difference(endtime).toString();
      String x = "24:00";
      var f = DateFormat("hh:mm");
      var c = f.parse(x);
      var b = f.parse(time);
      print('ffffffffffff$c ffffffff$b');
      time = c.difference(b).toString();
    } else if (starttime.isBefore(endtime)) {
      print('end is big'); // correct val
      print('difference = ${endtime.difference(starttime)}');
      time = endtime.difference(starttime).toString();
      // time = time.substring(0, 4);
    } else {
      print('difference === ${endtime.difference(starttime)}');
      time = endtime.difference(starttime).toString();
      //ime = time.substring(0, 4);
    }

    print('dddddddddtimddd$e');
    removeTrailingZeros();
  }

  removeTrailingZeros() {
    time = time.replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
    print('ggggggggggg$time');
    if (time.startsWith("-")) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Select accurate time "),
        backgroundColor: Color.fromRGBO(183, 14, 105, 1),
      ));
    } else {
      return time;
    }
  }

  breekcalculation() {
    String breaak = "";
    print('hhhhhhhhhhh${_items.length}');
    for (int i = 0; i < _items.length; i++) {
      var format = DateFormat("hh:mm a");
      var starttime = format.parse(_items[i].timer.selectTime);
      var endtime = format.parse(_items[i].timer.seletedTime);
      print('bbbbbbbbbbb$starttime and $endtime');
      if (starttime.isAfter(endtime)) {
        print('start is big');
        print('difference = ${starttime.difference(endtime)}');
        breaak = starttime.difference(endtime).toString();
        String x = "24:00";
        var f = DateFormat("hh:mm");
        var c = f.parse(x);
        var b = f.parse(breaak);
        print('ffffffffff$c fffffff$b');
        breaak = c.difference(b).toString();
      } else if (starttime.isBefore(endtime)) {
        print('end is big'); // correct val
        print('difference = ${endtime.difference(starttime)}');
        breaak = endtime.difference(starttime).toString();
        // time = time.substring(0, 4);
      } else {
        print('difference === ${endtime.difference(starttime)}');
        breaak = endtime.difference(starttime).toString();
      }
      print('dddddddddddddd$breaak');
      var fomat = DateFormat("h:m");
      var w = fomat.parse(time);
      var b = fomat.parse(breaak);
      time = w.difference(b).toString();
      removeTrailingZeros();
      print('hhhhhhhhhhhhh$time');
    }
  }

  checkbreaktime() {
    for (int i = 0; i < _items.length; i++) {
      var format = DateFormat("hh:mm a");
      var cs = format.parse(checkstart);
      var ce = format.parse(checkend);
      var s = format.parse(_items[i].timer.selectTime);
      var e = format.parse(_items[i].timer.seletedTime);
      print(" dddddddddddddd$s ddddddddddddddddddd$e");
      if (s.isAfter(cs) && ce.isBefore(s)) {
        print('kkkkkkkkkkkkkkkkkkkkkcorrect');
      } else if (s.isBefore(cs)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "Select accurate break time of break between checkin and checkout"),
          backgroundColor: Color.fromRGBO(183, 14, 105, 1),
        ));
        print('Wrong Start time');
      } else {
        print('lllllllcorrect');
      }
    }
  }
}
