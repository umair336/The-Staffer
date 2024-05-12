// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
    final List<Datum> data;

    HomeModel({
        required this.data,
    });

    HomeModel copyWith({
        List<Datum>? data,
    }) => 
        HomeModel(
            data: data ?? this.data,
        );

    factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    final String totalWeeklyHours;
    final String prevWeeklyHours;
    final String empName;
    final String profilePic;
    final List<Assignment> assignments;
    final int earnings;
    final int prevEarnings;
    final int pending;
    final int shifts;
    final String startDate;
    final DateTime endDate;
    final String prevWeekStart;
    final String prevWeekEnd;
    final String currentDateFormat;
    final String currencyformat;

    Datum({
        required this.totalWeeklyHours,
        required this.prevWeeklyHours,
        required this.empName,
        required this.profilePic,
        required this.assignments,
        required this.earnings,
        required this.prevEarnings,
        required this.pending,
        required this.shifts,
        required this.startDate,
        required this.endDate,
        required this.prevWeekStart,
        required this.prevWeekEnd,
        required this.currentDateFormat,
        required this.currencyformat,
    });

    Datum copyWith({
        String? totalWeeklyHours,
        String? prevWeeklyHours,
        String? empName,
        String? profilePic,
        List<Assignment>? assignments,
        int? earnings,
        int? prevEarnings,
        int? pending,
        int? shifts,
        String? startDate,
        DateTime? endDate,
        String? prevWeekStart,
        String? prevWeekEnd,
        String? currentDateFormat,
        String? currencyformat,
    }) => 
        Datum(
            totalWeeklyHours: totalWeeklyHours ?? this.totalWeeklyHours,
            prevWeeklyHours: prevWeeklyHours ?? this.prevWeeklyHours,
            empName: empName ?? this.empName,
            profilePic: profilePic ?? this.profilePic,
            assignments: assignments ?? this.assignments,
            earnings: earnings ?? this.earnings,
            prevEarnings: prevEarnings ?? this.prevEarnings,
            pending: pending ?? this.pending,
            shifts: shifts ?? this.shifts,
            startDate: startDate ?? this.startDate,
            endDate: endDate ?? this.endDate,
            prevWeekStart: prevWeekStart ?? this.prevWeekStart,
            prevWeekEnd: prevWeekEnd ?? this.prevWeekEnd,
            currentDateFormat: currentDateFormat ?? this.currentDateFormat,
            currencyformat: currencyformat ?? this.currencyformat,
        );

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        totalWeeklyHours: json["total_weekly_hours"]??'',
        prevWeeklyHours: json["prev_weekly_hours"]??'',
        empName: json["emp_name"]??'',
        profilePic: json["profile_pic"]??'',
        assignments: List<Assignment>.from(json["assignments"].map((x) => Assignment.fromJson(x))),
        earnings: json["earnings"]??0,
        prevEarnings: json["prev_earnings"]??0,
        pending: json["pending"]??0,
        shifts: json["shifts"]??0,
        startDate: json["start_date"]??'',
        endDate: DateTime.parse(json["end_date"]),
        prevWeekStart: json["prev_week_start"]??'',
        prevWeekEnd: json["prev_week_end"]??'',
        currentDateFormat: json["current_date_format"]??'',
        currencyformat: json["currencyformat"]??'',
    );

    Map<String, dynamic> toJson() => {
        "total_weekly_hours": totalWeeklyHours,
        "prev_weekly_hours": prevWeeklyHours,
        "emp_name": empName,
        "profile_pic": profilePic,
        "assignments": List<dynamic>.from(assignments.map((x) => x.toJson())),
        "earnings": earnings,
        "prev_earnings": prevEarnings,
        "pending": pending,
        "shifts": shifts,
        "start_date": startDate,
        "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "prev_week_start": prevWeekStart,
        "prev_week_end": prevWeekEnd,
        "current_date_format": currentDateFormat,
        "currencyformat": currencyformat,
    };
}

class Assignment {
    final int number;
    final int id;
    final int jobId;
    final int employeeId;
    final int employeePaySetupId;
    final String employment;
    final String payRate;
    final String overtimePayRate;
    final String status;
    final String agencyMargin;
    final String customerPayRate;
    final String customerOvertimePayRate;
    final String endDate;
    final DateTime startDate;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int createdBy;
    final int employeeJobId;
    final String jobTitle;
    final String employeeName;
    final int customer;
    final String customerName;

    Assignment({
        required this.number,
        required this.id,
        required this.jobId,
        required this.employeeId,
        required this.employeePaySetupId,
        required this.employment,
        required this.payRate,
        required this.overtimePayRate,
        required this.status,
        required this.agencyMargin,
        required this.customerPayRate,
        required this.customerOvertimePayRate,
        required this.endDate,
        required this.startDate,
        required this.createdAt,
        required this.updatedAt,
        required this.createdBy,
        required this.employeeJobId,
        required this.jobTitle,
        required this.employeeName,
        required this.customer,
        required this.customerName,
    });

    Assignment copyWith({
        int? number,
        int? id,
        int? jobId,
        int? employeeId,
        int? employeePaySetupId,
        String? employment,
        String? payRate,
        String? overtimePayRate,
        String? status,
        String? agencyMargin,
        String? customerPayRate,
        String? customerOvertimePayRate,
        String? endDate,
        DateTime? startDate,
        DateTime? createdAt,
        DateTime? updatedAt,
        int? createdBy,
        int? employeeJobId,
        String? jobTitle,
        String? employeeName,
        int? customer,
        String? customerName,
    }) => 
        Assignment(
            number: number ?? this.number,
            id: id ?? this.id,
            jobId: jobId ?? this.jobId,
            employeeId: employeeId ?? this.employeeId,
            employeePaySetupId: employeePaySetupId ?? this.employeePaySetupId,
            employment: employment ?? this.employment,
            payRate: payRate ?? this.payRate,
            overtimePayRate: overtimePayRate ?? this.overtimePayRate,
            status: status ?? this.status,
            agencyMargin: agencyMargin ?? this.agencyMargin,
            customerPayRate: customerPayRate ?? this.customerPayRate,
            customerOvertimePayRate: customerOvertimePayRate ?? this.customerOvertimePayRate,
            endDate: endDate ?? this.endDate,
            startDate: startDate ?? this.startDate,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            createdBy: createdBy ?? this.createdBy,
            employeeJobId: employeeJobId ?? this.employeeJobId,
            jobTitle: jobTitle ?? this.jobTitle,
            employeeName: employeeName ?? this.employeeName,
            customer: customer ?? this.customer,
            customerName: customerName ?? this.customerName,
        );

    factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
        number: json["number"],
        id: json["id"],
        jobId: json["job_id"],
        employeeId: json["employee_id"],
        employeePaySetupId: json["employee_pay_setup_id"],
        employment: json["employment"],
        payRate: json["pay_rate"],
        overtimePayRate: json["overtime_pay_rate"],
        status: json["status"],
        agencyMargin: json["agency_margin"],
        customerPayRate: json["customer_pay_rate"],
        customerOvertimePayRate: json["customer_overtime_pay_rate"],
        endDate: json["end_date"],
        startDate: DateTime.parse(json["start_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        employeeJobId: json["employee_job_id"],
        jobTitle: json["job_title"],
        employeeName: json["employee_name"],
        customer: json["customer"],
        customerName: json["customer_name"],
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "id": id,
        "job_id": jobId,
        "employee_id": employeeId,
        "employee_pay_setup_id": employeePaySetupId,
        "employment": employment,
        "pay_rate": payRate,
        "overtime_pay_rate": overtimePayRate,
        "status": status,
        "agency_margin": agencyMargin,
        "customer_pay_rate": customerPayRate,
        "customer_overtime_pay_rate": customerOvertimePayRate,
        "end_date": endDate,
        "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_by": createdBy,
        "employee_job_id": employeeJobId,
        "job_title": jobTitle,
        "employee_name": employeeName,
        "customer": customer,
        "customer_name": customerName,
    };
}
