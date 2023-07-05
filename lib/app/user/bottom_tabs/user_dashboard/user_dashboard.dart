
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/auth/component.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/component.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/confirm_book.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/filter_data.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/map_view.dart';
import 'package:gym_app/app/user/home/controller/user_controller.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/util/toast.dart';
import 'package:gym_app/app/widgets/app_text.dart';
import 'package:gym_app/app/widgets/app_textfield.dart';
import 'package:gym_app/app/widgets/helper_function.dart';
import 'package:intl/intl.dart';



class UserDashboard extends StatefulWidget {
  UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  final homeController = Get.put(UserController());

  String ? valueDrop;

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
                          title: "Dashboard",
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
                    child: AppTextFied(
                      onTap: () {
                        Get.to(FilterGymData(),
                        transition: Transition.rightToLeft
                        );

                        homeController.updateGender("");
                        homeController.updateLoader2(false);
                        homeController.updateStartValue("");
                        homeController.updateSessions("");
                        homeController.updateRadius("10");

                      },
                      isborderline: true,
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

                    ),
                  ),
                ),
                SizedBox(width: Get.width*0.03,),
                Obx(
                  () {
                    return SizedBox(
                        width: Get.width*0.27,
                        child: dropDownAppAdd(
                          hint: "Sort By",
                          width:
                          homeController.gymList.isEmpty?Get.width * 0.26:
                          Get.width * 0.26,
                          color: AppColor.borderColorField.withOpacity(0.7),
                          items: [
                            "Map View",

                          ],
                          value: valueDrop,
                          onChange: (value) {
                            setState(() {
                              valueDrop = value;
                              if(value == "Map View"){
                                setState(() {
                                  if(homeController.gymList.isEmpty){
                                    flutterToast(msg: "No Data");
                                  }else{
                                    Get.to(MapViewPage(data1:homeController.gymList ,data: "map",));
                                  }

                                });

                              }
                              else if(value == "Near Me"){
                                setState(() {

                                });
                              }
                            });



                          },
                        ));
                  }
                ),

              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.015,
          ),


          Expanded(
              child:  Padding(
                padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.02,
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
                                  childAspectRatio: Get.width/Get.height*1.42,
                                  crossAxisSpacing: 6,
                                  mainAxisSpacing: 16),
                              itemCount:homeController.gymList.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return HomeDataWidget(
                                    onTap: (){
                                      showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          isScrollControlled: true,
                                          isDismissible: true,
                                          context: context,
                                          builder: (context) => ConfirmOrder(
                                            gymId:homeController.gymList[index].id.toString() ,
                                            amount:homeController.gymList[index].fees.toString() ,
                                            name:homeController.gymList[index].name.toString() ,
                                          ));
                                    },

                                    desc: homeController.gymList[index].name??"",
                                    image: homeController.gymList[index].img??"",
                                    male: homeController.gymList[index].gender.toString()??"",
                                    session:homeController.gymList[index].sessions ,
                                    price: "\$ ${homeController.gymList[index].fees.toString()}",
                                    days:homeController.gymList[index].days.toString() ,
                                    time:DateFormat.jm().format(DateFormat("hh:mm").parse(homeController.gymList[index].startTime??"")),
                                    time1:DateFormat.jm().format(DateFormat("hh:mm").parse(homeController.gymList[index].endTime??"")),


                                    address:homeController.gymList[index].address
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
              )
          ),



        ],
      ),
    );
  }
}
