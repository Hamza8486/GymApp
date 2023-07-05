class OtherUserModel {
  bool? status;
  String? message;
  List<DataModel>? data;

  OtherUserModel({this.status, this.message, this.data});

  OtherUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataModel>[];
      json['data'].forEach((v) {
        data!.add(new DataModel.fromJson(v));
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

class DataModel {
  String? id;
  String? userType;
  String? fullName;
  String? email;
  String? phone;
  String? address;
  String? verified;
  String? lat;
  String? loong;
  String? verificationCode;

  DataModel(
      {this.id,
        this.userType,
        this.fullName,
        this.email,
        this.phone,
        this.address,
        this.verified,
        this.lat,
        this.loong,
        this.verificationCode});

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['userType'];
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    verified = json['verified'];
    lat = json['lat'];
    loong = json['loong'];
    verificationCode = json['verification_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userType'] = this.userType;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['verified'] = this.verified;
    data['lat'] = this.lat;
    data['loong'] = this.loong;
    data['verification_code'] = this.verificationCode;
    return data;
  }
}
