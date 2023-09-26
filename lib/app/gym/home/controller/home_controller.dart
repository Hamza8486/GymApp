import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/model/avail_model.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/model/gym_model.dart';
import 'package:gym_app/app/services/api_manager.dart';
import 'package:gym_app/app/widgets/helper_function.dart';



class HomeController extends GetxController {
  var isValue = true.obs;
  var gymId="".obs;
  updateGymId(val){
    gymId.value=val;
    update();
  }
  updateLoader(val){
    loader.value = val;
    update();


  }

  updatePayLoader(val){
    loaderPay.value = val;
    update();


  }

  AvailData ? availData;
  var loader = false.obs;
  var availloader = false.obs;
  var loaderVideo = false.obs;
  var loaderDeleteVideo = false.obs;
  updateVideoLoader(val){
    loaderVideo.value=val;
    update();
  }
  updateVideoDeleteLoader(val){
    loaderDeleteVideo.value=val;
    update();
  }
  var loaderPay = false.obs;
  var id = "".obs;
  var name = "".obs;
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
  File ? myProfile;


  @override
  Future<void> onInit() async {

    HelperFunctions.getFromPreference("id").then((value) {
      id.value = value;
      print(id.value.toString());
      getData();
      imageData();
      getAvailData();
      appointGyymData();

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

  var slot="".obs;
  File?file;
  var gymList = [].obs;
  var getVideoList = [].obs;
  var isLoading = false.obs;
  var isVideoLoading = false.obs;


  getAvailData() async {
    try {
      availloader(true);
      update();

      var profData = await ApiManger.getMyAvailModel();
      if (profData != null) {
        availData = profData.data as dynamic;
        print(
            "This is avail ${profData.data}");
      } else {
        availloader(false);
        update();
      }
    } catch (e) {
      availloader(false);
      update();
      debugPrint(e.toString());
    } finally {
      availloader(false);
      update();
    }
    update();
  }


  getData() async {
    try {
      isLoading(true);
      update();

      var profData = await ApiManger.getAllGymResponse();
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
  getVideoData({id}) async {
    try {
      isVideoLoading(true);
      update();

      var profData = await ApiManger.getVideoAll(id:id.toString() );
      if (profData != null) {
        getVideoList.value = profData.data as dynamic;
        print(
            "This is video Data ${profData.data?.length}");
      } else {
        isVideoLoading(false);
        update();
      }
    } catch (e) {
      isVideoLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      isVideoLoading(false);
      update();
    }
    update();
  }
  var image="".obs;
  updateImage(val){
    image.value=val;
    update();
  }
  var imageLoader = false.obs;
  imageData() async {
    try {
      imageLoader(true);
      update();

      var profData = await ApiManger.getProfileUser1();
      if (profData != null) {
        updateImage(profData.data?.img==null?"":profData.data?.img);

      } else {
        imageLoader(false);
        update();
      }
    } catch (e) {
      imageLoader(false);
      update();
      debugPrint(e.toString());
    } finally {
      imageLoader(false);
      update();
    }
    update();
  }


  var gymAppoint = false.obs;
  var gymAppointList = [].obs;

  appointGyymData() async {
    try {
      gymAppoint(true);
      update();

      var profData = await ApiManger.getGymAppointModel();
      if (profData != null) {
        gymAppointList.value = profData.data as dynamic;
        print(
            "This is appointmentData ${profData.data?.length}");
      } else {
        gymAppoint(false);
        update();
      }
    } catch (e) {
      gymAppoint(false);
      update();
      debugPrint(e.toString());
    } finally {
      gymAppoint(false);
      update();
    }
    update();
  }

}

