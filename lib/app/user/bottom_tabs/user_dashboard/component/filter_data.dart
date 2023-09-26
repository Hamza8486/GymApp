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
import 'package:intl/intl.dart';


import '../../../../auth/component.dart';


class FilterGymData extends StatefulWidget {
  const FilterGymData({Key? key}) : super(key: key);

  @override
  State<FilterGymData> createState() => _FilterGymDataState();
}

class _FilterGymDataState extends State<FilterGymData> {
  final gymController = Get.put(UserController());
  var startDate= TextEditingController();
  TextEditingController fee = TextEditingController();
  TextEditingController start = TextEditingController();
  TextEditingController end = TextEditingController();
  String? day;
  String? gymType;
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

  }double _startValue = 0.0;
  double range = 0.0;

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


                          textAuth(text: "Sessions",color: Colors.transparent),
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
                          textAuth(text: "Gender",color: Colors.transparent),
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
                          textAuth(text: "Fee Range",color: Colors.transparent),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          SizedBox(
                            width: Get.width,
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: AppColor.secondary1, // Active segment color
                                inactiveTrackColor: AppColor.secondary, // Inactive segment color
                                thumbColor: AppColor.secondary1,
                                overlayColor: AppColor.white,
                                valueIndicatorColor:AppColor.secondary,
                              ),
                              child: Slider(
                                value: _startValue,
                                min: 0,
                                max: 10000,
                                onChanged: (value) {
                                  setState(() {
                                    _startValue = value;
                                  });
                                },
                                divisions: 100, // Number of divisions
                                label: _startValue.toStringAsFixed(0),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child:  Text("${_startValue.toStringAsFixed(0)}₣",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,

                              style: TextStyle(fontSize: AppSizes.size_12,

                                  color: AppColor.boldBlackColor.withOpacity(0.8),
                                  height:Get.width*0.002,
                                  fontWeight: FontWeight.w700),),
                          ),

                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          textAuth(text: "Radius Range",color: Colors.transparent),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          SizedBox(
                            width: Get.width,

                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: AppColor.secondary1, // Active segment color
                                inactiveTrackColor: AppColor.secondary, // Inactive segment color
                                thumbColor: AppColor.secondary1,
                                overlayColor: AppColor.white,
                                valueIndicatorColor:AppColor.secondary,
                              ),
                              child: Slider(
                                value: range,
                                min: 0,
                                max: 50,
                                onChanged: (value) {
                                  setState(() {
                                    range = value;
                                    gymController.updateRadius(range.toStringAsFixed(0));
                                  });
                                },
                                divisions: 100, // Number of divisions
                                label: "${range.toStringAsFixed(0)} km",
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: AppText(
                              title: range.toStringAsFixed(0),
                              size: AppSizes.size_15,
                              fontWeight: FontWeight.w400,
                              fontFamily: AppFont.semi,
                              color: AppColor.boldBlackColor.withOpacity(0.8),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          textAuth(text: "Gym Type",color: Colors.transparent),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          SizedBox(
                              width: Get.width,
                              child: dropDownAppAdd(
                                hint: "Select gym type",
                                width: Get.width * 0.92,
                                items: [
                                  "yoga",
                                  "pilates",
                                  "boxing",
                                  "karate",
                                  "mma",
                                  "swimming",
                                  "athletics",

                                ],
                                value:gymType,
                                onChange: (value) {
                                  setState(() {
                                    gymType=value.toString();
                                  });



                                },
                              )),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          textAuth(text: "Day",color: Colors.transparent),
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
                                              accentColor:
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

                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    textAuth(text: "Select Start Time",color: Colors.transparent),
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

                                    textAuth(text: "Select End Time",color: Colors.transparent),
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
                             startDate.clear();
                             gymType=null;
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
                                gymController.getFilterData(gendar: gymController.gendarName.value,fees:
                                _startValue==0.0?"":
                                _startValue.toStringAsFixed(0),
                                    sessions: gymController.sessionName.value,
                                  time: start.text,
                                  time1: end.text,
                                  date: startDate.text,
                                  day: day==null?"":day.toString(),
                                  type: gymType==null?"":gymType.toString(),
                                );

                              }:(){
                               if(validateGym(context)){
                                 gymController.updateLoader2(true);
                                 print(_startValue.toStringAsFixed(0));
                                 gymController.getFilterData(gendar: gymController.gendarName.value,fees:
                                 _startValue==0.0?"":
                                 _startValue.toStringAsFixed(0),
                                   sessions: gymController.sessionName.value,
                                   time: start.text,
                                   time1: end.text,
                                   date: startDate.text,
                                   day: day==null?"":day.toString(),
                                   type: gymType==null?"":gymType.toString(),

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
