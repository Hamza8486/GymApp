
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:gym_app/app/auth/address.dart';
import 'package:gym_app/app/auth/controller.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/controller/controller.dart';
import 'package:gym_app/app/services/api_manager.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/util/toast.dart';
import 'package:gym_app/app/widgets/app_button.dart';
import 'package:gym_app/app/widgets/app_text.dart';
import 'package:gym_app/app/widgets/helper_function.dart';
import 'package:gym_app/app/widgets/image_pick.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../auth/component.dart';


class AddGym extends StatefulWidget {
  AddGym({Key? key}) : super(key: key);

  @override
  State<AddGym> createState() => _AddGymState();
}

class _AddGymState extends State<AddGym> {
  final gymController = Get.put(GymController());
  var startDate= TextEditingController();
  var endDate= TextEditingController();
  String ? maleType;
  String ? sessionType;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.put(AuthController()).addressController.clear();
    Get.put(AuthController()).updateLat("");
    Get.put(AuthController()).updateLng("");

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
                              title: "Add Gyms Details",
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
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.text,
                            controller: gymController.nameController,
                          ),

                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          textAuth(text: "Sessions"),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          Row(


                            children: [

                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    sessionType="Solo";
                                  });
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      sessionType=="Solo"?
                                      Icon(Icons.radio_button_checked,color: Colors.black,
                                        size: Get.height*0.023,
                                      ):Icon(Icons.radio_button_off,color: Colors.black,
                                        size: Get.height*0.023,
                                      ),
                                      SizedBox(width: Get.width*0.015,),
                                      AppText(
                                        title: "Solo",
                                        size: AppSizes.size_15,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: AppFont.medium,
                                        color: AppColor.boldBlackColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: Get.width*0.06,),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    sessionType="Group";
                                  });
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      sessionType=="Group"?
                                      Icon(Icons.radio_button_checked,color: Colors.black,
                                        size: Get.height*0.023,
                                      ):Icon(Icons.radio_button_off,color: Colors.black,
                                        size: Get.height*0.023,
                                      ),
                                      SizedBox(width: Get.width*0.015,),
                                      AppText(
                                        title: "Group",
                                        size: AppSizes.size_15,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: AppFont.medium,
                                        color: AppColor.boldBlackColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),


                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          textAuth(text: "Gender"),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          Row(

                            children: [

                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    maleType="Male";
                                  });
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      maleType=="Male"?
                                      Icon(Icons.radio_button_checked,color: Colors.black,
                                        size: Get.height*0.023,
                                      ):Icon(Icons.radio_button_off,color: Colors.black,
                                        size: Get.height*0.023,
                                      ),
                                      SizedBox(width: Get.width*0.015,),
                                      AppText(
                                        title: "Male",
                                        size: AppSizes.size_15,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: AppFont.medium,
                                        color: AppColor.boldBlackColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: Get.width*0.06,),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    maleType="Female";
                                  });
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      maleType=="Female"?
                                      Icon(Icons.radio_button_checked,color: Colors.black,
                                        size: Get.height*0.023,
                                      ):Icon(Icons.radio_button_off,color: Colors.black,
                                        size: Get.height*0.023,
                                      ),
                                      SizedBox(width: Get.width*0.015,),
                                      AppText(
                                        title: "Female",
                                        size: AppSizes.size_15,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: AppFont.medium,
                                        color: AppColor.boldBlackColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
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
                            controller: gymController.feeController,
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
                          textAuth(text: "Select Gym Type"),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          GridView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              primary: false,
                              itemCount: gymController.gymType
                                  .length,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: Get.width /
                                      Get.height * 4.9,
                                  crossAxisSpacing: 4,
                                  mainAxisSpacing: 10),
                              itemBuilder: (BuildContext context,
                                  int index1) {
                                return

                                  GestureDetector(
                                    onTap: () {
                                      gymController
                                          .updateTypeName(gymController
                                          .gymType[index1]);
                                      print(gymController.selectTypeName);


                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Row(
                                        children: [
                                          Obx(
                                            () {
                                              return
                                                gymController.selectTypeName
                                                    .contains(gymController
                                                    .gymType[index1])?
                                                Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(
                                                            5),
                                                        color: AppColor.primaryColor,
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
                                                        gymController.selectTypeName.isEmpty?Colors.white:
                                                        Colors
                                                            .white,
                                                      ),

                                                    )):
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(
                                                          5),
                                                      color: Colors
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
                                                          .transparent,
                                                    ),

                                                  ));
                                            }
                                          ),
                                          SizedBox(
                                            width: Get.width *
                                                0.03,
                                          ),
                                          AppText(
                                              title: gymController
                                                  .gymType[index1],
                                            size: AppSizes.size_14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: AppFont.regular,
                                            color: AppColor.greyColors,),
                                        ],
                                      ),
                                    ),
                                  );
                              }),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          textAuth(text: "Select Days"),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          GridView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              primary: false,
                              itemCount: gymController.daysName
                                  .length,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: Get.width /
                                      Get.height * 4.9,
                                  crossAxisSpacing: 4,
                                  mainAxisSpacing: 10),
                              itemBuilder: (BuildContext context,
                                  int index1) {
                                return

                                  GestureDetector(
                                    onTap: () {
                                      gymController
                                          .updateName(gymController
                                          .daysName[index1]);
                                      print(gymController.selectName);


                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Row(
                                        children: [
                                          Obx(
                                                  () {
                                                return
                                                  gymController.selectName
                                                      .contains(gymController
                                                      .daysName[index1])?
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(
                                                              5),
                                                          color: AppColor.primaryColor,
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
                                                          gymController.selectName.isEmpty?Colors.white:
                                                          Colors
                                                              .white,
                                                        ),

                                                      )):
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(
                                                              5),
                                                          color: Colors
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
                                                              .transparent,
                                                        ),

                                                      ));
                                              }
                                          ),
                                          SizedBox(
                                            width: Get.width *
                                                0.03,
                                          ),
                                          AppText(
                                            title: gymController
                                                .daysName[index1],
                                            size: AppSizes.size_14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: AppFont.regular,
                                            color: AppColor.greyColors,),
                                        ],
                                      ),
                                    ),
                                  );
                              }),

                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    textAuth(text: "Appointment Start Date",
                                        height:AppSizes.size_13
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.012,
                                    ),

                                    betField(

                                      hint: "Start Date",
                                      textInputType: TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.done,
                                      isRead: true,
                                      cur: false,
                                      focusNode: _focusNode,
                                      onChange: (val){
                                        setState(() {

                                        });
                                      },

                                      onTap: () async{
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialEntryMode: DatePickerEntryMode.calendarOnly,

                                            builder: (BuildContext? context,
                                                Widget? child) {
                                              return Center(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(20)),
                                                    width: 350.0,
                                                    height: 500.0,
                                                    child: Theme(
                                                      data: ThemeData.light().copyWith(
                                                        primaryColor:
                                                        AppColor.blackColor,

                                                        colorScheme: ColorScheme.light(
                                                          primary:
                                                          AppColor.blackColor,),
                                                        buttonTheme: ButtonThemeData(
                                                            buttonColor:
                                                            AppColor.primaryColor),
                                                      ),
                                                      child: child!,
                                                    ),
                                                  ));
                                            },
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2050));

                                        if (pickedDate != null) {
                                          startDate.text =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                        }
                                      },
                                      controller: startDate,
                                      child:    IconButton(
                                          onPressed: () {

                                          },
                                          icon: Icon(
                                              Icons.calendar_month,
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

                                    textAuth( text: "Appointment End Date",
                                    height:AppSizes.size_13),
                                    SizedBox(
                                      height: Get.height * 0.012,
                                    ),


                                    betField(

                                      hint: "End Date",
                                      textInputType: TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.done,
                                      isRead: true,
                                      cur: false,
                                      focusNode: _focusNode,
                                      onChange: (val){
                                        setState(() {

                                        });
                                      },

                                      onTap: () async{
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialEntryMode: DatePickerEntryMode.calendarOnly,

                                            builder: (BuildContext? context,
                                                Widget? child) {
                                              return Center(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(20)),
                                                    width: 350.0,
                                                    height: 500.0,
                                                    child: Theme(
                                                      data: ThemeData.light().copyWith(
                                                        primaryColor:
                                                        AppColor.blackColor,

                                                        colorScheme: ColorScheme.light(
                                                          primary:
                                                          AppColor.blackColor,),
                                                        buttonTheme: ButtonThemeData(
                                                            buttonColor:
                                                            AppColor.primaryColor),
                                                      ),
                                                      child: child!,
                                                    ),
                                                  ));
                                            },
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2050));

                                        if (pickedDate != null) {
                                          endDate.text =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                        }
                                      },
                                      controller: endDate,
                                      child:    IconButton(
                                          onPressed: () {

                                          },
                                          icon: Icon(
                                              Icons.calendar_month,
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
                                           Get.put(AuthController()).startController.text= '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                               '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                         });

                                         print('Selected time: $formattedTime');
                                       }
                                     },
                                     controller: Get.put(AuthController()).startController,
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
                                           Get.put(AuthController()).endController.text= '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                               '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                         });
                                       }
                                     },
                                     controller: Get.put(AuthController()).endController,
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textAuth(text: "Upload Image"),
                              SizedBox(
                                height: Get.height * 0.012,
                              ),
                              Get.put(GymController()).file==null?
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
                                                      Get.put(GymController()).file = value!;
                                                    });
                                                  });
                                                }, onGallery: () {
                                                  Navigator.pop(context);
                                                  HelperFunctions.pickImage(ImageSource.gallery)
                                                      .then((value) {
                                                    setState(() {
                                                      Get.put(GymController()).file = value!;
                                                    });
                                                  });
                                                }));

                                          },
                                          child: Center(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/icons/photo.svg",
                                                  height: Get.height * 0.03,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Select Image",
                                                  style: TextStyle(
                                                      fontFamily: AppFont.semi,
                                                      color: AppColor.primaryColor,
                                                      decoration: TextDecoration.underline),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                  ),
                                ),
                              ):Align(
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
                                                Get.put(GymController()).file = value!;
                                              });
                                            });
                                          }, onGallery: () {
                                            Navigator.pop(context);
                                            HelperFunctions.pickImage(ImageSource.gallery)
                                                .then((value) {
                                              setState(() {
                                                Get.put(GymController()).file = value!;
                                              });
                                            });
                                          }));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file( Get.put(GymController()).file as File,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                        gymController.updateLoader(true);
                        ApiManger().addGymResponse(context: context,
                        start: startDate.text,
                          end: endDate.text,
                          gender: maleType.toString(),
                          session: sessionType.toString()
                        );
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
          return gymController.loader.value == false
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


    if (Get.put(GymController()).nameController.text.isEmpty) {
      flutterToast(msg: "Please enter gym name");
      return false;
    }
    if (sessionType==null) {
      flutterToast(msg: "Please select session type");
      return false;
    }
    if (maleType==null) {
      flutterToast(msg: "Please select gender type");
      return false;
    }
    if (Get.put(GymController()).feeController.text.isEmpty) {
      flutterToast(msg: "Please enter gym fee");
      return false;
    }

    if (Get.put(AuthController()).addressController.text.isEmpty) {
      flutterToast(msg: "Please select address");
      return false;
    }
    if (Get.put(GymController()).selectTypeName.isEmpty) {

      flutterToast(msg: "Please select gym type");
      return false;
    }
    if (Get.put(GymController()).selectName.isEmpty) {
      flutterToast(msg: "Please select days");
      return false;
    }
    if (startDate.text.isEmpty) {
      flutterToast(msg: "Please select start date");
      return false;
    }
    if (endDate.text.isEmpty) {
      flutterToast(msg: "Please select end date");
      return false;
    }
    if (Get.put(AuthController()).startController.text.isEmpty) {
      flutterToast(msg: "Please select start time");
      return false;
    }
    if (Get.put(AuthController()).endController.text.isEmpty) {
      flutterToast(msg: "Please select end time");
      return false;
    }
    if (Get.put(GymController()).file==null) {
      flutterToast(msg: "Please select image");
      return false;
    }







    return true;
  }

  Future<void> _showTimePicker(BuildContext context) async {
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
      print('Selected time: ${pickedTime.format(context)}');
    }
  }
}
