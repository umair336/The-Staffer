// To parse this JSON data, do
//
//     final assignmentDetailModel = assignmentDetailModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AssignmentDetailModel assignmentDetailModelFromJson(String str) => AssignmentDetailModel.fromJson(json.decode(str));

String assignmentDetailModelToJson(AssignmentDetailModel data) => json.encode(data.toJson());

class AssignmentDetailModel {
    final DetailModel detail;

    AssignmentDetailModel({
        required this.detail,
    });

    AssignmentDetailModel copyWith({
        DetailModel? detail,
    }) => 
        AssignmentDetailModel(
            detail: detail ?? this.detail,
        );

    factory AssignmentDetailModel.fromJson(Map<String, dynamic> json) => AssignmentDetailModel(
        detail: DetailModel.fromJson(json["Detail"]),
    );

    Map<String, dynamic> toJson() => {
        "Detail": detail.toJson(),
    };
}

class DetailModel {
    final Record record;
    final Address address;
    final dynamic payRate;
    final dynamic overtimePayRate;
    final List<Shift> shifts;
    final dynamic profilePic;

    DetailModel({
        required this.record,
        required this.address,
        required this.payRate,
        required this.overtimePayRate,
        required this.shifts,
        required this.profilePic,
    });

    DetailModel copyWith({
        Record? record,
        Address? address,
        dynamic payRate,
        dynamic overtimePayRate,
        List<Shift>? shifts,
        dynamic profilePic,
    }) => 
        DetailModel(
            record: record ?? this.record,
            address: address ?? this.address,
            payRate: payRate ?? this.payRate,
            overtimePayRate: overtimePayRate ?? this.overtimePayRate,
            shifts: shifts ?? this.shifts,
            profilePic: profilePic ?? this.profilePic,
        );

    factory DetailModel.fromJson(Map<String, dynamic> json) => DetailModel(
        record: Record.fromJson(json["record"]),
        address: Address.fromJson(json["address"]),
        payRate: json["pay_rate"],
        overtimePayRate: json["overtime_pay_rate"]??'',
        shifts: List<Shift>.from(json["shifts"].map((x) => Shift.fromJson(x))),
        profilePic: json["Profile_pic"]??'',
    );

    Map<String, dynamic> toJson() => {
        "record": record.toJson(),
        "address": address.toJson(),
        "pay_rate": payRate,
        "overtime_pay_rate": overtimePayRate,
        "shifts": List<dynamic>.from(shifts.map((x) => x.toJson())),
        "Profile_pic": profilePic,
    };
}

class Address {
    final String address;
    final int positionCount;

    Address({
        required this.address,
        required this.positionCount,
    });

    Address copyWith({
        String? address,
        int? positionCount,
    }) => 
        Address(
            address: address ?? this.address,
            positionCount: positionCount ?? this.positionCount,
        );

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        address: json["address"],
        positionCount: json["position_count"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "position_count": positionCount,
    };
}

class Record {
    final int id;
    final int number;
    final int organizationId;
    final int customerId;
    final int departmentId;
    final int worksiteId;
    final int jobPositionId;
    final int jobOrderId;
    final dynamic payrollId;
    final DateTime startDate;
    final String endDate;
    final String status;
    final String shiftNotes;
    final String dressCode;
    final dynamic scheduleRepeat;
    final dynamic scheduleTime;
    final dynamic scheduleDays;
    final int noOfPosition;
    final String shiftTimings;
    final String customerPayRate;
    final String customerOvertimePayRate;
    final String cusStreetAdress1;
    final String cusStreetAdress2;
    final int cusZcode;
    final int cusCountry;
    final int cusState;
    final int cusCity;
    final DateTime createdAt;
    final DateTime updatedAt;
    final String rateUpdatedAt;
    final String experience;
    final int createdBy;
    final String customerName;
    final String departmentNames;
    final String positionName;
    final String totalPosition;
    final String positionCount;

    Record({
        required this.id,
        required this.number,
        required this.organizationId,
        required this.customerId,
        required this.departmentId,
        required this.worksiteId,
        required this.jobPositionId,
        required this.jobOrderId,
        required this.payrollId,
        required this.startDate,
        required this.endDate,
        required this.status,
        required this.shiftNotes,
        required this.dressCode,
        required this.scheduleRepeat,
        required this.scheduleTime,
        required this.scheduleDays,
        required this.noOfPosition,
        required this.shiftTimings,
        required this.customerPayRate,
        required this.customerOvertimePayRate,
        required this.cusStreetAdress1,
        required this.cusStreetAdress2,
        required this.cusZcode,
        required this.cusCountry,
        required this.cusState,
        required this.cusCity,
        required this.createdAt,
        required this.updatedAt,
        required this.rateUpdatedAt,
        required this.experience,
        required this.createdBy,
        required this.customerName,
        required this.departmentNames,
        required this.positionName,
        required this.totalPosition,
        required this.positionCount,
    });

    Record copyWith({
        int? id,
        int? number,
        int? organizationId,
        int? customerId,
        int? departmentId,
        int? worksiteId,
        int? jobPositionId,
        int? jobOrderId,
        dynamic payrollId,
        DateTime? startDate,
        String? endDate,
        String? status,
        String? shiftNotes,
        String? dressCode,
        dynamic scheduleRepeat,
        dynamic scheduleTime,
        dynamic scheduleDays,
        int? noOfPosition,
        String? shiftTimings,
        String? customerPayRate,
        String? customerOvertimePayRate,
        String? cusStreetAdress1,
        String? cusStreetAdress2,
        int? cusZcode,
        int? cusCountry,
        int? cusState,
        int? cusCity,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? rateUpdatedAt,
        String? experience,
        int? createdBy,
        String? customerName,
        String? departmentNames,
        String? positionName,
        String? totalPosition,
        String? positionCount,
    }) => 
        Record(
            id: id ?? this.id,
            number: number ?? this.number,
            organizationId: organizationId ?? this.organizationId,
            customerId: customerId ?? this.customerId,
            departmentId: departmentId ?? this.departmentId,
            worksiteId: worksiteId ?? this.worksiteId,
            jobPositionId: jobPositionId ?? this.jobPositionId,
            jobOrderId: jobOrderId ?? this.jobOrderId,
            payrollId: payrollId ?? this.payrollId,
            startDate: startDate ?? this.startDate,
            endDate: endDate ?? this.endDate,
            status: status ?? this.status,
            shiftNotes: shiftNotes ?? this.shiftNotes,
            dressCode: dressCode ?? this.dressCode,
            scheduleRepeat: scheduleRepeat ?? this.scheduleRepeat,
            scheduleTime: scheduleTime ?? this.scheduleTime,
            scheduleDays: scheduleDays ?? this.scheduleDays,
            noOfPosition: noOfPosition ?? this.noOfPosition,
            shiftTimings: shiftTimings ?? this.shiftTimings,
            customerPayRate: customerPayRate ?? this.customerPayRate,
            customerOvertimePayRate: customerOvertimePayRate ?? this.customerOvertimePayRate,
            cusStreetAdress1: cusStreetAdress1 ?? this.cusStreetAdress1,
            cusStreetAdress2: cusStreetAdress2 ?? this.cusStreetAdress2,
            cusZcode: cusZcode ?? this.cusZcode,
            cusCountry: cusCountry ?? this.cusCountry,
            cusState: cusState ?? this.cusState,
            cusCity: cusCity ?? this.cusCity,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            rateUpdatedAt: rateUpdatedAt ?? this.rateUpdatedAt,
            experience: experience ?? this.experience,
            createdBy: createdBy ?? this.createdBy,
            customerName: customerName ?? this.customerName,
            departmentNames: departmentNames ?? this.departmentNames,
            positionName: positionName ?? this.positionName,
            totalPosition: totalPosition ?? this.totalPosition,
            positionCount: positionCount ?? this.positionCount,
        );

    factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json["id"],
        number: json["number"],
        organizationId: json["organization_id"],
        customerId: json["customer_id"],
        departmentId: json["department_id"],
        worksiteId: json["worksite_id"],
        jobPositionId: json["job_position_id"],
        jobOrderId: json["job_order_id"],
        payrollId: json["payroll_id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: json["end_date"],
        status: json["status"],
        shiftNotes: json["shift_notes"],
        dressCode: json["dress_code"],
        scheduleRepeat: json["schedule_repeat"],
        scheduleTime: json["schedule_time"],
        scheduleDays: json["schedule_days"],
        noOfPosition: json["no_of_position"],
        shiftTimings: json["shift_timings"],
        customerPayRate: json["customer_pay_rate"],
        customerOvertimePayRate: json["customer_overtime_pay_rate"],
        cusStreetAdress1: json["cus_street_adress_1"],
        cusStreetAdress2: json["cus_street_adress_2"],
        cusZcode: json["cus_zcode"],
        cusCountry: json["cus_country"],
        cusState: json["cus_state"],
        cusCity: json["cus_city"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        rateUpdatedAt: json["rate_updated_at"],
        experience: json["experience"],
        createdBy: json["created_by"],
        customerName: json["customer_name"],
        departmentNames: json["department_names"],
        positionName: json["position_name"],
        totalPosition: json["total_position"],
        positionCount: json["position_count"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "organization_id": organizationId,
        "customer_id": customerId,
        "department_id": departmentId,
        "worksite_id": worksiteId,
        "job_position_id": jobPositionId,
        "job_order_id": jobOrderId,
        "payroll_id": payrollId,
        "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date": endDate,
        "status": status,
        "shift_notes": shiftNotes,
        "dress_code": dressCode,
        "schedule_repeat": scheduleRepeat,
        "schedule_time": scheduleTime,
        "schedule_days": scheduleDays,
        "no_of_position": noOfPosition,
        "shift_timings": shiftTimings,
        "customer_pay_rate": customerPayRate,
        "customer_overtime_pay_rate": customerOvertimePayRate,
        "cus_street_adress_1": cusStreetAdress1,
        "cus_street_adress_2": cusStreetAdress2,
        "cus_zcode": cusZcode,
        "cus_country": cusCountry,
        "cus_state": cusState,
        "cus_city": cusCity,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "rate_updated_at": rateUpdatedAt,
        "experience": experience,
        "created_by": createdBy,
        "customer_name": customerName,
        "department_names": departmentNames,
        "position_name": positionName,
        "total_position": totalPosition,
        "position_count": positionCount,
    };
}

class Shift {
    final int id;
    final int jobId;
    final int shiftId;
    final String timeFrom;
    final String timeTo;
    final int noOfPositions;
    final dynamic days;
    final dynamic dates;
    final DateTime createdAt;
    final DateTime updatedAt;
    final String name;
    final int assignedEmployeesToShift;

    Shift({
        required this.id,
        required this.jobId,
        required this.shiftId,
        required this.timeFrom,
        required this.timeTo,
        required this.noOfPositions,
        required this.days,
        required this.dates,
        required this.createdAt,
        required this.updatedAt,
        required this.name,
        required this.assignedEmployeesToShift,
    });

    Shift copyWith({
        int? id,
        int? jobId,
        int? shiftId,
        String? timeFrom,
        String? timeTo,
        int? noOfPositions,
        dynamic days,
        dynamic dates,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? name,
        int? assignedEmployeesToShift,
    }) => 
        Shift(
            id: id ?? this.id,
            jobId: jobId ?? this.jobId,
            shiftId: shiftId ?? this.shiftId,
            timeFrom: timeFrom ?? this.timeFrom,
            timeTo: timeTo ?? this.timeTo,
            noOfPositions: noOfPositions ?? this.noOfPositions,
            days: days ?? this.days,
            dates: dates ?? this.dates,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            name: name ?? this.name,
            assignedEmployeesToShift: assignedEmployeesToShift ?? this.assignedEmployeesToShift,
        );

    factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        id: json["id"],
        jobId: json["job_id"],
        shiftId: json["shift_id"],
        timeFrom: json["time_from"],
        timeTo: json["time_to"],
        noOfPositions: json["no_of_positions"],
        days: json["days"],
        dates: json["dates"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        assignedEmployeesToShift: json["assigned_employees_to_shift"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "job_id": jobId,
        "shift_id": shiftId,
        "time_from": timeFrom,
        "time_to": timeTo,
        "no_of_positions": noOfPositions,
        "days": days,
        "dates": dates,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "assigned_employees_to_shift": assignedEmployeesToShift,
    };
}
