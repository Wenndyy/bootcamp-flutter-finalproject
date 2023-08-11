import 'package:finalproject/data/repository/chat_repository.dart';
import 'package:finalproject/presentation/dashboard/discussion/discussion_controller.dart';
import 'package:get/get.dart';

class DiscussionBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ChatRepository>(ChatRepositoryImpl());
    Get.put(
      DiscussionController(
        chatRepository: Get.find<ChatRepository>(),
      ),
    );
  }
}
