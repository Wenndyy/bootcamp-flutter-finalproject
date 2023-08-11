import 'package:finalproject/data/repository/auth_repository.dart';
import 'package:finalproject/data/services/dio_client.dart';
import 'package:finalproject/presentation/auth/regist_form/regist_form_controller.dart';
import 'package:get/get.dart';

import '../../../data/services/firebase_auth_service.dart';

class RegistFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DioClient>(() => DioClientImpl());
    Get.lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(Get.find<DioClient>()));
    Get.lazyPut<FirebaseAuthService>(() => FirebaseAuthServiceImpl());
    Get.lazyPut(
      () => RegistFormController(
        authRepository: Get.find<AuthRepository>(),
        firebaseAuthService: Get.find<FirebaseAuthService>(),
      ),
    );
  }
}
