// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as s;



class TimeSheetModel {
  late List<Timesheet> timesheet;

  TimeSheetModel({
    required this.timesheet,
  });

  TimeSheetModel.fromJson(Map<String, dynamic> json) {
    if (json['timesheet'] != null) {
      timesheet = <Timesheet>[];
      json['timesheet'].forEach((v) {
        timesheet.add(new Timesheet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timesheet != null) {
      data['timesheet'] = this.timesheet.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Timesheet {
 late int id;
 late int parentId;
 late int employeeJobId;
 late int customerId;
 late int departmentId;
 late int employeeId;
 late String hoursForWeek;
 late String createdAt;
 late String updatedAt;
 late int payrollStatus;
 late String overtimeHours;
 late String regularHours;
 late String timesheetType;
 late String customerName;

 late int overRate;
 late String jobPosition;

  Timesheet(
      {required this.id,
     required this.parentId,
     required this.employeeJobId,
     required this.customerId,
     required this.departmentId,
     required this.employeeId,
     required this.hoursForWeek,
     required this.createdAt,
     required this.updatedAt,
     required this.payrollStatus,
     required this.overtimeHours,
     required this.regularHours,
     required this.timesheetType,
     required this.customerName,
     required this.overRate,
     required this.jobPosition});

  Timesheet.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    parentId = json['parent_id']??0;
    employeeJobId = json['employee_job_id']??0;
    customerId = json['customer_id']??0;
    departmentId = json['department_id']??0;
    employeeId = json['employee_id']??0;
    hoursForWeek = json['hours_for_week']??'';
    createdAt = json['created_at']??'';
    updatedAt = json['updated_at']??'';
    payrollStatus = json['payroll_status']??0;
    overtimeHours = json['overtime_hours']??'';
    regularHours = json['regular_hours']??'';
    timesheetType = json['timesheet_type']??'';
    customerName = json['customer_name']??'';
    // overRate = json['over_rate'];
    jobPosition = json['job_position']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['employee_job_id'] = this.employeeJobId;
    data['customer_id'] = this.customerId;
    data['department_id'] = this.departmentId;
    data['employee_id'] = this.employeeId;
    data['hours_for_week'] = this.hoursForWeek;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    data['payroll_status'] = this.payrollStatus;

    data['overtime_hours'] = this.overtimeHours;
    data['regular_hours'] = this.regularHours;
    data['timesheet_type'] = this.timesheetType;
    data['customer_name'] = this.customerName;

    // data['over_rate'] = this.overRate;
    data['job_position'] = this.jobPosition;
    return data;
  }
}
