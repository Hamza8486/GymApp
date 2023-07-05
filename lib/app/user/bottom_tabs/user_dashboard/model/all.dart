class AllGym {
  bool? status;
  String? message;
  List<AllData>? data;

  AllGym({this.status, this.message, this.data});

  AllGym.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AllData>[];
      json['data'].forEach((v) {
        data!.add(new AllData.fromJson(v));
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

class AllData {
  int? id;
  String? name;
  String? sessions;
  String? gender;
  String? address;
 var lat;
  var loong;
  String? img;
  String? days;
  String? startTime;
  String? endTime;
  int? fees;

  AllData(
      {this.id,
        this.name,
        this.sessions,
        this.gender,
        this.days,
        this.startTime,
        this.endTime,
        this.address,
        this.lat,
        this.loong,
        this.img,
        this.fees});

  AllData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sessions = json['sessions'];
    gender = json['gender'];
    address = json['address'];
    lat = json['lat'];
    days = json['days'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    loong = json['loong'];
    img = json['img'];
    fees = json['fees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sessions'] = this.sessions;
    data['gender'] = this.gender;
    data['days'] = this.days;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['loong'] = this.loong;
    data['img'] = this.img;
    data['fees'] = this.fees;
    return data;
  }
}
