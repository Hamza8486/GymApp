import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/confirm_book.dart';
import 'package:gym_app/app/user/home/controller/user_controller.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/widgets/app_text.dart';
import 'package:gym_app/app/widgets/helper_function.dart';
import 'package:intl/intl.dart';


class NearByDealList extends StatelessWidget {
   NearByDealList({Key? key }) : super(key: key);

   final nearController = Get.put(UserController());


  @override
  Widget build(BuildContext context) {

    var size = Get.size;
    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.45,
      maxChildSize: 0.45,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.02, ),
          child: Column(
            children: [

              SizedBox(
                height: Get.height * 0.025,
              ),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      title: "Nearby Gyms",
                      color: AppColor.blackColor,
                      fontFamily: AppFont.semi,
                      size: AppSizes.size_16,
                    ),
                    Container()
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
    Obx(
    () {

      return
        nearController.isMapLoading.value ?
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return  Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: getShimmerLoading(),
                );
              }),
        ):

        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: nearController.mapList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(
                              () {
                            return Padding(
                              padding:  EdgeInsets.symmetric(vertical: 10,horizontal: size.width * 0.04),
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true,
                                      isDismissible: true,
                                      context: context,
                                      builder: (context) => ConfirmOrder(
                                        gymId:nearController.mapList[index].id.toString() ,
                                        amount:nearController.mapList[index].fees.toString() ,
                                      ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                    color: AppColor.whiteColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.15),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 2), // changes position of shadow
                                      ),
                                    ],


                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        Row(

                                          children: [

                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                  placeholder: (context, url) =>  Center(
                                                    child: SpinKitThreeBounce(
                                                        size: 20,
                                                        color: AppColor.primaryColor
                                                    ),
                                                  ),
                                                  imageUrl: nearController.mapList[index].img??"",
                                                  height: Get.height * 0.1,
                                                  width: Get.height * 0.1,
                                                  fit: BoxFit.cover,

                                                  errorWidget: (context, url, error) => ClipRRect(
                                                    borderRadius: BorderRadius.circular(10),
                                                    child: Image.asset(
                                                      "assets/img/gym.jpeg",
                                                      height: Get.height * 0.1,
                                                      width: Get.height * 0.1,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                              ),











                                            ),

                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: Get.width * 0.017),
                                                child: Column(

                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: Get.width * 0.33,
                                                          child: AppText(
                                                            title:
                                                            nearController.mapList[index].name??"",
                                                            maxLines: 1,
                                                            overFlow: TextOverflow.ellipsis,
                                                            fontFamily: AppFont.medium,
                                                            size: AppSizes.size_12,
                                                            color: AppColor.blackColor,
                                                          ),
                                                        ),
                                                        AppText(
                                                          title:"\$${nearController.mapList[index].fees.toString()}",
                                                          maxLines: 1,
                                                          overFlow: TextOverflow.ellipsis,
                                                          fontFamily: AppFont.medium,
                                                          size: AppSizes.size_12,
                                                          color: AppColor.blackColor,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.006,
                                                    ),

                                                    Row(

                                                      children: [
                                                        Icon(Icons.female,color: AppColor.primaryColor,
                                                          size: 22,
                                                        ),
                                                        SizedBox(
                                                          width: Get.width * 0.005,
                                                        ),
                                                        AppText(
                                                          title: nearController.mapList[index].gender??"",
                                                          overFlow: TextOverflow.ellipsis,
                                                          maxLines: 1,
                                                          size: Get.height * 0.014,
                                                          textAlign: TextAlign.start,
                                                          color: AppColor.greyColors,
                                                          fontFamily: AppFont.medium,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.007,
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.44,
                                                      child: AppText(
                                                        title:
                                                        "${nearController.mapList[index].address}",
                                                        maxLines: 1,
                                                        overFlow: TextOverflow.ellipsis,
                                                        color: AppColor.greyColors,
                                                        fontFamily: AppFont.medium,
                                                        size: AppSizes.size_12,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.008,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color:  AppColor.primaryColor,
                                                              borderRadius: BorderRadius.circular(10)),
                                                          child: Padding(
                                                            padding: EdgeInsets.symmetric(horizontal: Get.width*0.027,vertical: Get.height*0.007),
                                                            child: AppText(
                                                              title: "Book Now",
                                                              size: Get.height * 0.01,
                                                              fontFamily: AppFont.semi,
                                                              color: AppColor.whiteColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),


                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.008,
                                        ),

                                        Row(
                                          children: [
                                            Icon(Icons.access_time_outlined,color: AppColor.greyColors,
                                              size:17,
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.005,
                                            ),
                                            AppText(
                                              title: " ${DateFormat.jm().format(DateFormat("hh:mm").parse(nearController.mapList[index].startTime??""))} - ${DateFormat.jm().format(DateFormat("hh:mm").parse(nearController.mapList[index].endTime??""))}",
                                              overFlow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              size: Get.height * 0.014,
                                              textAlign: TextAlign.start,
                                              color: AppColor.greyColors,
                                              fontFamily: AppFont.medium,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.008,
                                        ),

                                        Row(
                                          children: [
                                            AppText(
                                              title: "Open Days: ",
                                              overFlow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              size: Get.height * 0.014,
                                              letterSpacing: 0.7,
                                              textAlign: TextAlign.start,
                                              color: AppColor.black,
                                              fontFamily: AppFont.semi,
                                            ),
                                            SizedBox(width: 5,),
                                            AppText(
                                              title: nearController.mapList[index].days??"",
                                              overFlow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              size: Get.height * 0.014,
                                              letterSpacing: 0.7,
                                              textAlign: TextAlign.start,
                                              color: AppColor.greyColors,
                                              fontFamily: AppFont.medium,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                      );
                    }),
                SizedBox(
                  height: Get.height * 0.06,
                ),
              ],
            ),
          ),
        );
    }
    )
            ],
          ),
        ),
      ),
    );
  }
}


