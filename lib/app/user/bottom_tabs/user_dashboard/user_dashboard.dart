
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/auth/component.dart';
import 'package:gym_app/app/auth/controller.dart';
import 'package:gym_app/app/auth/login.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/controller/controller.dart';
import 'package:gym_app/app/services/api_manager.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/component.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/filter_data.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/map_view.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/user_detail.dart';
import 'package:gym_app/app/user/home/controller/user_controller.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/util/toast.dart';
import 'package:gym_app/app/widgets/app_button.dart';
import 'package:gym_app/app/widgets/app_text.dart';
import 'package:gym_app/app/widgets/app_textfield.dart';
import 'package:gym_app/app/widgets/bottom_sheet.dart';
import 'package:intl/intl.dart';



class UserDashboard extends StatefulWidget {
  UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  final homeController = Get.put(UserController());

  String ? valueDrop;

  Future<void> _pullRefresh() async {
    setState(() {
      homeController.getMyData();
      homeController.getData();
    });
  }
  TextEditingController end = TextEditingController();
  TextEditingController date = TextEditingController();
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


  }

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
              height: Get.height / 8.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.03,
                        vertical: Get.height * 0.018),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          title: "User Dashboard",
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
            height: Get.height * 0.02,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    margin: EdgeInsets.zero,
                    color: AppColor.whiteColor,
                    shadowColor: AppColor.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 2,
                    child: Obx(
                      () {
                        return AppTextFied(
                          onTap: () {
                            if(Get.put(UserController()).name.value.isEmpty){
                              showAlertDialog1(context: context,text: "Please Login Your Account",
                                  yesOnTap: ()async{
                                    await  Get.delete<UserController>();
                                    await  Get.delete<AuthController>();
                                    await  Get.delete<GymController>();
                                    Get.offAll(LoginView());

                                    Get.back();
                                  }
                              );
                            }
                            else{
                              Get.to(FilterGymData(),
                                  transition: Transition.rightToLeft
                              );

                              homeController.updateGender("");
                              homeController.updateLoader2(false);
                              homeController.updateStartValue("");
                              homeController.updateSessions("");
                              homeController.updateRadius("10");
                            }


                          },
                          isborderline:
                          Get.put(UserController()).name.isEmpty?true:
                          true,
                          isFill: true,
                          isborderline2: true,
                          borderColor:AppColor.borderColorField.withOpacity(0.7),
                          borderColor2: AppColor.borderColorField.withOpacity(0.7),
                          borderRadius1: BorderRadius.circular(10),
                          borderRadius2: BorderRadius.circular(10),
                          isShowCursor: false,
                          isReadOnly: true,
                          isSuffix: true,
                          hint: "What do you looking for?",
                          hintColor: AppColor.greyColor,
                          fontFamily: AppFont.regular,
                          hintSize: Get.height * 0.014,
                          prefixIcon: Image.asset(
                            "assets/img/filterq.png",
                            scale: 26,
                            color: AppColor.blackColor,
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: Get.height * 0.015,
                              horizontal: Get.width * 0.02),
                          fillColor: AppColor.whiteColor,
                          isPrefix: true,
                          borderRadius: BorderRadius.circular(10),

                        );
                      }
                    ),
                  ),
                ),
                SizedBox(width: Get.width*0.03,),
                Obx(
                  () {
                    return GestureDetector(
                      onTap:
                      Get.put(UserController()).name.value.isEmpty?(){
                        showAlertDialog1(context: context,text: "Please Login Your Account!",
                            yesOnTap: ()async{
                              await  Get.delete<UserController>();
                              await  Get.delete<AuthController>();
                              await  Get.delete<GymController>();
                              Get.offAll(LoginView());

                              Get.back();
                            }
                        );
                      }:

                      Get.put(UserController()).gymList.isNotEmpty?(){
                        Get.to(MapViewPage(data1:homeController.gymList ,data: "map",));
                      }:
                          (){
                        flutterToast(msg: "No Data");

                      },
                      child: Card(
                        margin:
                        homeController.gymList.isNotEmpty?
                        EdgeInsets.zero:EdgeInsets.zero,
                        color: AppColor.whiteColor,
                        shadowColor: AppColor.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                          side: BorderSide(color: AppColor.borderColorField.withOpacity(0.7))
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
          SizedBox(
            height: Get.height * 0.01,
          ),


          Expanded(
              child:  Padding(
                padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03),
                child: RefreshIndicator(
                  onRefresh: _pullRefresh,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.01,
                        ),

                        Obx(
                          () {
                            return
                            homeController.isLoading.value?
                            GridView.builder(

                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                primary: false,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: Get.width/Get.height*1.96,
                                    crossAxisSpacing: 4,
                                    mainAxisSpacing: 10),
                                itemCount: 8,
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


                              GridView.builder(

                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                primary: false,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: Get.width/Get.height*1.73,
                                    crossAxisSpacing: 6,
                                    mainAxisSpacing: 16),
                                itemCount:homeController.gymList.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return HomeDataWidget(
                                      onTap: (){
                                        if(Get.put(UserController()).name.value.isEmpty){
                                          showAlertDialog1(context: context,text: "Please Login Your Account",
                                              yesOnTap: ()async{
                                                await  Get.delete<UserController>();
                                                await  Get.delete<AuthController>();
                                                await  Get.delete<GymController>();
                                                Get.offAll(LoginView());

                                                Get.back();
                                              }
                                          );
                                        }
                                        else{
                                          homeController.getVideoData(id:homeController.gymList[index].id.toString() );

                                          Get.to(UserGymDetail(data:homeController.gymList[index] ,));
                                        }


                                      },

                                      desc: homeController.gymList[index].name??"",
                                      image: homeController.gymList[index].img??"",
                                      male: homeController.gymList[index].gender.toString()??"",
                                      session:homeController.gymList[index].sessions ,
                                      price: "${homeController.gymList[index].fees.toString()}₣",
                                      days:homeController.gymList[index].days.toString() ,
                                      time:DateFormat.jm().format(DateFormat("hh:mm").parse(homeController.gymList[index].startTime??"")),
                                      time1:DateFormat.jm().format(DateFormat("hh:mm").parse(homeController.gymList[index].endTime??"")),


                                      address:homeController.gymList[index].address,
                                      child2:Container(),
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
                                                                      gymId: homeController.gymList[index].id.toString(),
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
                                });
                          }
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),


                      ],
                    ),
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
