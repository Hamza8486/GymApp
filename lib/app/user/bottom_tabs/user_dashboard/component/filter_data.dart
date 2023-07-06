import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:gym_app/app/auth/controller.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/controller/controller.dart';
import 'package:gym_app/app/services/api_manager.dart';
import 'package:gym_app/app/user/home/controller/user_controller.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/util/toast.dart';
import 'package:gym_app/app/widgets/app_button.dart';
import 'package:gym_app/app/widgets/app_text.dart';


import '../../../../auth/component.dart';


class FilterGymData extends StatefulWidget {
  const FilterGymData({Key? key}) : super(key: key);

  @override
  State<FilterGymData> createState() => _FilterGymDataState();
}

class _FilterGymDataState extends State<FilterGymData> {
  final gymController = Get.put(UserController());
  TextEditingController fee = TextEditingController();
  TextEditingController start = TextEditingController();
  TextEditingController end = TextEditingController();
  String? day;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.put(AuthController()).addressController.clear();
    Get.put(AuthController()).updateLat("");
    Get.put(AuthController()).updateLng("");

  }

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColor.whiteColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                color:  AppColor.whiteColor,
                elevation: 1,
                child: SizedBox(
                  width: Get.width,
                  height: Get.height / 8.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.03,
                            vertical: Get.height * 0.018),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap:(){
                                Get.back();
                              },
                              child: Container(
                                  color: Colors.transparent,

                                  child: Icon(Icons.arrow_back_ios)),
                            ),

                            AppText(
                              title: "Apply Filter",
                              color: AppColor.blackColor,
                              size: AppSizes.size_17,
                              fontFamily: AppFont.semi,
                            ),
                            AppText(
                              title: "",
                              color: AppColor.blackColor,
                              size: AppSizes.size_17,
                              fontFamily: AppFont.semi,
                            ),


                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),


              Expanded(
                  child:  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.01,
                          ),


                          textAuth(text: "Sessions"),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          SizedBox(
                              width: Get.width,
                              child: Obx(() {
                                return dropDownAppAdd(
                                  hint: "Select session type",
                                  width: Get.width * 0.92,
                                  items: [
                                    "Solo",
                                    "Group",

                                  ],
                                  value:gymController.sessionName.value.isEmpty?null:gymController.sessionName.value,
                                  onChange: (value) {
                                    gymController.updateSessions(value.toString());


                                  },
                                );
                              })),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          textAuth(text: "Gender"),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          SizedBox(
                              width: Get.width,
                              child: Obx(() {
                                return dropDownAppAdd(
                                  hint: "Select gender",
                                  width: Get.width * 0.92,
                                  items: [
                                    "Male",
                                    "Female",
                                    "Other",

                                  ],
                                  value:gymController.gendarName.value.isEmpty?null:gymController.gendarName.value,
                                  onChange: (value) {
                                    gymController.updateGender(value.toString());


                                  },
                                );
                              })),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          textAuth(text: "Gym Fee"),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          betField(
                            hint: "Gym Fee",
                            isSuffix: true,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.phone,
                            controller: fee,
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          textAuth(text: "Radius"),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          SizedBox(
                              width: Get.width,
                              child: Obx(() {
                                return dropDownAppAdd(
                                  hint: "Select Radius",
                                  width: Get.width * 0.92,
                                  items: [
                                    "10",
                                    "20",
                                    "30",
                                    "40",
                                    "50",

                                  ],
                                  value:gymController.radius.value.isEmpty?null:gymController.radius.value,
                                  onChange: (value) {
                                    gymController.updateRadius(value.toString());


                                  },
                                );
                              })),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          textAuth(text: "Day"),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          SizedBox(
                              width: Get.width,
                              child: dropDownAppAdd(
                                hint: "Select day",
                                width: Get.width * 0.92,
                                items: [
                                  "Mon",
                                  "Tue",
                                  "Wed",
                                  "Thu",
                                  "Fri",
                                  "Sat",
                                  "Sun",

                                ],
                                value:day,
                                onChange: (value) {
                                  setState(() {
                                    day=value.toString();
                                  });



                                },
                              )),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),


                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    textAuth(text: "Select Start Time"),
                                    SizedBox(
                                      height: Get.height * 0.012,
                                    ),

                                    betField(

                                      hint: "Select start time",
                                      textInputType: TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.done,
                                      isRead: true,
                                      focusNode: _focusNode,
                                      onChange: (val){
                                        setState(() {
                                          gymController.updateStartValue(start.text);
                                        });
                                      },
                                      cur: false,


                                      onTap: ()async{
                                        _focusNode.unfocus();
                                        final TimeOfDay? pickedTime = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                          builder: (BuildContext context, Widget? child) {
                                            return MediaQuery(
                                              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                              child: child!,
                                            );
                                          },
                                        );

                                        if (pickedTime != null) {
                                          final String formattedTime =
                                              '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                              '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                          setState(() {
                                            start.text= '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                                '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                          });

                                          print('Selected time: $formattedTime');
                                        }
                                      },
                                      controller: start,
                                      child:    IconButton(
                                          onPressed: () {

                                          },
                                          icon: Icon(
                                              Icons.access_time_rounded,
                                              size: Get.height * 0.022,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: Get.width*0.04,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    textAuth(text: "Select End Time"),
                                    SizedBox(
                                      height: Get.height * 0.012,
                                    ),

                                    betField(

                                      hint: "Select end time",
                                      textInputType: TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.done,
                                      isRead: true,
                                      cur: false,
                                      focusNode: _focusNode,
                                      onChange: (val){
                                        setState(() {
                                          gymController.updateStartValue(end.text);
                                        });
                                      },

                                      onTap: ()async{

                                        final TimeOfDay? pickedTime = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                          builder: (BuildContext context, Widget? child) {
                                            return MediaQuery(
                                              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                              child: child!,
                                            );
                                          },
                                        );

                                        if (pickedTime != null) {
                                          final String formattedTime =
                                              '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                              '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                          setState(() {
                                            end.text= '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                                '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                          });
                                        }
                                      },
                                      controller: end,
                                      child:    IconButton(
                                          onPressed: () {

                                          },
                                          icon: Icon(
                                              Icons.access_time_rounded,
                                              size: Get.height * 0.022,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),



                        ],
                      ),
                    ),
                  )
              ),
              isKeyBoard?SizedBox.shrink():
              SizedBox(
                height: Get.height * 0.01,
              ),
              isKeyBoard?SizedBox.shrink():
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: Get.width*0.036),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                          buttonWidth: Get.width,
                          buttonRadius: BorderRadius.circular(10),
                          buttonName: "Reset",

                          fontWeight: FontWeight.w500,
                          textSize: AppSizes.size_15,
                          buttonColor: AppColor.primaryColor,
                          textColor: AppColor.whiteColor,
                          onTap: () {
                           setState(() {
                             fee.clear();
                             end.clear();
                             start.clear();
                             gymController.updateGender("");
                             gymController.updateSessions("");
                             gymController.updateRadius("10");

                           });

                          }),
                    ),
                    SizedBox(width: Get.width*0.05,),
                    Expanded(
                      child: Obx(
                        () {
                          return AppButton(
                              buttonWidth: Get.width,
                              buttonRadius: BorderRadius.circular(10),
                              buttonName: "Apply",

                              fontWeight: FontWeight.w500,
                              textSize: AppSizes.size_15,
                              buttonColor: AppColor.primaryColor,
                              textColor: AppColor.whiteColor,
                              onTap:
                              gymController.startValue.isEmpty?

                                  () {
                                gymController.updateLoader2(true);
                                gymController.getFilterData(gendar: gymController.gendarName.value,fees: fee.text,
                                    sessions: gymController.sessionName.value,
                                  time: start.text,
                                  time1: end.text,
                                  day: day==null?"":day.toString(),
                                );

                              }:(){
                               if(validateGym(context)){
                                 gymController.updateLoader2(true);
                                 gymController.getFilterData(gendar: gymController.gendarName.value,fees: fee.text,
                                   sessions: gymController.sessionName.value,
                                   time: start.text,
                                   time1: end.text,
                                   day: day==null?"":day.toString(),
                                 );
                               }
                              });
                        }
                      ),
                    ),
                  ],
                ),

              ),
              isKeyBoard?SizedBox.shrink():
              SizedBox(
                height: Get.height * 0.01,
              ),

            ],
          ),
        ),
        Obx(() {
          return gymController.loader2.value == false
              ? SizedBox.shrink()
              : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black26,
            child:  Center(
                child: SpinKitThreeBounce(
                    size: 25, color: AppColor.primaryColor1)
            ),
          );



        })
      ],
    );
  }

  bool validateGym(BuildContext context) {


    if (end.text.isEmpty) {
      flutterToast(msg: "Please select start & end date");
      return false;
    }








    return true;
  }


}
