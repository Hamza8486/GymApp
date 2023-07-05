import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/auth/login.dart';
import 'package:gym_app/app/gym/home/home.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/user_dashboard.dart';
import 'package:gym_app/app/user/home/user_home.dart';
import 'package:gym_app/app/util/theme.dart';
import 'package:gym_app/app/widgets/helper_function.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  String id = "";
  String userTypeS = "";


  @override
  void initState() {
    super.initState();
    HelperFunctions.getFromPreference("id").then((value) {
      setState(() {
        id = value;
      });

      log(id);
    });
    HelperFunctions.getFromPreference("userType").then((value) {
      setState(() {
        userTypeS = value;
      });

      log(id);
     moveToNext();
    });

  }

  void moveToNext() {
    Timer(const Duration(seconds: 3), () {
      if (userTypeS == "User") {
        Get.offAll(()=>UserHome(),
        transition: Transition.cupertinoDialog
        );

      }
     else if (userTypeS == "Gym") {
        Get.offAll(()=>HomeView(),
            transition: Transition.cupertinoDialog
        );

      }

      else {
        Get.offAll(()=>UserHome(),
        transition: Transition.cupertinoDialog
        );

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.height*0.43,),

              Center(
                child: Image.asset("assets/icons/logo.png",
                color: Colors.white,
                  height: Get.height*0.13,
                ),
              )

            ],
          ),
        ));
  }
}
