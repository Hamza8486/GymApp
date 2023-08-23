import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/services/api_manager.dart';
import 'package:gym_app/app/user/home/controller/user_controller.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/util/toast.dart';
import 'package:gym_app/app/widgets/app_button.dart';
import 'package:gym_app/app/widgets/app_text.dart';
import 'package:intl/intl.dart';



class ReviewSheet extends StatefulWidget {
  ReviewSheet({Key? key,this.data}) : super(key: key);
  var data;

  @override
  State<ReviewSheet> createState() => _ReviewSheetState();
}

class _ReviewSheetState extends State<ReviewSheet> {
  var homeController = Get.put(UserController());

  var rate = 0.0 ;

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;

    var size = Get.size;
    return DraggableScrollableSheet(
      initialChildSize:0.27,
      minChildSize:0.27,
      maxChildSize:0.27,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.01, horizontal: size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.02,
                      ),

                      Center(
                        child: AppText(
                            title: "Give Rating",
                            color: AppColor.blackColor,
                            fontFamily: AppFont.semi,
                            size: AppSizes.size_17),
                      ),

                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
                          child: RatingBar.builder(
                            initialRating: rate,
                            itemSize: 35,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                            EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                rate = rating;
                                print(rate);
                              });



                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),


                    ],
                  ),
                ),
              ),
              Obx(
                      () {
                    return
                      Get.put(UserController()).isRating.value?
                      Center(
                          child: SpinKitThreeBounce(
                              size: 25, color: AppColor.primaryColor1)
                      ):


                      AppButton(buttonName: "Submit Rating", buttonColor: AppColor.primaryColor, textColor: AppColor.whiteColor,
                        fontFamily: AppFont.semi,

                        onTap:  ()async{
                        if(validateRating(context)){
                          homeController.updateIsRating(true);
                          ApiManger().ratingData(context: context,id: widget.data.id.toString(),rating:rate.toStringAsFixed(0) );
                        }
                       ;



                        },
                        buttonRadius: BorderRadius.circular(10),
                        buttonWidth: Get.width,
                      );
                  }
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validateRating(BuildContext context) {
    if (rate == 0.0) {
      flutterToast(msg: "Please give rating to gym");
      return false;
    }






    return true;
  }
}


