import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:gym_app/app/auth/controller.dart';
import 'package:gym_app/app/auth/login.dart';
import 'package:gym_app/app/auth/otp.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/controller/controller.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/model/avail_model.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/model/get_video_model.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/model/gym_model.dart';
import 'package:gym_app/app/gym/bottom_tabs/profile/model/appointment_model.dart';
import 'package:gym_app/app/gym/home/controller/home_controller.dart';
import 'package:gym_app/app/gym/home/home.dart';
import 'package:gym_app/app/user/bottom_tabs/map_view/controller/map_controller.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/filter_gyms.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/model/all.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/model/other.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/model/profile_model.dart';
import 'package:gym_app/app/user/bottom_tabs/userprofile/component/my_appointment.dart';
import 'package:gym_app/app/user/bottom_tabs/userprofile/model/appoint_model.dart';
import 'package:gym_app/app/user/home/controller/user_controller.dart';
import 'package:gym_app/app/user/home/user_home.dart';
import 'package:gym_app/app/util/constant.dart';
import 'package:gym_app/app/util/toast.dart';
import 'package:gym_app/app/widgets/helper_function.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';



  class ApiManger extends GetConnect {
  static var client = http.Client();

  static Uri uriPath({required String nameUrl}) {
    print("Url: ${AppConstants.baseURL}$nameUrl");
    return Uri.parse(AppConstants.baseURL + nameUrl);
  }



  loginResponse({required BuildContext context, email, password}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'email': email,
        'password': password,
      });
      print("Data::::: ${data.fields}");
      print("Data::::: ${data.fields}");
      var response = await dio.Dio().post(
        AppConstants.baseURL + AppConstants.login,
        data: data,
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {

        HelperFunctions.saveInPreference(
            "id", response.data['data']['id'].toString());
        HelperFunctions.saveInPreference(
            "userType",
            response.data['data']['userType']==""?"Gym":
            response.data['data']['userType'].toString());

        HelperFunctions.saveInPreference(
            "name", response.data['data']['fullName'].toString());
        HelperFunctions.saveInPreference(
            "email", response.data['data']['email'].toString());
        HelperFunctions.saveInPreference(
            "phone", response.data['data']['phone'].toString());
        HelperFunctions.saveInPreference(
            "address", response.data['data']['address'].toString());
        if(response.data['data']['userType']=="User"){
          Get.offAll(() => UserHome(), transition: Transition.cupertinoDialog);
        }
        else{
          Get.offAll(() => HomeView(), transition: Transition.cupertinoDialog);
          }

        Get.put(AuthController()).updateLoginLoader(false);

        debugPrint(response.data.toString());
        debugPrint(response.data.toString());
      }
    } on dio.DioError catch (e) {
      e.response?.data["message"]=="Please verify your account in order to proceed."?

      Get.put(AuthController()).updateLoginLoader(true):Get.put(AuthController()).updateLoginLoader(false);
      e.response?.data["message"]=="Please verify your account in order to proceed."?accountVerifyResponse():
      flutterToast(msg: e.response?.data["message"].toString());
      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }



  accountVerifyResponse() async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'email': Get.put(AuthController()).emailController.text,
        'password': Get.put(AuthController()).passController.text,
      });
      print("Data::::: ${data.fields}");
      print("Data::::: ${data.fields}");
      var response = await dio.Dio().post(
        AppConstants.baseURL + AppConstants.otp,
        data: data,
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        Get.put(AuthController()).updateLoginLoader(false);
        Get.to(OtpScreen());

        flutterToastSuccess(msg: "Please verify your account in order to proceed.");
        //Get.offAll(() => HomeView(), transition: Transition.cupertinoDialog);

        debugPrint(response.data.toString());
        debugPrint(response.data.toString());
      }
    } on dio.DioError catch (e) {
      Get.put(AuthController()).updateLoginLoader(false);

      flutterToast(msg: e.response?.data["message"].toString());
      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }




 registerResponse({required BuildContext context}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'email': Get.put(AuthController()).emailRegController.text,
        'password': Get.put(AuthController()).passRegController.text,
        'userType': Get.put(AuthController()).userType.value,
        'fullName': Get.put(AuthController()).fullNameController.text,
        'phone': Get.put(AuthController()).phoneController.text,
        'address': Get.put(AuthController()).addressController.text,
        'lat': Get.put(AuthController()).lat.value,
        'long': Get.put(AuthController()).lng.value,
      });
      print("Data::::: ${data.fields}");
      print("Data::::: ${data.fields}");
      var response = await dio.Dio().post(
        AppConstants.baseURL + AppConstants.register,
        data: data,
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        Get.put(AuthController()).updateLoader(false);

        flutterToast(msg: "Code sent on email successfully");
        Get.to(OtpScreen(data: "otp",));

      }
    } on dio.DioError catch (e) {
      Get.put(AuthController()).updateLoader(false);
      flutterToast(msg: e.response?.data["message"].toString());
      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }



  addGymResponse({context,start,end}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'user_id': Get.put(HomeController()).id.value,
          'gymName': Get.put(GymController()).nameController.text,
          'sessionType':Get.put(GymController()).sessionName.value,
          'fee':Get.put(GymController()).feeController.text,
          'gender': Get.put(GymController()).gendarName.value,
          'address': Get.put(AuthController()).addressController.text,
          'lat': Get.put(AuthController()).lat.value,
          'long': Get.put(AuthController()).lng.value,
          'startDate': start.toString(),
          'endDate': end.toString(),
          'startTime': Get.put(AuthController()).startController.text,
          'endTime': Get.put(AuthController()).endController.text,
          'days':Get.put(GymController()).selectName.join(","),
          'types':Get.put(GymController()).selectTypeName.join(","),

          Get.put(GymController()).file == null ? "" : 'img':
          Get.put(GymController()).file == null
              ? ""
              : await dio.MultipartFile.fromFile(
              Get.put(GymController()).file!.path),
          // 'days': Get.put(GymController()).selectName,
        });
        // if (Get.put(GymController()).selectName.isNotEmpty) {
        //   for (int i = 0; i < Get.put(GymController()).selectName.length; i++) {
        //     data.fields
        //         .add(MapEntry('days[$i]', Get.put(GymController()).selectName[i].toString()));
        //   }
        // }
        print("Data::::: ${data.fields}");
        print("Data::::: ${data.fields}");
        var response = await dio.Dio().post(
            AppConstants.baseURL + AppConstants.addGym,
            data: data,
            options: dio.Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",


            })

        );
        if (response.statusCode == 200) {

          Get.put(HomeController()).getData();
          Get.back();
          Get.put(GymController()).updateLoader(false);
          Get.put(AuthController()).clear();
          Get.put(GymController()).clear();


          flutterToastSuccess(msg: "Gym Add Successfully");

        }
      } on dio.DioError catch (e) {

        Get.put(GymController()).updateLoader(false);
        flutterToast(msg: e.response?.data["message"].toString());
        print(e.response?.statusCode.toString());
        // log("e.response");


      }
    } on dio.DioError catch (e) {
      Get.put(GymController()).updateLoader(false);
      print(e.response?.statusCode.toString());
      flutterToast(msg: e.response?.data["message"].toString());
      log(e.response.toString());
    }
  }


  addAvail({required BuildContext context, startDate,startTime,endDate,endTime}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'user_id': Get.put(HomeController()).id.value,
        'startDate': startDate.toString(),
        'endDate': endDate.toString(),
        'startTime': startTime.toString(),
        'endTime': endTime.toString(),
        'days': Get.put(GymController()).selectName.join(","),

      });
      print("Data::::: ${data.fields}");
      print("Data::::: ${data.fields}");
      var response = await dio.Dio().post(
        AppConstants.baseURL + AppConstants.setAvail,
        data: data,
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        Get.back();

        flutterToastSuccess(msg: "Availability Add Successfully!");
        Get.put(HomeController()).getAvailData();
        Get.put(GymController()).updateLoader(false);

        print(response.data);


      }
    } on dio.DioError catch (e) {
      Get.put(GymController()).updateLoader(false);
      print(e.response?.statusCode.toString());
      flutterToast(msg: e.response?.data["message"].toString());
      log(e.response.toString());
    }
  }



  uploadVideo({gymId ,XFile?file}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'gym_id': gymId.toString(),
          file == null ? "" : 'video':
          file == null
              ? ""
              : await dio.MultipartFile.fromFile(
              file!.path),

        });

        print("Data::::: ${data.fields}");
        print("Data::::: ${data.fields}");
        var response = await dio.Dio().post(
            AppConstants.baseURL + AppConstants.uploadVideo,
            data: data,
            options: dio.Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",


            })

        );
        if (response.statusCode == 200) {
          Get.put(GymController()).videoFile=null;
          Get.put(HomeController()).updateVideoLoader(false);
          Get.put(HomeController()).getVideoData(id:Get.put(HomeController()).gymId.value );



          flutterToastSuccess(msg: "Video Upload Successfully");

        }
      } on dio.DioError catch (e) {

        Get.put(HomeController()).updateVideoLoader(false);
        flutterToast(msg: e.response?.data["message"].toString());
        print(e.response?.statusCode.toString());
        // log("e.response");


      }
    } on dio.DioError catch (e) {
      Get.put(HomeController()).updateVideoLoader(false);
      print(e.response?.statusCode.toString());
      flutterToast(msg: e.response?.data["message"].toString());
      log(e.response.toString());
    }
  }


  deleteVideoSingle({var id, required BuildContext context}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'video_id': id,
      });

      var response =
      await dio.Dio().post(AppConstants.baseURL + AppConstants.deleteVideo,
          data: data,
          options: dio.Options(headers: {
            "Accept": "application/json",
          }));

      debugPrint(response.toString());

      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        Get.put(GymController()).videoFile=null;
        Get.put(HomeController()).updateVideoDeleteLoader(false);
        Get.put(HomeController()).getVideoData(id:Get.put(HomeController()).gymId.value );



        flutterToastSuccess(msg: "Video Deleted Successfully");

        debugPrint(response.statusMessage);
      }
    } on dio.DioError catch (e) {
      flutterToast(msg: e.response?.data["message"].toString());
      Get.put(HomeController()).updateVideoDeleteLoader(false);

      debugPrint(e.response.toString());
    }
  }

  ratingData({var id,rating, required BuildContext context}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'gym_id': id.toString(),
        'user_id': Get.put(UserController()).id.value,
        'rating': rating.toString(),
      });

      var response =
      await dio.Dio().post(AppConstants.baseURL + AppConstants.rating,
          data: data,
          options: dio.Options(headers: {
            "Accept": "application/json",
          }));

      debugPrint(response.toString());

      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        Get.put(UserController()).getData();
        Get.put(UserController()).getMyData();
        Get.put(UserController()).updateIsRating(false);
        Get.back();
        Get.back();


        flutterToastSuccess(msg: "Thanks for your rating!");

        debugPrint(response.statusMessage);
      }
    } on dio.DioError catch (e) {
      flutterToast(msg: e.response?.data["message"].toString());
      Get.put(UserController()).updateIsRating(false);

      debugPrint(e.response.toString());
    }
  }


  editGymResponse({context,id,edit,start,end}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'gym_id': id.toString(),
          'gymName': Get.put(GymController()).nameEditController.text,
          'sessionType':Get.put(GymController()).sessionEditName.value,
          'gender': Get.put(GymController()).gendarEditName.value,
          'fee': Get.put(GymController()).feeEditController.text,
          'address': Get.put(AuthController()).addressController.text,
          'lat': Get.put(AuthController()).lat.value,
          'long': Get.put(AuthController()).lng.value,
          'startDate': start.toString(),
          'endDate': end.toString(),
          'startTime': Get.put(GymController()).startController.text,
          'types': edit.toString(),
          'endTime': Get.put(GymController()).endController.text,
          'days':"${Get.put(GymController()).week.isEmpty?"":"${Get.put(GymController()).week.value},"}"
              "${Get.put(GymController()).week1.isEmpty?"":"${Get.put(GymController()).week1.value},"}"
              "${Get.put(GymController()).week2.isEmpty?"":"${Get.put(GymController()).week2.value},"}"
              "${Get.put(GymController()).week3.isEmpty?"":"${Get.put(GymController()).week3.value},"}"
              "${Get.put(GymController()).week4.isEmpty?"":"${Get.put(GymController()).week4.value},"}"
              "${Get.put(GymController()).week5.isEmpty?"":"${Get.put(GymController()).week5.value},"}"
              "${Get.put(GymController()).week6.isEmpty?"":"${Get.put(GymController()).week6.value}"}",

          Get.put(GymController()).file1 == null ? "" : 'img':
          Get.put(GymController()).file1 == null
              ? ""
              : await dio.MultipartFile.fromFile(
              Get.put(GymController()).file1!.path),
        });
        print("Data::::: ${data.fields}");
        print("Data::::: ${data.fields}");
        var response = await dio.Dio().post(
          AppConstants.baseURL + AppConstants.edit,
          data: data,
        );
        if (response.statusCode == 200) {

          Get.put(HomeController()).getData();
          Get.back();
          Get.put(GymController()).updateLoader1(false);
          Get.put(AuthController()).clear();
          Get.put(GymController()).clear();
          Get.put(GymController()).clearEdit();


          flutterToastSuccess(msg: "Gym Update Successfully");

        }
      } on dio.DioError catch (e) {

        Get.put(GymController()).updateLoader(false);
        flutterToast(msg: e.response?.data["message"].toString());
        // log("e.response");


      }
    } on dio.DioError catch (e) {
      Get.put(GymController()).updateLoader(false);
      flutterToast(msg: e.response?.data["message"].toString());
      log(e.toString());
    }
  }


  otpResponse({required BuildContext context, email, otp}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'email': email,
        'otp_code': otp.toString(),

      });
      print("Data::::: ${data.fields}");
      print("Data::::: ${data.fields}");
      var response = await dio.Dio().post(
        AppConstants.baseURL + AppConstants.verifyOtp,
        data: data,
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {

        Get.put(AuthController()).clear();
        Get.put(AuthController()).emailController.clear();
        Get.put(AuthController()).passController.clear();
        Get.offAll(LoginView());
        flutterToastSuccess(msg: "Account Create Successfully, Please Login");
        Get.put(AuthController()).updateOtp(false);


      }
    } on dio.DioError catch (e) {
      Get.put(AuthController()).updateOtp(false);
      flutterToast(msg: e.response?.data["message"].toString());
      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }


  static Future<AllGymsModel?> getAllGymResponse() async {
    var response = await client.get(
      uriPath(nameUrl: "${AppConstants.getGym}?user_id=${Get.put(HomeController()).id.value}"),
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      print("response.body");
      print(response.body);
      return allGymsModelFromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }
  static Future<GetVideoModel?> getVideoAll({id}) async {
    var response = await client.get(
      uriPath(nameUrl: "${AppConstants.getVideo}?gym_id=${id.toString()}"),
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return GetVideoModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }



  static Future<AllGym?> userAllGyms() async {
    var response = await client.get(
      uriPath(nameUrl: AppConstants.userAll),
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return AllGym.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }


  static Future<AllGym?> myAllGyms() async {
    var response = await client.get(
      uriPath(nameUrl: "${AppConstants.userGyms}?user_id=${Get.put(UserController()).id.value}"),
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return AllGym.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }


  static Future<AllGym?> mapGyms({lat,lng}) async {
    var response = await client.get(
      uriPath(nameUrl: "${AppConstants.map}?lat=${lat.toString()}&long=${lng.toString()}&radius=1000"),
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return AllGym.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }


  static Future<OtherUserModel?> otherUser({gymId}) async {
    var response = await client.get(
      uriPath(nameUrl: "${AppConstants.other}?gym_id=${gymId.toString()}"),
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return OtherUserModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }



  static Future<AllGym?> userFilterAllGyms({gend="",sess="",fee="",String time="",String time1="",String day="",String type="",String date=""}) async {
    var response = await client.get(
      uriPath(nameUrl:

      "${AppConstants.userAll}?radius=${Get.put(UserController()).radius.value}"

          "${fee==""?"":"&fee=${fee.toString()}"}"
          "${sess==""?"":"&session=${sess.toString()}"}"
          "${gend==""?"":"&gender=${gend.toString()}"}"
          "${day==""?"":"&days=${day.toString()}"}"
          "${time==""?"":"&startTime=${time.toString()}"}"
          "${time1==""?"":"&endTime=${time1.toString()}"}"
          "${type==""?"":"&types=${type.toString()}"}"
          "${date==""?"":"&appointmentDate=${date.toString()}"}"
      ),
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      Get.put(UserController()).updateLoader2(false);
      Get.to(FilterGyms(),
      transition: Transition.rightToLeft
      );
      print(response.body);
      return AllGym.fromJson(jsonString);
    } else {
      Get.put(UserController()).updateLoader2(false);
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }

  deleteResponse({id}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'gym_id': id.toString(),
        'user_id': Get.put(HomeController()).id.value,
      });
      print("Data::::: ${data.fields}");
      print("Data::::: ${data.fields}");
      var response = await dio.Dio().post(
        AppConstants.baseURL + AppConstants.deleteGym,
        data: data,
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        Get.back();
        Get.put(HomeController()).getData();
        debugPrint(response.data.toString());
        debugPrint(response.data.toString());
      }
    } on dio.DioError catch (e) {
      Get.put(AuthController()).updateLoginLoader(false);

      flutterToast(msg: e.response?.data["message"].toString());
      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }


  editProfileResponse({name,phone,address,password}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'user_id': Get.put(HomeController()).id.value,
        'fullName': name.toString(),
        'phone': phone.toString(),
        'address': address.toString(),
        'password': password.toString(),
      });
      print("Data::::: ${data.fields}");
      print("Data::::: ${data.fields}");
      var response = await dio.Dio().post(
        AppConstants.baseURL + AppConstants.editProfile,
        data: data,
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        HelperFunctions.saveInPreference(
            "name", response.data['data']['fullName'].toString());

        HelperFunctions.saveInPreference(
            "phone", response.data['data']['phone'].toString());
        HelperFunctions.saveInPreference(
            "address", response.data['data']['address'].toString());
        Get.put(HomeController()).updateName(response.data['data']['fullName'].toString());
        Get.put(HomeController()).updateAddress(response.data['data']['address'].toString());
        Get.put(HomeController()).updatePhone(response.data['data']['phone'].toString());
        Get.put(HomeController()).updateLoader(false);
        flutterToastSuccess(msg: "Profile Update");
        //Get.offAll(() => HomeView(), transition: Transition.cupertinoDialog);

        debugPrint(response.data.toString());
        debugPrint(response.data.toString());
      }
    } on dio.DioError catch (e) {
      Get.put(HomeController()).updateLoader(false);

      flutterToast(msg: e.response?.data["message"].toString());
      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }



  payResponse1() async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'user_id': Get.put(UserController()).id.value,
        'gym_id': Get.put(MapController()).gymId.value.toString(),
        'amount': Get.put(MapController()).gymAmount.toString(),
      });
      print("Data::::: ${data.fields}");
      print("Data::::: ${data.fields}");
      var response = await dio.Dio().post(
        AppConstants.baseURL + AppConstants.pay,
        data: data,
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        Get.put(UserController()).updatePayLoader(false);
        Get.back();
        flutterToastSuccess(msg: "${ Get.put(MapController()).gymNAME.value}Booking Successfully");

        Get.put(UserController()).getMyData();
        Get.put(MapController()).updateGymName("");
        Get.put(MapController()).updateGymId("");
        Get.put(MapController()).updateGymAmount("");

        debugPrint(response.data.toString());
        debugPrint(response.data.toString());
      }
    } on dio.DioError catch (e) {
      Get.put(UserController()).updatePayLoader(false);

      flutterToast(msg: e.response?.data["message"].toString());
      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }


  payResponse({gym,amount}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'user_id': Get.put(UserController()).id.value,
        'gym_id': gym.toString(),
        'amount': amount.toString(),
      });
      print("Data::::: ${data.fields}");
      print("Data::::: ${data.fields}");
      var response = await dio.Dio().post(
        AppConstants.baseURL + AppConstants.pay,
        data: data,
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        Get.put(UserController()).updatePayLoader(false);
        flutterToastSuccess(msg: "Booking Successfully");
        Get.put(UserController()).getMyData();

        debugPrint(response.data.toString());
        debugPrint(response.data.toString());
      }
    } on dio.DioError catch (e) {
      Get.put(UserController()).updatePayLoader(false);

      flutterToast(msg: e.response?.data["message"].toString());
      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }



  editProfile1Response({name,phone,address,password}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'user_id': Get.put(UserController()).id.value,
        'fullName': name.toString(),
        'phone': phone.toString(),
        'address': address.toString(),
        'password': password.toString(),
      });
      print("Data::::: ${data.fields}");
      print("Data::::: ${data.fields}");
      var response = await dio.Dio().post(
        AppConstants.baseURL + AppConstants.editProfile,
        data: data,
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        HelperFunctions.saveInPreference(
            "name", response.data['data']['fullName'].toString());

        HelperFunctions.saveInPreference(
            "phone", response.data['data']['phone'].toString());
        HelperFunctions.saveInPreference(
            "address", response.data['data']['address'].toString());
        Get.put(UserController()).updateName(response.data['data']['fullName'].toString());
        Get.put(UserController()).updateAddress(response.data['data']['address'].toString());
        Get.put(UserController()).updatePhone(response.data['data']['phone'].toString());
        Get.put(UserController()).updateLoader(false);
        flutterToastSuccess(msg: "Profile Update");
        //Get.offAll(() => HomeView(), transition: Transition.cupertinoDialog);

        debugPrint(response.data.toString());
        debugPrint(response.data.toString());
      }
    } on dio.DioError catch (e) {
      Get.put(UserController()).updateLoader(false);

      flutterToast(msg: e.response?.data["message"].toString());
      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }




  editUserResponse1({context}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'user_id': Get.put(HomeController()).id.value,
           'img': await dio.MultipartFile.fromFile(
              Get.put(HomeController()).myProfile!.path),
        });
        print("Data::::: ${data.fields}");
        print("Data::::: ${data.fields}");
        var response = await dio.Dio().post(
          AppConstants.baseURL + AppConstants.myEditProfile,
          data: data,
        );
        if (response.statusCode == 200) {

          Get.put(HomeController()).imageData();
          Get.back();



          flutterToastSuccess(msg: "Profile Update Successfully");

        }
      } on dio.DioError catch (e) {

        Get.back();
        flutterToast(msg: e.response?.data["message"].toString());
        // log("e.response");


      }
    } on dio.DioError catch (e) {
      Get.back();
      flutterToast(msg: e.response?.data["message"].toString());
      log(e.toString());
    }
  }



  editUserResponse({context}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'user_id': Get.put(UserController()).id.value,
          'img': await dio.MultipartFile.fromFile(
              Get.put(UserController()).myProfile!.path),
        });
        print("Data::::: ${data.fields}");
        print("Data::::: ${data.fields}");
        var response = await dio.Dio().post(
          AppConstants.baseURL + AppConstants.myEditProfile,
          data: data,
        );
        if (response.statusCode == 200) {

          Get.put(UserController()).imageData();
          Get.back();



          flutterToastSuccess(msg: "Profile Update Successfully");

        }
      } on dio.DioError catch (e) {

        Get.back();
        flutterToast(msg: e.response?.data["message"].toString());
        // log("e.response");


      }
    } on dio.DioError catch (e) {
      Get.back();
      flutterToast(msg: e.response?.data["message"].toString());
      log(e.toString());
    }
  }

  static Future<GetProfileModel?> getProfileUser() async {
    var response = await client.get(
      uriPath(nameUrl: "${AppConstants.myProfile}?user_id=${Get.put(UserController()).id.value}"),
    );
    print(response.toString());

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return GetProfileModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }

  static Future<GetProfileModel?> getProfileUser1() async {
    var response = await client.get(
      uriPath(nameUrl: "${AppConstants.myProfile}?user_id=${Get.put(HomeController()).id.value}"),
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return GetProfileModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }



  bookAppointmnet({required BuildContext context, gymId,end,date}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'user_id': Get.put(UserController()).id.value,
        'gym_id': gymId.toString(),
        'date': date.toString(),
        'time': end.toString(),

      });
      print("Data::::: ${data.fields}");
      print("Data::::: ${data.fields}");
      var response = await dio.Dio().post(
        AppConstants.baseURL + AppConstants.book,
        data: data,
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        Get.back();

        flutterToastSuccess(msg: "Appointment Book Successfully!");
        Get.put(UserController()).updateAppoint(false);
        Get.put(UserController()).appointData();
        Get.to(MyAppointmentView());
        print(response.data);


      }
    } on dio.DioError catch (e) {
      Get.put(UserController()).updateAppoint(false);
      flutterToast(msg: e.response?.data["message"].toString());
      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }


  static Future<MyAppointmentModel?> myAppointmentModel() async {
    var response = await client.get(
      uriPath(nameUrl: "${AppConstants.myAppoint}?user_id=${Get.put(UserController()).id.value}"),
    );
    print(response.toString());

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return MyAppointmentModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }




  static Future<GymAppointModel?> getGymAppointModel() async {
    var response = await client.get(
      uriPath(nameUrl: "${AppConstants.myAppoint}?user_id=${Get.put(HomeController()).id.value}"),
    );
    print(response.toString());

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return GymAppointModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }


  static Future<MyAvailModel?> getMyAvailModel() async {
    var response = await client.get(
      uriPath(nameUrl: "${AppConstants.myAvail}?user_id=${Get.put(HomeController()).id.value}"),
    );
    print(response.toString());

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return MyAvailModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }

}
