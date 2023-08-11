import 'package:finalproject/core/styles.dart';
import 'package:finalproject/core/values/colors.dart';
import 'package:finalproject/presentation/dashboard/dashboard_controller.dart';
import 'package:finalproject/presentation/dashboard/discussion/discussion_page.dart';
import 'package:finalproject/presentation/dashboard/home/home_page.dart';
import 'package:finalproject/presentation/dashboard/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int selectedIndex = controller.selectedNavIndexObs.value;
      return SafeArea(
        child: Scaffold(
          //extendBody: true,
          backgroundColor: AppColors.background,
          // body: _bodyList()[selectedIndex],
          body: IndexedStack(
            index: selectedIndex,
            children: const [
              HomePage(),
              DiscussionPage(),
              ProfilePage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppColors.white,
            currentIndex: selectedIndex,
            onTap: (index) {
              controller.navigateTo(index);
            },
            selectedLabelStyle: Styles.blackTextStyle.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            unselectedLabelStyle: Styles.greyTextStyle.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            selectedItemColor: Colors.black,
            items: const [
              BottomNavigationBarItem(
                activeIcon: Image(
                  image: AssetImage('assets/icon/home-icon.png'),
                  width: 24,
                ),
                icon: Image(
                  image: AssetImage('assets/icon/home-icon-grey.png'),
                  width: 24,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                activeIcon: Image(
                  image: AssetImage('assets/icon/diskusi-icon.png'),
                  width: 24,
                ),
                icon: Image(
                  image: AssetImage('assets/icon/diskusi-icon-grey.png'),
                  width: 24,
                ),
                label: 'Diskusi Soal',
              ),
              BottomNavigationBarItem(
                activeIcon: Image(
                  image: AssetImage('assets/icon/profile-icon-active.png'),
                  width: 24,
                ),
                icon: Image(
                  image: AssetImage('assets/icon/profile-icon-grey.png'),
                  width: 24,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      );
    });
  }
}
