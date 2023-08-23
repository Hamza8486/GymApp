import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/user/bottom_tabs/map_view/view/nearby_deals.dart';
import 'package:gym_app/app/user/bottom_tabs/user_dashboard/user_dashboard.dart';
import 'package:gym_app/app/user/bottom_tabs/userprofile/view/my_profile.dart';
import 'package:gym_app/app/user/home/controller/user_controller.dart';
import 'package:gym_app/app/util/theme.dart';



class UserHome extends StatefulWidget {
  int currentIndex;

  UserHome({Key? key, this.currentIndex = 0}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final homeController = Get.put(UserController());







  final List _screens = [
    UserDashboard(),
    NearbyDealsView(),
    UserProfile(),

  ];

  void _selectedPage(int index) {
    setState(() {
      widget.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return WillPopScope(
      onWillPop: () async{
        if(widget.currentIndex==0){
          return true;
        }
        setState(() {
          widget.currentIndex=0;
        });
        return false;

      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          selectedLabelStyle:
          TextStyle(fontFamily: AppFont.medium, fontSize: AppSizes.size_12),
          unselectedLabelStyle: TextStyle(
              color: AppColor.blackColor,
              fontFamily: AppFont.medium,
              fontSize: AppSizes.size_12),
          selectedItemColor: AppColor.primaryColor,
          unselectedItemColor: AppColor.blackColor,
          onTap: _selectedPage,
          currentIndex: widget.currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                    color: widget.currentIndex == 0
                        ? AppColor.primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 7, top: 7, bottom: 7, right: 7),
                  child: ImageIcon(
                    AssetImage(
                      "assets/img/home.png",
                    ),
                    size: Get.height * 0.025,
                    color: widget.currentIndex == 0
                        ? AppColor.whiteColor
                        : Colors.black,
                  ),
                ),
              ),
              label: "Home",
              tooltip: "Home",
            ),
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                    color: widget.currentIndex == 1
                        ? AppColor.primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 7, top: 7, bottom: 7, right: 7),
                  child: SvgPicture.asset(
                    "assets/icons/pin.svg",
                    height: Get.height * 0.025,
                    color: widget.currentIndex == 1
                        ? AppColor.whiteColor
                        : Colors.black,
                  ),
                ),
              ),
              label: "Home",
              tooltip: "Home",
            ),

            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                    color: widget.currentIndex == 2
                        ? AppColor.primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6)),
                child: Padding(
                  padding:  EdgeInsets.only(
                      left: 7, top: 7, bottom: 7, right: 7),
                  child: ImageIcon(
                    AssetImage(
                      "assets/img/profile.png",
                    ),
                    size: Get.height * 0.025,
                    color: widget.currentIndex == 2
                        ? AppColor.whiteColor
                        : Colors.black,
                  ),
                ),
              ),
              label: "",
            ),
          ],
        ),
        body: _screens[widget.currentIndex],

      ),
    );
  }
}
