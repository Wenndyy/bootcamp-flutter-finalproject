import 'package:finalproject/presentation/exercise/result/exercise_result_controller.dart';
import 'package:get/get.dart';


class ExerciseResultBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExerciseResultController());
  }
}
