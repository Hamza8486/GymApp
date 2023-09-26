class MyAvailModel {
  bool? status;
  String? message;
  AvailData? data;

  MyAvailModel({this.status, this.message, this.data});

  MyAvailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new AvailData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AvailData {
  String? startTime;
  String? endTime;
  String? startDate;
  String? endDate;
  String? days;

  AvailData({this.startTime, this.endTime, this.startDate, this.endDate, this.days});

  AvailData.fromJson(Map<String, dynamic> json) {
    startTime = json['startTime'];
    endTime = json['endTime'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    days = json['days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['days'] = this.days;
    return data;
  }
}
