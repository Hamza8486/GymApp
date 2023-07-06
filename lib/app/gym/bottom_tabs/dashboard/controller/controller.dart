
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class GymController extends GetxController {

  var countryName="".obs;
  var time = "".obs;
  List<String> daysName = ['Sun', 'Mon', 'Tue','Wed','Thu','Fri','Sat'];
  updateTime(val) {
    time.value = val;
    update();
  }


  var time1 = "".obs;
  updateTime1(val) {
    time1.value = val;
    update();
  }
  var timeValue = "".obs;
  var timeValue1 = "".obs;

  updateTimeValue(val) {
    timeValue.value = val;
    update();
  }
  updateTimeValue1(val) {
    timeValue1.value = val;
    update();
  }
  var sessionName="".obs;
  updateSessions(val){
    sessionName.value = val;
    update();
  }
  var sessionEditName="".obs;
  var gendarName="".obs;
  updateGender(val){
    gendarName.value = val;
    update();
  }
  var gendarEditName="".obs;
  File ? file;
  File ? file1;



  updateCoName(val){
    countryName.value = val;
    update();
  }

  updateEditSessions(val){
    sessionEditName.value = val;
    update();
  }

  updateEditGender(val){
    gendarEditName.value = val;
    update();
  }





  TextEditingController nameController = TextEditingController();
  TextEditingController nameEditController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController feeController = TextEditingController();
  TextEditingController feeEditController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  updateLoader(val){
    loader.value = val;
    update();


  }
  updateLoader1(val){
    loader1.value = val;
    update();


  }
  var loader = false.obs;
  var loader1 = false.obs;

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
    nameController.clear();
    startController.clear();
    endController.clear();
    feeController.clear();
    updateTime("");
    updateWeek("");
    updateWeek1("");
    updateWeek2("");
    updateWeek3("");
    updateWeek4("");
    updateWeek5("");
    updateWeek6("");
    updateName1("");
    updateTime1("");
    updateTimeValue("");
    updateTimeValue1("");
    updateName("");
    selectName.clear();
    selectName1.clear();

    addressController.clear();
    updateSessions("");
    updateGender("");
    updateLng("");
    updateLat("");
  }

  clearEdit(){
    nameEditController.clear();
    feeEditController.clear();
    selectName1.clear();
    startController.clear();
    endController.clear();
    updateTime("");
    updateWeek("");
    updateWeek1("");
    updateWeek2("");
    updateWeek3("");
    updateWeek4("");
    updateWeek5("");
    updateWeek6("");
    updateTime1("");
    updateTimeValue("");
    updateTimeValue1("");
    updateName("");
    updateName1("");
    selectName.clear();

    addressController.clear();
    updateEditSessions("");
    updateEditGender("");
    updateLng("");
    updateLat("");
  }

  var selectIndex = [].obs;
  var selectName = [].obs;
  var selectName1 = [].obs;



  updateName(var val) {
    if (selectName.contains(val)) {
      selectName.remove(val);
    } else {
      selectName.add(val);
    }
    update();
  }

  updateName1(var val) {
    if (selectName1.contains(val)) {
      selectName1.remove(val);
    } else {
      selectName1.add(val);
    }
    update();
  }


  var week="".obs;
  var week1="".obs;
  var week2="".obs;
  var week3="".obs;
  var week4="".obs;
  var week5="".obs;
  var week6="".obs;

  updateWeek(val){
    week.value=val;
    update();
  }
  updateWeek1(val){
    week1.value=val;
    update();
  }
  updateWeek2(val){
    week2.value=val;
    update();
  }
  updateWeek3(val){
    week3.value=val;
    update();
  }
  updateWeek4(val){
    week4.value=val;
    update();
  }
  updateWeek5(val){
    week5.value=val;
    update();
  }
  updateWeek6(val){
    week6.value=val;
    update();
  }


}