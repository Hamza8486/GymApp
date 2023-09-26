class GymAppointModel {
  bool? status;
  String? message;
  List<Data>? data;

  GymAppointModel({this.status, this.message, this.data});

  GymAppointModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  int? userId;
  int? gymId;
  String? appointmentDate;
  String? appointmentStartTime;
  String? appointmentEndTime;
  String? days;
  String? gymName;
  String? userName;

  Data(
      {this.id,
        this.userId,
        this.gymId,
        this.appointmentDate,
        this.appointmentStartTime,
        this.appointmentEndTime,
        this.days,
        this.gymName,
        this.userName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    gymId = json['gym_id'];
    appointmentDate = json['appointment_date'];
    appointmentStartTime = json['appointment_start_time'];
    appointmentEndTime = json['appointment_end_time'];
    days = json['days'];
    gymName = json['gym_name'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['gym_id'] = this.gymId;
    data['appointment_date'] = this.appointmentDate;
    data['appointment_start_time'] = this.appointmentStartTime;
    data['appointment_end_time'] = this.appointmentEndTime;
    data['days'] = this.days;
    data['gym_name'] = this.gymName;
    data['user_name'] = this.userName;
    return data;
  }
}
