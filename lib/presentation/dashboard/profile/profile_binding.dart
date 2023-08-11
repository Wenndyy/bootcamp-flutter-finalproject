import 'package:finalproject/data/repository/auth_repository.dart';
import 'package:finalproject/data/services/dio_client.dart';
import 'package:finalproject/data/services/firebase_auth_service.dart';
import 'package:finalproject/presentation/dashboard/profile/profile_controller.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirebaseAuthService>(() => FirebaseAuthServiceImpl());
    Get.lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(Get.find<DioClient>()));
    Get.lazyPut<ProfileController>(
      () => ProfileController(
        firebaseAuthService: Get.find<FirebaseAuthService>(),
        authRepository: Get.find<AuthRepository>(),
      ),
    );
  }
}
