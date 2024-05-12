import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ffi';

class Breaktimeing {
  String seletedTime;
  String selectTime;
  bool switched;
  var switchedvalue;

  Breaktimeing(
      this.selectTime, this.seletedTime, this.switched, this.switchedvalue);
}
/*
calculate(time, seletTime, seletedTime) {
  String breakdiff = "";
  print("toaltime is $time");
  print("break start is $seletTime");
  print("break end is $seletedTime");
  var format = DateFormat("hh:mm a");
  var starttime = format.parse(seletTime);
  var endtime = format.parse(seletedTime);
  print('oooooooooooooooooooooooo$starttime oooooooooooooooooooooo$endtime');
  if (starttime.isAfter(endtime)) {
    print('start is big');
    print('difference = ${starttime.difference(endtime)}');
    breakdiff = starttime.difference(endtime).toString();
    String x = "24:00";
    var f = DateFormat("hh:mm");
    var c = f.parse(x);
    var b = f.parse(breakdiff);
    print('fffffffffffffffffffff$c ffffffffffffff$b');
    breakdiff = c.difference(b).toString();
  } else if (starttime.isBefore(endtime)) {
    print('end is big'); // correct val
    print('difference = ${endtime.difference(starttime)}');
    breakdiff = endtime.difference(starttime).toString();
    // time = time.substring(0, 4);
  } else {
    print('difference === ${endtime.difference(starttime)}');
    breakdiff = endtime.difference(starttime).toString();
    //ime = time.substring(0, 4);
  }

  print('dddddddddddddddddddddddd$breakdiff');

  breakdiff = breakdiff.replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
  print('////////////$breakdiff//////////////$time////');

  var fo = DateFormat("hh:mm");
  var n = fo.parse(breakdiff);
  var m = fo.parse(time);

  time = m.difference(n);

  print('uuuuuuuuuuuuuuuuu$time');

  return time;
}
*/