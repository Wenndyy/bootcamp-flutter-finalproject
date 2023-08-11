import 'package:finalproject/data/model/banner_response.dart';
import 'package:finalproject/data/repository/auth_repository.dart';
import 'package:finalproject/data/repository/banner_repository.dart';
import 'package:finalproject/data/repository/course_repository.dart';
import 'package:finalproject/data/services/firebase_auth_service.dart';
import 'package:get/get.dart';

import '../../../data/model/course_response.dart';
import '../../../data/model/user_response.dart';

class HomeController extends GetxController {
  final FirebaseAuthService firebaseAuthService;
  final CourseRepository courseRepository;
  final BannerRepository bannerRepository;
  final AuthRepository authRepository;

  HomeController(
    this.firebaseAuthService,
    this.courseRepository,
    this.bannerRepository,
    this.authRepository,
  );

  List<CourseData> courseList = [];
  List<BannerData> bannerList = [];
  final Rx<UserData?> currentUserData = Rx<UserData?>(null);
  bool isLoading = false;

  // Currently set to static
  String majorName = 'IPA';
  int maxHomeCourseCount = 5;

  @override
  void onInit() {
    super.onInit();
    getCourses();
    loadUserData();
    update();
  }

  Future<void> getCourses() async {
    // Set Loading
    isLoading = true;
    update();
    String? email = firebaseAuthService.getCurrentSignedInUserEmail();
    if (email != null) {
      List<CourseData> result = await courseRepository.getCourses(
        majorName: majorName,
        email: email,
      );
      isLoading = false;
      courseList = result;
      update();
    }
  }

  Future<void> loadUserData() async {
    isLoading = true; // Set loading state to true
    update();
    String? email = firebaseAuthService.getCurrentSignedInUserEmail();
    if (email != null) {
      try {
        UserData? userData = await authRepository.getUserByEmail(email: email);
        currentUserData.value = userData;
      } finally {
        isLoading = false; // Set loading state back to false
      }
      update();
    }
  }

  Future<void> getBanners() async {
    isLoading = true;
    update();
    String? email = firebaseAuthService.getCurrentSignedInUserEmail();
    if (email != null) {
      List<BannerData> result = await bannerRepository.getBanners(limit: 3);
      isLoading = false;
      bannerList = result;
      update();
    }
  }
}
