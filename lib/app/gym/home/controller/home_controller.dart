import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/model/gym_model.dart';
import 'package:gym_app/app/services/api_manager.dart';
import 'package:gym_app/app/widgets/helper_function.dart';



class HomeController extends GetxController {
  var isValue = true.obs;
  updateLoader(val){
    loader.value = val;
    update();


  }

  updatePayLoader(val){
    loaderPay.value = val;
    update();


  }
  var loader = false.obs;
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


  @override
  Future<void> onInit() async {

    HelperFunctions.getFromPreference("id").then((value) {
      id.value = value;
      print(id.value.toString());
      getData();

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
  var gymList = <GymDataModelAll>[].obs;
  var isLoading = false.obs;
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
}

