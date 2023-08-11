import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

/* import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class DashboardController extends GetxController {
  final selectedNavIndexObs = 0.obs;
  final PersistentTabController persistentTabController =
      PersistentTabController(initialIndex: 0);

  void navigateTo(int index) {
    selectedNavIndexObs.value = index;
    persistentTabController
        .jumpToTab(index); // Gunakan jumpToTab untuk berpindah tab.
  }

  bool isOnline = true;

  @override
  void onInit() {
    super.onInit();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print('result: ${result}');
      isOnline = !(result == ConnectivityResult.bluetooth ||
          result == ConnectivityResult.none);
      update();
    });
  }
}
 */

class DashboardController extends GetxController {
  final selectedNavIndexObs = 0.obs;
  // int selectedNavIndex = 0;

  void navigateTo(int index) {
    // Obs
    selectedNavIndexObs.value = index;

    // // Set-update
    // selectedNavIndex = index;
    // update();
  }

  bool isOnline = true;

  @override
  void onInit() {
    super.onInit();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print('result: ${result}');
      isOnline = !(result == ConnectivityResult.bluetooth ||
          result == ConnectivityResult.none);
      update();
    });
  }
}
