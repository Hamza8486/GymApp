
// To parse this JSON data, do
//
//     final allGymsModel = allGymsModelFromJson(jsonString);

import 'dart:convert';

AllGymsModel allGymsModelFromJson(String str) => AllGymsModel.fromJson(json.decode(str));

String allGymsModelToJson(AllGymsModel data) => json.encode(data.toJson());

class AllGymsModel {
  bool? status;
  String? message;
  List<GymDataModelAll>? data;

  AllGymsModel({this.status, this.message, this.data});

  AllGymsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GymDataModelAll>[];
      json['data'].forEach((v) {
        data!.add(new GymDataModelAll.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GymDataModelAll {
  String? id;
  String? userId;
  String? name;
  String? sessions;
  String? gender;
  String? address;
  int? fee;
  double? lat;
  double? loong;
  String? days;
  String? startTime;
  String? endTime;
  String? img;

  GymDataModelAll(
      {this.id,
        this.userId,
        this.name,
        this.sessions,
        this.gender,
        this.address,
        this.fee,
        this.lat,
        this.loong,
        this.days,
        this.startTime,
        this.endTime,
        this.img});

  GymDataModelAll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    sessions = json['sessions'];
    gender = json['gender'];
    address = json['address'];
    fee = json['fee'];
    lat = json['lat'];
    loong = json['loong'];
    days = json['days'];
    startTime = json['startTime '];
    endTime = json['endTime  '];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['sessions'] = this.sessions;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['fee'] = this.fee;
    data['lat'] = this.lat;
    data['loong'] = this.loong;
    data['days'] = this.days;
    data['startTime '] = this.startTime;
    data['endTime  '] = this.endTime;
    data['img'] = this.img;
    return data;
  }
}

