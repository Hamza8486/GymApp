
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/auth/component.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/component.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/confirm_book.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/map_view.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/user_detail.dart';
import 'package:gym_app/app/user/home/controller/user_controller.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/util/toast.dart';
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
}
