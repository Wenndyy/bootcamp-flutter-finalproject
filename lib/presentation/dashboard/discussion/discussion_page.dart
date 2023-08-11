import 'package:finalproject/core/styles.dart';
import 'package:finalproject/core/values/colors.dart';
import 'package:finalproject/presentation/dashboard/discussion/discussion_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DiscussionPage<C extends DiscussionController> extends GetView<C> {
  static const routeName = '/discussion';

  const DiscussionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiscussionController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Diskusi Soal',
              style: Styles.whiteTextStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            backgroundColor: AppColors.primary,
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    bool isSender = controller.messages[index].isMe;
                    return Column(
                      crossAxisAlignment: isSender
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(controller.messages[index].name),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                              color: isSender
                                  ? AppColors.primary
                                  : Colors.blue.withOpacity(0.2),
                              borderRadius: BorderRadius.only(
                                bottomLeft: const Radius.circular(10),
                                topLeft: isSender
                                    ? const Radius.circular(10)
                                    : Radius.zero,
                                topRight: const Radius.circular(10),
                                bottomRight: isSender
                                    ? Radius.zero
                                    : const Radius.circular(10),
                              )),
                          child: Text(
                            controller.messages[index].message,
                            style: isSender
                                ? Styles.whiteTextStyle.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                  )
                                : Styles.blackTextStyle.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                  ),
                          ),
                        ),
                        Text(
                          '${controller.messages[index].time.difference(DateTime.now()).inMinutes.abs()}m',
                          style: Styles.greyTextStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 11,
                  horizontal: 15,
                ),
                child: Container(
                  color: AppColors.white,
                  child: Row(
                    children: [
                      IconButton(
                        color: const Color(0xfff6f6f6),
                        onPressed: () {
                          controller.openGallery();
                        },
                        icon: const Icon(
                          Icons.add,
                          color: AppColors.primary,
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 32,
                          child: TextFormField(
                            controller: controller.chatTextController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xfff6f6f6),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              hintText: 'Ketuk untuk menulis....',
                              suffixIcon: InkWell(
                                onTap: () {
                                  controller.openCamera();
                                },
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: AppColors.primary,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 0,
                                  style: BorderStyle.none,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 0,
                                  style: BorderStyle.none,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        color: const Color(0xfff6f6f6),
                        onPressed: () {
                          String chat = controller.chatTextController.text;
                          controller.createMessage(
                            isMe: false,
                            message: chat,
                          );
                          controller.chatTextController.clear();
                        },
                        icon: const Icon(
                          Icons.send,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
    /* return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: buildBody(context),
          ),
          _buildBottomChatOperation(context),
        ],
      ),
    ); */
  }

  /*  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Diskusi Soal'),
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(10),
        ),
      ),
    );
  }
 */
  /* Widget buildBody(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingMessages) {
        return buildLoading(context);
      }

      return _buildChatListView(context);
    });
  }

  Widget buildLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );
  } */

  /*  Widget _buildChatListView(BuildContext context) {
    return ListView.builder(
      itemCount: controller.messages.length,
      itemBuilder: (context, index) {
        final chat = controller.messages[index];
        return ChatItemWidget(chat: chat);
      },
      padding: const EdgeInsets.symmetric(vertical: 16),
      reverse: true,
    );
  }
 */
/*   Widget _buildBottomChatOperation(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -1),
            blurRadius: 10,
            spreadRadius: 0,
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding, top: bottomPadding),
        child: InputChatWidget(
          onTapAdd: () => onTapAdd(context),
          onTapCamera: () => onTapCamera(context),
          onTapSend: () => onSend(context),
        ),
      ),
    );
  }

  void onTapCamera(BuildContext context) {
    controller.openCamera();
  }

  void onSend(BuildContext context) {
    final fileName = controller.selectedFile?.name;
    debugPrint(fileName);
  }

  void onTapAdd(BuildContext context) {
    controller.openGallery();
  } */
}
