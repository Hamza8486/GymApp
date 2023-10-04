
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import 'package:gym_app/app/auth/controller.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/controller/controller.dart';
import 'package:gym_app/app/services/api_manager.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/util/toast.dart';
import 'package:gym_app/app/widgets/app_button.dart';
import 'package:gym_app/app/widgets/app_text.dart';

import 'package:intl/intl.dart';

import '../../../../auth/component.dart';


class AddAvailbility extends StatefulWidget {
  AddAvailbility({Key? key}) : super(key: key);

  @override
  State<AddAvailbility> createState() => _AddAvailbilityState();
}

class _AddAvailbilityState extends State<AddAvailbility> {
  final gymController = Get.put(GymController());
  var startDate= TextEditingController();
  var endDate= TextEditingController();
  var startTime= TextEditingController();
  var endTime= TextEditingController();

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
                              title: "Add Availability",
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
                            height: Get.height * 0.005,
                          ),


                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    textAuth(text: "Select Start Date"),
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

                                    textAuth(text: "Select End Date"),
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
                            height: Get.height * 0.035,
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
                                            startTime.text= '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                                '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                          });

                                          print('Selected time: $formattedTime');
                                        }
                                      },
                                      controller: startTime,
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
                                            endTime.text= '${pickedTime.hour.toString().padLeft(2, '0')}:'
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
                            height: Get.height * 0.035,
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
                    buttonName: "Add",

                    fontWeight: FontWeight.w500,
                    textSize: AppSizes.size_15,
                    buttonColor: AppColor.primaryColor,
                    textColor: AppColor.whiteColor,
                    onTap: () {
                      if(validateAvail(context)){
                        gymController.updateLoader(true);
                        ApiManger().addAvail(context: context,
                        startDate: startDate.text,
                          endDate: endDate.text,
                          startTime: startTime.text,
                          endTime: endTime.text
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
  bool validateAvail(BuildContext context) {


    if (startDate.text.isEmpty) {
      flutterToast(msg: "Please select start date");
      return false;
    }
    if (endDate.text.isEmpty) {
      flutterToast(msg: "Please select end date");
      return false;
    }
    if (startTime.text.isEmpty) {
      flutterToast(msg: "Please select start time");
      return false;
    }
    if (endTime.text.isEmpty) {
      flutterToast(msg: "Please select end time");
      return false;
    }

    if (Get.put(GymController()).selectName.isEmpty) {
      flutterToast(msg: "Please select days");
      return false;
    }






    return true;
  }


}
