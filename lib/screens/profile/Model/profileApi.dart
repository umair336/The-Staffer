import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as s;


class ProfileModel {
 late Data data;
  ProfileModel({required this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ?  Data.fromJson(json['data']) : null)!;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
 late String employeeName;
 late String jobPosition;
 late String profilePic;
 late String phone;
 late String email;
 late String dob;
 late String ssn;
 late String location;

  Data(
      {required this.employeeName,
      required this.jobPosition,
     required this.profilePic,
     required this.phone,
     required this.email,
     required this.dob,
     required this.ssn,
     required this.location, required String error});

  Data.fromJson(Map<String, dynamic> json) {
    employeeName = json['employee_name']??'';
    jobPosition = json['job_position']??'';
    profilePic = json['profile_pic']??'';
    phone = json['phone']??'';
    email = json['email']??'';
    dob = json['dob']??'';
    ssn = json['ssn']??'';
    location = json['location']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['employee_name'] = this.employeeName;
    data['job_position'] = this.jobPosition;
    data['profile_pic'] = this.profilePic;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['ssn'] = this.ssn;
    data['location'] = this.location;
    return data;
  }
}