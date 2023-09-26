class MyAppointmentModel {
  bool? status;
  String? message;
  List<AppointmentListModel>? data;

  MyAppointmentModel({this.status, this.message, this.data});

  MyAppointmentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AppointmentListModel>[];
      json['data'].forEach((v) {
        data!.add(new AppointmentListModel.fromJson(v));
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

class AppointmentListModel {
  int? id;
  int? userId;
  int? gymId;
  String? appointmentDate;
  String? appointmentStartTime;
  String? appointmentEndTime;
  String? days;
  String? gymName;
  String? userName;

  AppointmentListModel(
      {this.id,
        this.userId,
        this.gymId,
        this.appointmentDate,
        this.appointmentStartTime,
        this.appointmentEndTime,
        this.days,
        this.gymName,
        this.userName});

  AppointmentListModel.fromJson(Map<String, dynamic> json) {
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
