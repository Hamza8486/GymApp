import 'package:get/get.dart';

class MapController extends GetxController {
  var isValue = true.obs;


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
  }}