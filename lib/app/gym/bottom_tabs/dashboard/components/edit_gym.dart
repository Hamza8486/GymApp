
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:gym_app/app/auth/address.dart';
import 'package:gym_app/app/auth/controller.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/controller/controller.dart';
import 'package:gym_app/app/gym/home/controller/home_controller.dart';
import 'package:gym_app/app/services/api_manager.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/util/toast.dart';
import 'package:gym_app/app/widgets/app_button.dart';
import 'package:gym_app/app/widgets/app_text.dart';
import 'package:gym_app/app/widgets/helper_function.dart';
import 'package:gym_app/app/widgets/image_pick.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../auth/component.dart';


class EditGym extends StatefulWidget {
  EditGym({Key? key,this.data}) : super(key: key);
  var data;

  @override
  State<EditGym> createState() => _EditGymState();
}

class _EditGymState extends State<EditGym> {
  final gymController = Get.put(GymController());

  @override
  void initState() {

    super.initState();
    gymController.updateWeek(widget.data.days.contains("Sun")?"Sun":"");
    gymController.updateWeek1(widget.data.days.contains("Mon")?"Mon":"");
    gymController.updateWeek2(widget.data.days.contains("Tue")?"Tue":"");
    gymController.updateWeek3(widget.data.days.contains("Wed")?"Wed":"");
    gymController.updateWeek4(widget.data.days.contains("Thu")?"Thu":"");
    gymController.updateWeek5(widget.data.days.contains("Fri")?"Fri":"");
    gymController.updateWeek6(widget.data.days.contains("Sat")?"Sat":"");
    gymController.nameEditController.text=widget.data.name;
    gymController.startController.text=widget.data.startTime;
    gymController.endController.text=widget.data.endTime;
    gymController.feeEditController.text=widget.data.fee==null?"":widget.data.fee.toString();
    Get.put(AuthController()).addressController.text=widget.data.address;


    gymController.updateEditGender(widget.data.gender);
    gymController.updateEditSessions(widget.data.sessions);
    Get.put(AuthController()).updateLat(widget.data.lat.toString());
    Get.put(AuthController()).updateLng(widget.data.loong.toString());

  }
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
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
                              title: "Edit Gyms Details",
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


              SizedBox(
                height: Get.height * 0.005,
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

                          textAuth(text: "Gym Name"),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          betField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return null;
                              }
                              if (!RegExp("[a-zA-Z]").hasMatch(value)) {
                                return null;
                              }
                              return null;
                            },
                            hint: "Gym Name",
                            isSuffix: true,
                            controller: gymController.nameEditController,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.text,
                          ),

                          SizedBox(
                            height: Get.height * 0.02,
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
                                  value:gymController.sessionEditName.value.isEmpty?null:gymController.sessionEditName.value,
                                  onChange: (value) {
                                    gymController.updateEditSessions(value.toString());


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
                                  value:gymController.gendarEditName.value.isEmpty?null:gymController.gendarEditName.value,
                                  onChange: (value) {
                                    gymController.updateEditGender(value.toString());


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
                            controller: gymController.feeEditController,
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          textAuth(text: "Address"),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),

                          betField(

                            hint: "Select Address",
                            textInputType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,

                            onTap: (){
                              Get.to(AddAddress());
                            },
                            controller: Get.put(AuthController()).addressController,
                            child:    IconButton(
                                onPressed: () {

                                },
                                icon: Icon(
                                    Icons.location_searching,
                                    size: Get.height * 0.022,
                                    color: Colors.black)),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          textAuth(text: "Select Days"),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Row(
                            children: [
                              Expanded(child: Obx(
                                () {
                                  return DaysData(name: "Sunday",
                                      color:
                                      gymController.week.value.isNotEmpty?
                                      AppColor.primaryColor:Colors.transparent
                                      ,


                                      onTap: (){
                                    if(gymController.week.value.isNotEmpty){
                                      gymController.updateWeek("");
                                    }
                                    else{
                                      gymController.updateWeek("sun");
                                    }


                                  });

                                },

                              )),
                              SizedBox(width: 8,),
                              Expanded(child: Obx(
                                    () {
                                  return DaysData(name: "Monday",
                                      color:
                                      gymController.week1.value.isNotEmpty?
                                      AppColor.primaryColor:Colors.transparent
                                      ,


                                      onTap: (){
                                        if(gymController.week1.value.isNotEmpty){
                                          gymController.updateWeek1("");
                                        }
                                        else{
                                          gymController.updateWeek1("Mon");
                                        }


                                      });

                                },

                              )),
                              SizedBox(width: 8,),
                              Expanded(child: Obx(
                                    () {
                                  return DaysData(name: "Tuesday",
                                      color:
                                      gymController.week2.value.isNotEmpty?
                                      AppColor.primaryColor:Colors.transparent
                                      ,


                                      onTap: (){
                                        if(gymController.week2.value.isNotEmpty){
                                          gymController.updateWeek2("");
                                        }
                                        else{
                                          gymController.updateWeek2("Tue");
                                        }


                                      });

                                },

                              )),

                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          Row(
                            children: [
                              Expanded(child: Obx(
                                    () {
                                  return DaysData(name: "Wednesday",
                                      color:
                                      gymController.week3.value.isNotEmpty?
                                      AppColor.primaryColor:Colors.transparent
                                      ,


                                      onTap: (){
                                        if(gymController.week3.value.isNotEmpty){
                                          gymController.updateWeek3("");
                                        }
                                        else{
                                          gymController.updateWeek3("Wed");
                                        }


                                      });

                                },

                              )),
                              SizedBox(width: 8,),
                              Expanded(child: Obx(
                                    () {
                                  return DaysData(name: "Thursday",
                                      color:
                                      gymController.week4.value.isNotEmpty?
                                      AppColor.primaryColor:Colors.transparent
                                      ,


                                      onTap: (){
                                        if(gymController.week4.value.isNotEmpty){
                                          gymController.updateWeek4("");
                                        }
                                        else{
                                          gymController.updateWeek4("Thu");
                                        }


                                      });

                                },

                              )),
                              SizedBox(width: 8,),
                              Expanded(child: Obx(
                                    () {
                                  return DaysData(name: "Friday",
                                      color:
                                      gymController.week5.value.isNotEmpty?
                                      AppColor.primaryColor:Colors.transparent
                                      ,


                                      onTap: (){
                                        if(gymController.week5.value.isNotEmpty){
                                          gymController.updateWeek5("");
                                        }
                                        else{
                                          gymController.updateWeek5("fri");
                                        }


                                      });

                                },

                              )),

                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          Obx(
                            () {
                              return DaysData(name: "Saturday",
                                  color:
                                  gymController.week6.value.isNotEmpty?
                                  AppColor.primaryColor:Colors.transparent
                                  ,


                                  onTap: (){
                                    if(gymController.week6.value.isNotEmpty){
                                      gymController.updateWeek6("");
                                    }
                                    else{
                                      gymController.updateWeek6("sat");
                                    }


                                  });
                            }
                          ),

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
                                            Get.put(GymController()).startController.text= '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                                '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                          });

                                          print('Selected time: $formattedTime');
                                        }
                                      },
                                      controller: Get.put(GymController()).startController,
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
                                            Get.put(GymController()).endController.text= '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                                '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                          });
                                        }
                                      },
                                      controller: Get.put(GymController()).endController,
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
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          textAuth(text: "Upload Image"),
                          SizedBox(
                            height: Get.height * 0.012,
                          ),
                          Get.put(GymController()).file1==null?
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              color: Colors.transparent,
                              width: Get.height*0.15,
                              height: Get.height*0.15,
                              child: DottedBorder(
                                  color: Colors.grey,
                                  dashPattern:  [8, 4],
                                  strokeWidth: 1.8,
                                  child:

                                  Center(
                                    child: MaterialButton(
                                      minWidth: Get.width,
                                      onPressed: () {
                                        showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (builder) => bottomSheet(onCamera: () {
                                              Navigator.pop(context);
                                              HelperFunctions.pickImage(ImageSource.camera)
                                                  .then((value) {
                                                setState(() {
                                                  Get.put(GymController()).file1 = value!;
                                                });
                                              });
                                            }, onGallery: () {
                                              Navigator.pop(context);
                                              HelperFunctions.pickImage(ImageSource.gallery)
                                                  .then((value) {
                                                setState(() {
                                                  Get.put(GymController()).file1 = value!;
                                                });
                                              });
                                            }));

                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(widget.data.img,
                                        fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ):

                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              color: Colors.transparent,
                              width: Get.height*0.15,
                              height: Get.height*0.15,
                              child: GestureDetector(
                                onTap: (){
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (builder) => bottomSheet(onCamera: () {
                                        Navigator.pop(context);
                                        HelperFunctions.pickImage(ImageSource.camera)
                                            .then((value) {
                                          setState(() {
                                            Get.put(GymController()).file1 = value!;
                                          });
                                        });
                                      }, onGallery: () {
                                        Navigator.pop(context);
                                        HelperFunctions.pickImage(ImageSource.gallery)
                                            .then((value) {
                                          setState(() {
                                            Get.put(GymController()).file1 = value!;
                                          });
                                        });
                                      }));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file( Get.put(GymController()).file1 as File,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),




                          SizedBox(
                            height: Get.height * 0.032,
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
                child: AppButton(
                    buttonWidth: Get.width,
                    buttonRadius: BorderRadius.circular(10),
                    buttonName: "Continue",

                    fontWeight: FontWeight.w500,
                    textSize: AppSizes.size_15,
                    buttonColor: AppColor.primaryColor,
                    textColor: AppColor.whiteColor,
                    onTap: () {
                      if(validateGym(context)){
                        gymController.updateLoader1(true);
                        ApiManger().editGymResponse(context: context,id: widget.data.id.toString());
                      }

                    }),

              ),
              isKeyBoard?SizedBox.shrink():
              SizedBox(
                height: Get.height * 0.01,
              ),

            ],
          ),
        ),
        Obx(() {
          return gymController.loader1.value == false
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


    if (Get.put(GymController()).nameEditController.text.isEmpty) {
      flutterToast(msg: "Please enter gym name");
      return false;
    }
    if (Get.put(GymController()).sessionEditName.isEmpty) {
      flutterToast(msg: "Please select session type");
      return false;
    }
    if (Get.put(GymController()).gendarEditName.isEmpty) {
      flutterToast(msg: "Please select gender type");
      return false;
    }
    if (Get.put(GymController()).feeEditController.text.isEmpty) {
      flutterToast(msg: "Please enter gym fee");
      return false;
    }

    if (Get.put(AuthController()).addressController.text.isEmpty) {
      flutterToast(msg: "Please select address");
      return false;
    }

    if (Get.put(GymController()).startController.text.isEmpty) {
      flutterToast(msg: "Please select start time");
      return false;
    }
    if (Get.put(GymController()).endController.text.isEmpty) {
      flutterToast(msg: "Please select end time");
      return false;
    }









    return true;
  }


  Widget DaysData({name,Color?color,onTap}){
    return GestureDetector(onTap:onTap ,
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [

        Container(
        decoration: BoxDecoration(
        borderRadius: BorderRadius
            .circular(
        5),
        color: color??Colors
            .transparent,
        border: Border
            .all(
        color:
        AppColor.boldBlackColor.withOpacity(0.8))),
        child: Padding(
        padding: EdgeInsets
            .all(2.0),
        child: Icon(
        Icons.check,

        size: Get
            .height *
        0.018,
        color:

        Colors
            .white,
        ),

        )),

            SizedBox(
              width: Get.width *
                  0.03,
            ),
            AppText(
              title: name,
              size: AppSizes.size_14,
              fontWeight: FontWeight.w400,
              fontFamily: AppFont.regular,
              color: AppColor.greyColors,),
          ],
        ),
      ),
    );
  }
}
