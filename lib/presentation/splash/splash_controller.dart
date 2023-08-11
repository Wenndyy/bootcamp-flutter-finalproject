import 'package:finalproject/data/model/user_response.dart';
import 'package:finalproject/data/repository/auth_repository.dart';
import 'package:finalproject/data/services/firebase_auth_service.dart';
import 'package:finalproject/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

class SplashController extends GetxController {
  final FirebaseAuthService firebaseAuthService;
  final AuthRepository authRepository;

  SplashController({
    required this.authRepository,
    required this.firebaseAuthService,
  });

  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(milliseconds: 2000)).then((value) async {
      await isUserSignedInWithGoogle();
    });
  }

  Future<void> isUserSignedInWithGoogle() async {
    if (FirebaseAuth.instance.currentUser != null) {
      // User Is Signed In with google
      // Check is user registered?
      await isUserRegistered();
    } else {
      // User is Not Signed In
      // Navigate to Login Page
      Get.offAllNamed(Routes.login);
    }
  }

  Future<void> isUserRegistered() async {
    String? email = firebaseAuthService.getCurrentSignedInUserEmail();
    // email != null artinya user sudah sign-in
    if (email != null) {
      UserData? userData = await authRepository.getUserByEmail(email: email);
      if (userData != null) {
        // User is Registered
        // Navigate to Dashboard Page
        Get.offAllNamed(Routes.dashboard);
      } else {
        // User is Signed In & Is not Registered
        // Navigate to Register Form Page
        Get.offAllNamed(Routes.registerForm);
      }
    } else {
      // User is Not Signed In
      // Navigate to Login Page
      Get.offAllNamed(Routes.login);
    }
  }
}
