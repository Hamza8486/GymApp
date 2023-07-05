
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isVisible = true.obs;
  var isVisible1 = true.obs;
  var isVisible2 = true.obs;
  var userType="".obs;
  updateVisibleStatus() {
    isVisible.toggle();
    update();
  }
  updateLoader(val){
    loader.value = val;
    update();


  }
  updateOtp(val){
    otp.value = val;
    update();


  }
  updateLoginLoader(val){
    loaderLogin.value = val;
    update();


  }
  var loader = false.obs;
  var otp = false.obs;
  var loaderLogin = false.obs;
  updateUserType(val){
    userType.value = val;
    update();
  }

  updateVisible1Status() {
    isVisible1.toggle();
    update();
  }
  updateVisible2Status() {
    isVisible2.toggle();
    update();
  }

  var lat="".obs;
  var lng="".obs;
  updateLat(val){
    lat.value=val;
    update();

  }
  updateLng(val){
    lng.value=val;
    update();

  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();


  TextEditingController emailRegController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passRegController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();


  RxBool isCheck = false.obs;
  updateCheck(val) {
    isCheck.value = val;
    update();
  }

  RxBool isCheck2 = false.obs;
  updateCheck2(val) {
    isCheck2.value = val;
    update();
  }

  clear(){
    emailRegController.clear();
    startController.clear();
    endController.clear();
    fullNameController.clear();
    passRegController.clear();
    phoneController.clear();
    addressController.clear();
    updateUserType("");
    updateLng("");
    updateLat("");
  }

}