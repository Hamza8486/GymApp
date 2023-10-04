import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/auth/component.dart';
import 'package:gym_app/app/auth/controller.dart';
import 'package:gym_app/app/auth/login.dart';
import 'package:gym_app/app/gym/bottom_tabs/dashboard/controller/controller.dart';
import 'package:gym_app/app/services/api_manager.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/confirm_book.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/component/user_detail.dart';
import 'package:gym_app/app/user/home/controller/user_controller.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/util/toast.dart';
import 'package:gym_app/app/widgets/app_button.dart';
import 'package:gym_app/app/widgets/app_text.dart';
import 'package:gym_app/app/widgets/bottom_sheet.dart';
import 'package:intl/intl.dart';

class NearByDealList extends StatefulWidget {
   NearByDealList({Key? key }) : super(key: key);

  @override
  State<NearByDealList> createState() => _NearByDealListState();
}

class _NearByDealListState extends State<NearByDealList> {
   final nearController = Get.put(UserController());
   TextEditingController end = TextEditingController();
   TextEditingController date = TextEditingController();
   final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {

    var size = Get.size;
    return Obx(
      () {
        return DraggableScrollableSheet(
          initialChildSize:
          Get.put(UserController()).sheetHeight.value==0.5? Get.put(UserController()).sheetHeight.value:
          Get.put(UserController()).sheetHeight.value,
          minChildSize:  Get.put(UserController()).sheetHeight.value==0.5? Get.put(UserController()).sheetHeight.value:
          Get.put(UserController()).sheetHeight.value,
          maxChildSize: Get.put(UserController()).sheetHeight.value==0.5? Get.put(UserController()).sheetHeight.value:
          Get.put(UserController()).sheetHeight.value,
          expand: true,

          builder: (_, controller) => Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02, ),
              child: Column(
                children: [

                  Obx(
                    () {
                      return
                        Get.put(UserController()).name.value.isEmpty?

                        SizedBox(height: Get.height*0.025,): SizedBox(height: Get.height*0.07,);
                    }
                  ),

                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: size.width * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          title: "Nearby Gyms",
                          color: AppColor.blackColor,
                          fontFamily: AppFont.semi,
                          size: AppSizes.size_16,
                        ),
                        Obx(
                          () {
                            return GestureDetector(
                              onTap: (){
                                setState(() {
                                  if(Get.put(UserController()).sheetHeight.value==0.5){
                                    Get.put(UserController()).sheetHeight.value=0.25;
                                  }
                                  else{
                                    Get.put(UserController()).sheetHeight.value=0.5;
                                  }

                                });
                              },
                              child: Container(
                                color: Colors.transparent,

                                  child:
                                  Get.put(UserController()).sheetHeight.value==0.5?
                                  Icon(Icons.keyboard_arrow_down_rounded,size: Get.height*0.05,
                                    color: AppColor.primaryColor,
                                  ):Icon(Icons.keyboard_arrow_up_rounded,size: Get.height*0.05,
                                  color: AppColor.primaryColor,
                                  )),
                            );
                          }
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
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
                    Get.put(UserController()).name.value.isEmpty?
                    Column(
                      children: [
                        SizedBox(height: Get.height*0.1,),
                        Center(
                          child: AppText(title: "Login account see near gyms!",
                            color: AppColor.primaryColor,
                            fontFamily: AppFont.semi,
                            size: AppSizes.size_16,
                          ),
                        ),
                      ],
                    )
                    :

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

                                        Get.put(UserController()).getVideoData(id:nearController.mapList[index].id.toString() );

                                        Get.to(UserGymDetail(data:nearController.mapList[index] ,));
                                      }

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
                                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                                      height: Get.height * 0.08,
                                                      width: Get.height * 0.08,
                                                      memCacheWidth: 180,
                                                      memCacheHeight: 180,
                                                      fit: BoxFit.cover,

                                                      errorWidget: (context, url, error) => ClipRRect(
                                                        borderRadius: BorderRadius.circular(10),
                                                        child: Image.asset(
                                                          "assets/img/gym.jpeg",
                                                          height: Get.height * 0.08,
                                                          width: Get.height * 0.08,
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
                                                              width: Get.width * 0.48,
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
                                                            Text("${nearController.mapList[index].fees.toString()}₣",
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              textAlign: TextAlign.start,

                                                              style: TextStyle(fontSize: AppSizes.size_12,

                                                                  color: AppColor.blackColor,
                                                                  height:Get.height*0.002,
                                                                  fontWeight: FontWeight.w700),),

                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: Get.height * 0.004,
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
                                                          height: Get.height * 0.004,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
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
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  color:  AppColor.primaryColor,
                                                                  borderRadius: BorderRadius.circular(10)),
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(horizontal: Get.width*0.027,vertical: Get.height*0.007),
                                                                child: AppText(
                                                                  title: "See Detail",
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
                                            // SizedBox(height: Get.height*0.012,),
                                            // GestureDetector(
                                            //   onTap: (){
                                            //     setState(() {
                                            //       end.clear();
                                            //       date.clear();
                                            //     });
                                            //
                                            //     Get.generalDialog(
                                            //         barrierDismissible: false,
                                            //         pageBuilder: (context, __, ___) => WillPopScope(
                                            //           onWillPop: () async {
                                            //             // Handle the back button press event
                                            //             return true; // Return false to prevent dialog from closing
                                            //           },
                                            //           child: AlertDialog(
                                            //
                                            //             content: SizedBox(
                                            //               height: Get.height*0.35,
                                            //               child: Column(
                                            //                 crossAxisAlignment: CrossAxisAlignment.start,
                                            //                 children: [
                                            //                   Center(
                                            //                     child: AppText(
                                            //                       title: "Book Appointment",
                                            //                       size: AppSizes.size_16,
                                            //                       fontWeight: FontWeight.w400,
                                            //                       fontFamily: AppFont.semi,
                                            //                       color: AppColor.boldBlackColor.withOpacity(0.8),
                                            //                     ),
                                            //                   ),
                                            //                   SizedBox(
                                            //                     height: Get.height * 0.02,
                                            //                   ),
                                            //                   textAuth(text: "Select Date",color: Colors.transparent),
                                            //                   SizedBox(
                                            //                     height: Get.height * 0.01,
                                            //                   ),
                                            //                   betField(
                                            //
                                            //                     hint: "Select Date",
                                            //                     textInputType: TextInputType.visiblePassword,
                                            //                     textInputAction: TextInputAction.done,
                                            //                     isRead: true,
                                            //                     cur: false,
                                            //                     focusNode: _focusNode,
                                            //                     onChange: (val){
                                            //                       setState(() {
                                            //
                                            //                       });
                                            //                     },
                                            //
                                            //                     onTap: () async{
                                            //                       DateTime? pickedDate = await showDatePicker(
                                            //                           context: context,
                                            //                           initialEntryMode: DatePickerEntryMode.calendarOnly,
                                            //
                                            //                           builder: (BuildContext? context,
                                            //                               Widget? child) {
                                            //                             return Center(
                                            //                                 child: Container(
                                            //                                   decoration: BoxDecoration(
                                            //                                       borderRadius:
                                            //                                       BorderRadius.circular(20)),
                                            //                                   width: 350.0,
                                            //                                   height: 500.0,
                                            //                                   child: Theme(
                                            //                                     data: ThemeData.light().copyWith(
                                            //                                       primaryColor:
                                            //                                       AppColor.blackColor,
                                            //                                       accentColor:
                                            //                                       AppColor.blackColor,
                                            //                                       colorScheme: ColorScheme.light(
                                            //                                         primary:
                                            //                                         AppColor.blackColor,),
                                            //                                       buttonTheme: ButtonThemeData(
                                            //                                           buttonColor:
                                            //                                           AppColor.primaryColor),
                                            //                                     ),
                                            //                                     child: child!,
                                            //                                   ),
                                            //                                 ));
                                            //                           },
                                            //                           initialDate: DateTime.now(),
                                            //                           firstDate: DateTime.now(),
                                            //                           lastDate: DateTime(2050));
                                            //
                                            //                       if (pickedDate != null) {
                                            //                         date.text =
                                            //                             DateFormat('yyyy-MM-dd')
                                            //                                 .format(pickedDate);
                                            //                       }
                                            //                     },
                                            //                     controller: date,
                                            //                     child:    IconButton(
                                            //                         onPressed: () {
                                            //
                                            //                         },
                                            //                         icon: Icon(
                                            //                             Icons.calendar_month,
                                            //                             size: Get.height * 0.022,
                                            //                             color: Colors.black)),
                                            //                   ),
                                            //                   SizedBox(
                                            //                     height: Get.height * 0.02,
                                            //                   ),
                                            //                   textAuth(text: "Select time",color: Colors.transparent),
                                            //                   SizedBox(
                                            //                     height: Get.height * 0.01,
                                            //                   ),
                                            //                   betField(
                                            //
                                            //                     hint: "Select time",
                                            //                     textInputType: TextInputType.visiblePassword,
                                            //                     textInputAction: TextInputAction.done,
                                            //                     isRead: true,
                                            //                     cur: false,
                                            //                     focusNode: _focusNode,
                                            //                     onChange: (val){
                                            //                       setState(() {
                                            //
                                            //                       });
                                            //                     },
                                            //
                                            //                     onTap: ()async{
                                            //
                                            //                       final TimeOfDay? pickedTime = await showTimePicker(
                                            //                         context: context,
                                            //                         initialTime: TimeOfDay.now(),
                                            //                         builder: (BuildContext context, Widget? child) {
                                            //                           return MediaQuery(
                                            //                             data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                            //                             child: child!,
                                            //                           );
                                            //                         },
                                            //                       );
                                            //
                                            //                       if (pickedTime != null) {
                                            //                         final String formattedTime =
                                            //                             '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                            //                             '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                            //                         setState(() {
                                            //                           end.text= '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                            //                               '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                            //                         });
                                            //                       }
                                            //                     },
                                            //                     controller: end,
                                            //                     child:    IconButton(
                                            //                         onPressed: () {
                                            //
                                            //                         },
                                            //                         icon: Icon(
                                            //                             Icons.access_time_rounded,
                                            //                             size: Get.height * 0.022,
                                            //                             color: Colors.black)),
                                            //                   ),
                                            //                   SizedBox(
                                            //                     height: Get.height * 0.04,
                                            //                   ),
                                            //                   Obx(
                                            //                           () {
                                            //                         return
                                            //                           Get.put(UserController()).bookAppoint.value?
                                            //                           Container(
                                            //                             width: Get.width,
                                            //                             child: Center(
                                            //                                 child: SpinKitThreeBounce(
                                            //                                     size: 25, color: AppColor.primaryColor1)
                                            //                             ),
                                            //                           ):
                                            //
                                            //                           Row(
                                            //                             children: [
                                            //                               Expanded(
                                            //                                 child: AppButton(
                                            //                                     buttonWidth: Get.width,
                                            //                                     buttonRadius: BorderRadius.circular(10),
                                            //                                     buttonName: "Close",
                                            //                                     fontWeight: FontWeight.w500,
                                            //                                     buttonHeight: Get.height*0.054,
                                            //                                     textSize: AppSizes.size_15,
                                            //                                     buttonColor: AppColor.primaryColor,
                                            //                                     textColor: AppColor.whiteColor,
                                            //                                     onTap: () {
                                            //                                       Get.back();
                                            //
                                            //
                                            //
                                            //                                     }),
                                            //                               ),
                                            //                               SizedBox(width: Get.width*0.03,),
                                            //                               Expanded(
                                            //                                 child: AppButton(
                                            //                                     buttonWidth: Get.width,
                                            //                                     buttonRadius: BorderRadius.circular(10),
                                            //                                     buttonName: "Book Now",
                                            //                                     fontWeight: FontWeight.w500,
                                            //                                     buttonHeight: Get.height*0.054,
                                            //                                     textSize: AppSizes.size_15,
                                            //                                     buttonColor: AppColor.primaryColor,
                                            //                                     textColor: AppColor.whiteColor,
                                            //                                     onTap: () {
                                            //                                       if(validateBook(context)){
                                            //                                         Get.put(UserController()).updateAppoint(true);
                                            //                                         ApiManger().bookAppointmnet(context: context,
                                            //                                             gymId: nearController.mapList[index].id.toString(),
                                            //                                             end: end.text,
                                            //                                             date: date.text
                                            //                                         );
                                            //                                         print(date.text);
                                            //                                         print(end.text);
                                            //                                       }
                                            //
                                            //
                                            //
                                            //
                                            //                                     }),
                                            //                               ),
                                            //                             ],
                                            //                           );
                                            //                       }
                                            //                   )
                                            //
                                            //                 ],
                                            //               ),
                                            //             ),
                                            //
                                            //           ),
                                            //         ));
                                            //   },
                                            //   child: Container(
                                            //     width: Get.height*0.15,
                                            //     height: Get.height*0.042,
                                            //     decoration: BoxDecoration(
                                            //         color:  AppColor.primaryColor,
                                            //         borderRadius: BorderRadius.circular(10)),
                                            //     child: Center(
                                            //       child: AppText(
                                            //         title: "Set Appointment",
                                            //         size: Get.height * 0.014,
                                            //         fontFamily: AppFont.medium,
                                            //         color: AppColor.whiteColor,
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),

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


