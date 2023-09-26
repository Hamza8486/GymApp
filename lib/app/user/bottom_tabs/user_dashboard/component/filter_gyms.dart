
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/auth/component.dart';
import 'package:gym_app/app/services/api_manager.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/component.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/confirm_book.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/map_view.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/user_detail.dart';
import 'package:gym_app/app/user/home/controller/user_controller.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/util/toast.dart';
import 'package:gym_app/app/widgets/app_button.dart';
import 'package:gym_app/app/widgets/app_text.dart';
import 'package:gym_app/app/widgets/bottom_sheet.dart';
import 'package:intl/intl.dart';



class FilterGyms extends StatefulWidget {
  FilterGyms({Key? key}) : super(key: key);

  @override
  State<FilterGyms> createState() => _FilterGymsState();
}

class _FilterGymsState extends State<FilterGyms> {
  final homeController = Get.put(UserController());
  TextEditingController end = TextEditingController();
  TextEditingController date = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  String ? valueDrop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color:  AppColor.whiteColor,
            elevation: 1,
            child: SizedBox(
              width: Get.width,
              height: Get.height / 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.03,
                        vertical: Get.height * 0.013),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
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
                            SizedBox(width: Get.width*0.03,),

                            AppText(
                              title: "Filter Gyms",
                              color: AppColor.blackColor,
                              size: AppSizes.size_17,
                              fontFamily: AppFont.semi,
                            ),



                          ],
                        ),
                        Obx(
                                () {
                              return GestureDetector(
                                onTap:
                                homeController.filterGymsList.isNotEmpty?(){
                                  Get.to(MapViewPage(data1:homeController.filterGymsList ,data: "map",));
                                }:
                                    (){
                                  flutterToast(msg: "No Data");

                                },
                                child: Card(
                                  margin:
                                  homeController.filterGymsList.isNotEmpty?
                                  EdgeInsets.zero:EdgeInsets.zero,
                                  color: AppColor.whiteColor,
                                  shadowColor: AppColor.whiteColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9),
                                      side: BorderSide(color: AppColor.primaryColor)
                                  ),
                                  elevation: 2,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: Get.width*0.027,vertical: Get.height*0.0135),
                                    child: AppText(
                                      title: "Map View",
                                      size: AppSizes.size_14,
                                      fontFamily: AppFont.medium,
                                      color: AppColor.greyColor,
                                    ),
                                  ),
                                ),
                              );
                            }
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

                      Obx(
                              () {
                            return
                              homeController.filterLoading.value?
                              GridView.builder(

                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  primary: false,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: Get.width/Get.height*1.96,
                                      crossAxisSpacing: 4,
                                      mainAxisSpacing: 10),
                                  itemCount: 4,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return Card(
                                      margin: const EdgeInsets.only(left: 8, right: 8),
                                      color: AppColor.whiteColor,
                                      elevation: 0.3,
                                      shape: RoundedRectangleBorder(

                                        borderRadius: BorderRadius.circular(10),

                                      ),


                                      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      child: getShimmerAllLoading(),);
                                  })  :

                              homeController.filterGymsList.isNotEmpty?
                              GridView.builder(

                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  primary: false,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: Get.width/Get.height*1.73,
                                      crossAxisSpacing: 6,
                                      mainAxisSpacing: 16),
                                  itemCount:homeController.filterGymsList.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return HomeDataWidget(
                                        onTap: (){
                                          homeController.getVideoData(id:homeController.filterGymsList[index].id.toString() );

                                          Get.to(UserGymDetail(data:homeController.filterGymsList[index] ,));
                                          // showModalBottomSheet(
                                          //     backgroundColor: Colors.transparent,
                                          //     isScrollControlled: true,
                                          //     isDismissible: true,
                                          //     context: context,
                                          //     builder: (context) => ConfirmOrder(
                                          //       gymId:homeController.filterGymsList[index].id.toString() ,
                                          //       amount:homeController.filterGymsList[index].fees.toString() ,
                                          //     ));
                                        },

                                        desc: homeController.filterGymsList[index].name??"",
                                        image: homeController.filterGymsList[index].img??"",
                                        male: homeController.filterGymsList[index].gender.toString()??"",
                                        price:"${homeController.filterGymsList[index].fees.toString()}₣",
                                        session:homeController.filterGymsList[index].sessions ,

                                        address:homeController.filterGymsList[index].address,
                                      days:homeController.gymList[index].days.toString() ,
                                      time:DateFormat.jm().format(DateFormat("hh:mm").parse(homeController.filterGymsList[index].startTime??"")),
                                      time1:DateFormat.jm().format(DateFormat("hh:mm").parse(homeController.filterGymsList[index].endTime??"")),
                                      onTap1: (){
                                        setState(() {
                                          end.clear();
                                          date.clear();
                                        });

                                        Get.generalDialog(
                                            barrierDismissible: false,
                                            pageBuilder: (context, __, ___) => WillPopScope(
                                              onWillPop: () async {
                                                // Handle the back button press event
                                                return true; // Return false to prevent dialog from closing
                                              },
                                              child: AlertDialog(

                                                content: SizedBox(
                                                  height: Get.height*0.35,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Center(
                                                        child: AppText(
                                                          title: "Book Appointment",
                                                          size: AppSizes.size_16,
                                                          fontWeight: FontWeight.w400,
                                                          fontFamily: AppFont.semi,
                                                          color: AppColor.boldBlackColor.withOpacity(0.8),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: Get.height * 0.02,
                                                      ),
                                                      textAuth(text: "Select Date",color: Colors.transparent),
                                                      SizedBox(
                                                        height: Get.height * 0.01,
                                                      ),
                                                      betField(

                                                        hint: "Select Date",
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
                                                            date.text =
                                                                DateFormat('yyyy-MM-dd')
                                                                    .format(pickedDate);
                                                          }
                                                        },
                                                        controller: date,
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
                                                      textAuth(text: "Select time",color: Colors.transparent),
                                                      SizedBox(
                                                        height: Get.height * 0.01,
                                                      ),
                                                      betField(

                                                        hint: "Select time",
                                                        textInputType: TextInputType.visiblePassword,
                                                        textInputAction: TextInputAction.done,
                                                        isRead: true,
                                                        cur: false,
                                                        focusNode: _focusNode,
                                                        onChange: (val){
                                                          setState(() {

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
                                                      SizedBox(
                                                        height: Get.height * 0.04,
                                                      ),
                                                      Obx(
                                                              () {
                                                            return
                                                              Get.put(UserController()).bookAppoint.value?
                                                              Container(
                                                                width: Get.width,
                                                                child: Center(
                                                                    child: SpinKitThreeBounce(
                                                                        size: 25, color: AppColor.primaryColor1)
                                                                ),
                                                              ):

                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: AppButton(
                                                                        buttonWidth: Get.width,
                                                                        buttonRadius: BorderRadius.circular(10),
                                                                        buttonName: "Close",
                                                                        fontWeight: FontWeight.w500,
                                                                        buttonHeight: Get.height*0.054,
                                                                        textSize: AppSizes.size_15,
                                                                        buttonColor: AppColor.primaryColor,
                                                                        textColor: AppColor.whiteColor,
                                                                        onTap: () {
                                                                          Get.back();



                                                                        }),
                                                                  ),
                                                                  SizedBox(width: Get.width*0.03,),
                                                                  Expanded(
                                                                    child: AppButton(
                                                                        buttonWidth: Get.width,
                                                                        buttonRadius: BorderRadius.circular(10),
                                                                        buttonName: "Book Now",
                                                                        fontWeight: FontWeight.w500,
                                                                        buttonHeight: Get.height*0.054,
                                                                        textSize: AppSizes.size_15,
                                                                        buttonColor: AppColor.primaryColor,
                                                                        textColor: AppColor.whiteColor,
                                                                        onTap: () {
                                                                          if(validateBook(context)){
                                                                            Get.put(UserController()).updateAppoint(true);
                                                                            ApiManger().bookAppointmnet(context: context,
                                                                                gymId: homeController.filterGymsList[index].id.toString(),
                                                                                end: end.text,
                                                                                date: date.text
                                                                            );
                                                                            print(date.text);
                                                                            print(end.text);
                                                                          }




                                                                        }),
                                                                  ),
                                                                ],
                                                              );
                                                          }
                                                      )

                                                    ],
                                                  ),
                                                ),

                                              ),
                                            ));
                                      },
                                    );
                                  }):noData(height: Get.height * 0.3,);
                          }
                      ),
                      SizedBox(
                        height: Get.height * 0.015,
                      ),


                    ],
                  ),
                ),
              )
          ),


        ],
      ),
    );
  }
  bool validateBook(BuildContext context) {


    if (date.text.isEmpty) {
      flutterToast(msg: "Please select date");
      return false;
    }
    if (end.text.isEmpty) {
      flutterToast(msg: "Please select time");
      return false;
    }








    return true;
  }
}
