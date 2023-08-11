import 'package:finalproject/data/model/user_response.dart';
import 'package:finalproject/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'edit_profile/edit_profile_page.dart';
import 'profile_controller.dart';

class ProfilePage<C extends ProfileController> extends GetView<C> {
  static const routeName = '/profile';

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        UserData? userData = controller.currentUserData.value;
        String foto = controller.firebaseAuthService.getPhoto() ?? '';
        if (userData == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Akun Saya'),
              backgroundColor: const Color(0xff3A7FD5),
              centerTitle: true,
              actions: [
                TextButton(
                  onPressed: () => redirectToEditPage(
                    EditProfileArgs(
                      kelas: controller.currentUserData.value?.kelas ?? '',
                      sekolah:
                          controller.currentUserData.value?.userAsalSekolah ??
                              '',
                      name: controller.currentUserData.value?.userName ?? '',
                      email: controller.currentUserData.value?.userEmail ?? '',
                      jenisKelamin:
                          controller.currentUserData.value?.userGender ?? '',
                      photoUrl:
                          controller.currentUserData.value?.userFoto ?? '',
                    ),
                  ),
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: Size(Get.width, 60),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (controller.isLoading == true)
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: const CircularProgressIndicator(),
                        ),
                      )
                    else
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${userData.userName}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                '${userData.userAsalSekolah}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(foto),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
            ),
            body: ListView(
              children: [
                if (controller.isLoading == true)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 0),
                          blurRadius: 7,
                          spreadRadius: 0,
                          color: Colors.black.withOpacity(0.25),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16,
                            bottom: 8,
                          ),
                          child: Text(
                            'Identitas Diri',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        buildContentProfile(
                          context: context,
                          title: 'Nama Lengkap',
                          value: userData.userName ?? '',
                        ),
                        buildContentProfile(
                          context: context,
                          title: 'Email',
                          value: userData.userEmail ?? '',
                        ),
                        buildContentProfile(
                          context: context,
                          title: 'Jenis Kelamin',
                          value: userData.userGender ?? '',
                        ),
                        buildContentProfile(
                          context: context,
                          title: 'Kelas',
                          value: userData.kelas ?? '',
                        ),
                        buildContentProfile(
                          context: context,
                          title: 'Sekolah',
                          value: userData.userAsalSekolah ?? '',
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                buildLogoutSection(
                  context: context,
                  onTap: () => onLogoutPressed(),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  void redirectToEditPage(EditProfileArgs args) => Get.toNamed(
        EditProfilePage.routeName,
        arguments: args,
      );

  Widget buildContentProfile({
    required BuildContext context,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 16,
        right: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLogoutSection({
    required BuildContext context,
    required GestureTapCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 6,
                spreadRadius: 0,
                offset: const Offset(0, 0))
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.exit_to_app,
                color: Color(0xffEB5757),
              ),
              SizedBox(width: 6),
              Text(
                'Keluar',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xffEB5757),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onLogoutPressed() {
    Get.dialog(
      Dialog(
        child: Wrap(
          children: [
            Column(
              children: [
                const SizedBox(height: 16),
                const Text('Logout?'),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const SizedBox(width: 32),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Tidak'),
                      ),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            // Get.back();
                            controller.signOut();
                          },
                          child: const Text('Ya')),
                    ),
                    const SizedBox(width: 32),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
