
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/component.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/confirm_book.dart';
import 'package:gym_app/app/user/bottom_tabs/userprofile/component/detail_page.dart';

import 'package:gym_app/app/user/home/controller/user_controller.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/widgets/app_text.dart';
import 'package:gym_app/app/widgets/helper_function.dart';



class MyBookings extends StatefulWidget {
  MyBookings({Key? key}) : super(key: key);

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  final homeController = Get.put(UserController());

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
                          title: "My Bookings",
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
                        height: Get.height * 0.02,
                      ),

                      Obx(
                              () {
                            return
                              homeController.isMyLoading.value?
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

                              homeController.gymMyList.isNotEmpty?
                              GridView.builder(

                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  primary: false,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: Get.width/Get.height*1.9,
                                      crossAxisSpacing: 6,
                                      mainAxisSpacing: 16),
                                  itemCount:homeController.gymMyList.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return HomeDataWidget(
                                        onTap: (){
                                          Get.to(OtherDetail(data:homeController.gymMyList[index] ,),
                                          transition: Transition.rightToLeft
                                          );
                                          homeController.otherData(gymId:homeController.gymMyList[index].id.toString() );
                                        },
                                        child: SizedBox.shrink(),

                                        desc: homeController.gymMyList[index].name??"",
                                        image: homeController.gymMyList[index].img??"",
                                        session: "",
                                        male: homeController.gymMyList[index].gender.toString()??"",
                                        price: homeController.gymMyList[index].sessions.toString()??"",

                                        address:homeController.gymMyList[index].address
                                    );
                                  }):noData(height: Get.height*0.3);
                          }
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
