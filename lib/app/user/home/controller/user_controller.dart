import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/model/gym_model.dart';
import 'package:gym_app/app/services/api_manager.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/model/all.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/model/other.dart';
import 'package:gym_app/app/widgets/helper_function.dart';



class UserController extends GetxController {
  var isValue = true.obs;
  updateLoader(val){
    loader.value = val;
    update();


  }

  var gymId="".obs;
  var gymNAME="".obs;
  var gymAmount="".obs;
  updateGymId(val){
    gymId.value=val;
    update();
  }

  updateGymAmount(val){
    gymAmount.value=val;
    update();
  }
  updateGymName(val){
    gymNAME.value=val;
    update();
  }

  var startValue="".obs;
  updateStartValue(val){
    startValue.value;
    update();

  }
  updatePayLoader(val){
    payLoader.value = val;
    update();


  }
  updateLoader2(val){
    loader2.value = val;
    update();


  }
  var gendarName="".obs;
  updateGender(val){
    gendarName.value = val;
    update();
  }
  var loader = false.obs;
  var loader2 = false.obs;
  var payLoader = false.obs;
  var id = "".obs;
  var name = "".obs;
  var userType = "".obs;
  updateName(val){
    name.value=val;
    update();
  }
  updateAddress(val){
    address.value=val;
    update();
  }
  updatePhone(val){
    phone.value=val;
    update();
  }
  var phone = "".obs;
  var address = "".obs;
  var email = "".obs;


  @override
  Future<void> onInit() async {
    getData();

    HelperFunctions.getFromPreference("id").then((value) {
      id.value = value;
      print(id.value.toString());
      getMyData();

      update();
    });
    HelperFunctions.getFromPreference("userType").then((value) {
      userType.value = value;
      print(userType.value.toString());

      update();
    });
    HelperFunctions.getFromPreference("name").then((value) {
      name.value = value;
      print(name.value.toString());

      update();
    });
    HelperFunctions.getFromPreference("email").then((value) {
      email.value = value;

      update();
    });
    HelperFunctions.getFromPreference("phone").then((value) {
      phone.value = value;

      update();
    });
    HelperFunctions.getFromPreference("address").then((value) {
      address.value = value;

      update();
    });



    super.onInit();
    //getHistoryData(id: "30746b29-8044-4c6b-aef8-f5cfdb584200");
  }

  updateValue(val) {
    isValue.value = val;

    update();
  }
  var selectOption = "car".obs;
  var sessionName="".obs;
  var radius="10".obs;
  updateRadius(val){
    radius.value=val;
    update();
  }
  updateSessions(val){
    sessionName.value = val;
    update();
  }
  var slot="".obs;
  File?file;
  var gymList = <AllData>[].obs;
  var gymMyList = <AllData>[].obs;
  var mapList = <AllData>[].obs;
  var filterGymsList = <AllData>[].obs;
  var otherGymsList = <DataModel>[].obs;
  var isLoading = false.obs;
  var isMyLoading = false.obs;
  var isMapLoading = false.obs;
  var isOtherLoading = false.obs;
  var filterLoading = false.obs;
  getData() async {
    try {
      isLoading(true);
      update();

      var profData = await ApiManger.userAllGyms();
      if (profData != null) {
        gymList.value = profData.data as dynamic;
        print(
            "This is gym ${profData.data?.length}");
      } else {
        isLoading(false);
        update();
      }
    } catch (e) {
      isLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      isLoading(false);
      update();
    }
    update();
  }



  otherData({gymId}) async {
    try {
      isOtherLoading(true);
      update();

      var profData = await ApiManger.otherUser(gymId: gymId.toString());
      if (profData != null) {
        otherGymsList.value = profData.data as dynamic;
        print(
            "This is gym ${profData.data?.length}");
      } else {
        isOtherLoading(false);
        update();
      }
    } catch (e) {
      isOtherLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      isOtherLoading(false);
      update();
    }
    update();
  }

  getMyData() async {
    try {
      isMyLoading(true);
      update();

      var profData = await ApiManger.myAllGyms();
      if (profData != null) {
        gymMyList.value = profData.data as dynamic;
        print(
            "This is gym ${profData.data?.length}");
      } else {
        isMyLoading(false);
        update();
      }
    } catch (e) {
      isMyLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      isMyLoading(false);
      update();
    }
    update();
  }



  mapMyData({lat,lng}) async {
    try {
      isMapLoading(true);
      update();

      var profData = await ApiManger.mapGyms(lng: lng,lat: lat);
      if (profData != null) {
        mapList.value = profData.data as dynamic;
        print(
            "This is gym ${profData.data?.length}");
      } else {
        isMapLoading(false);
        update();
      }
    } catch (e) {
      isMapLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      isMapLoading(false);
      update();
    }
    update();
  }




  getFilterData({sessions="",gendar="",fees="",String day="",String time1="",String time=""}) async {
    try {
      filterLoading(true);
      update();

      var profData = await ApiManger.userFilterAllGyms(sess: sessions.toString(),fee: fees.toString(),gend: gendar.toString(),
      time1: time1,day: day,time: time
      );
      if (profData != null) {
        filterGymsList.value = profData.data as dynamic;
        print(
            "This is gym ${profData.data?.length}");
      } else {
        filterLoading(false);
        update();
      }
    } catch (e) {
      filterLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      filterLoading(false);
      update();
    }
    update();
  }
}
