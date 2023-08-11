import 'package:finalproject/data/model/user_response.dart';
import 'package:finalproject/data/repository/auth_repository.dart';
import 'package:finalproject/data/services/firebase_auth_service.dart';
import 'package:finalproject/routes/routes.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  FirebaseAuthService firebaseAuthService;
  AuthRepository authRepository;

  ProfileController({
    required this.authRepository,
    required this.firebaseAuthService,
  });

  bool isLoading = false;

  final Rx<UserData?> currentUserData = Rx<UserData?>(null);

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    update();
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

  Future<void> signOut() async {
    await firebaseAuthService.signOut();
    Get.offAllNamed(Routes.login);
  }
}
