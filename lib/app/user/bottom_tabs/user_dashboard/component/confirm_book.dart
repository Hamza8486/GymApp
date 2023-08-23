//
// // ignore_for_file: prefer_const_constructors
//
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:gym_app/app/auth/controller.dart';
// import 'package:gym_app/app/auth/login.dart';
// import 'package:gym_app/app/gym/bottom_tabs/dashboard/controller/controller.dart';
// import 'package:gym_app/app/services/api_manager.dart';
// import 'package:gym_app/app/user/bottom_tabs/map_view/controller/map_controller.dart';
// import 'package:gym_app/app/user/home/controller/user_controller.dart';
// import 'package:gym_app/app/util/theme.dart';
// import 'package:gym_app/app/util/toast.dart';
// import 'package:gym_app/app/widgets/app_button.dart';
// import 'package:gym_app/app/widgets/app_text.dart';
// import 'package:gym_app/app/widgets/helper_function.dart';
//
//
//
// class ConfirmOrder extends StatefulWidget {
//   ConfirmOrder({Key? key,this.amount,this.gymId,this.name}) : super(key: key);
//   var gymId;
//   var amount;
//   var name;
//
//   @override
//   State<ConfirmOrder> createState() => _ConfirmOrderState();
// }
//
// class _ConfirmOrderState extends State<ConfirmOrder> {
//   @override
//   Widget build(BuildContext context) {
//
//     var size = Get.size;
//     return DraggableScrollableSheet(
//       initialChildSize:0.22,
//       minChildSize:0.22,
//       maxChildSize:0.22,
//       builder: (_, controller) => Container(
//         decoration: BoxDecoration(
//           color: AppColor.whiteColor,
//           borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(30), topRight: Radius.circular(30)),
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//               vertical: size.height * 0.02, horizontal: size.width * 0.05),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: Get.height * 0.01,
//               ),
//               Center(
//                 child: AppText(
//                   title: "Confirm Booking ",
//                   color: AppColor.blackColor,
//                   fontFamily: AppFont.semi,
//                   size: AppSizes.size_17,
//                 ),
//               ),
//
//               SizedBox(
//                 height: Get.height * 0.03,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   AppText(
//                     title: "Total fees ",
//                     color: AppColor.blackColor,
//                     fontFamily: AppFont.medium,
//                     size: AppSizes.size_15,
//                   ),
//                   AppText(
//                     title: "\$ ${widget.amount.toString()}",
//                     color: AppColor.greyColors,
//                     fontFamily: AppFont.medium,
//                     size: AppSizes.size_15,
//                   ),
//
//
//                 ],
//               ),
//               SizedBox(
//                 height: Get.height * 0.02,
//               ),
//
//               Obx(
//                 () {
//                   return
//                     Get.put(UserController()).payLoader.value?
//                     Center(
//                         child: SpinKitThreeBounce(
//                             size: 25, color: AppColor.primaryColor1)
//                     ):
//
//                     Get.put(UserController()).name.value.isEmpty?
//
//                     AppButton(buttonName: "Pay Now", buttonColor: AppColor.primaryColor, textColor: AppColor.whiteColor,
//                     fontFamily: AppFont.semi,
//
//                     onTap:  ()async{
//                       // Get.put(MapController()).updateGymName(widget.name.toString());
//                       // Get.put(MapController()).updateGymId(widget.gymId.toString());
//                       // Get.put(MapController()).updateGymAmount(widget.amount.toString());
//                     flutterToast(msg: "Please Login Your Account");
//                     await  Get.delete<UserController>();
//                     await  Get.delete<AuthController>();
//                     await  Get.delete<GymController>();
//
//
//                     await  HelperFunctions().clearPrefs();
//                     Get.offAll(LoginView());
//                     print( widget.name.toString());
//                     print(widget.gymId.toString());
//                     print( Get.put(MapController()).gymAmount.value);
//
//
//
//                     },
//                     buttonRadius: BorderRadius.circular(10),
//                     buttonWidth: Get.width,
//                   ):AppButton(buttonName: "Pay Now", buttonColor: AppColor.primaryColor, textColor: AppColor.whiteColor,
//                       fontFamily: AppFont.semi,
//
//                       onTap:  (){
//                         Get.put(UserController()).updatePayLoader(true);
//                         ApiManger().payResponse(gym: widget.gymId.toString(),amount: widget.amount.toString());
//
//
//
//                       },
//                       buttonRadius: BorderRadius.circular(10),
//                       buttonWidth: Get.width,
//                     );
//                 }
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
// }
//
//
