import 'package:finalproject/data/model/register_user_request.dart';
import 'package:finalproject/presentation/auth/regist_form/regist_form_controller.dart';
import 'package:finalproject/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/core/styles.dart';
import 'package:finalproject/core/values/colors.dart';
import 'package:get/get.dart';

class RegistFormPage extends StatefulWidget {
  const RegistFormPage({super.key});

  @override
  State<RegistFormPage> createState() => _RegistFormPageState();
}

class _RegistFormPageState extends State<RegistFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameTextController = TextEditingController();
  final TextEditingController _schoolNameTextController =
      TextEditingController();
  String? selectedKelas;
  String jeniskelamin = '';

  bool isAllValid = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistFormController>(builder: (controller) {
      String email =
          controller.firebaseAuthService.getCurrentSignedInUserEmail() ?? '';

      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(86),
          child: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            backgroundColor: AppColors.background,
            title: Text(
              'Yuk isi data diri',
              style: Styles.blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            leading: IconButton(
              onPressed: () {},
              color: AppColors.black,
              icon: const Icon(Icons.arrow_back),
            ),
          ),
        ),
        body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  'Email',
                  style: Styles.blackTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                TextFormField(
                  controller: TextEditingController(
                    text: email,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  readOnly: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Nama Lengkap',
                  style: Styles.blackTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                TextFormField(
                  controller: _fullNameTextController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'contoh : Ihsan Adireja',
                    hintStyle: Styles.greyTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Jenis Kelamin',
                  style: Styles.blackTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(
                            () {
                              jeniskelamin = 'Laki-laki';
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: jeniskelamin == 'Laki-laki'
                                ? AppColors.primary
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 1,
                              color: jeniskelamin == 'Laki-laki'
                                  ? Colors.transparent
                                  : AppColors.greyD6,
                            ),
                          ),
                          height: 45,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Laki-laki',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: jeniskelamin == 'Laki-laki'
                                    ? AppColors.white
                                    : AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(
                            () {
                              jeniskelamin = 'Perempuan';
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: jeniskelamin == 'Perempuan'
                                ? AppColors.primary
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 1,
                              color: jeniskelamin == 'Perempuan'
                                  ? Colors.transparent
                                  : AppColors.greyD6,
                            ),
                          ),
                          height: 45,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Perempuan',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: jeniskelamin == 'Perempuan'
                                    ? AppColors.white
                                    : AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Kelas',
                  style: Styles.blackTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String?>(
                      value: selectedKelas,
                      isDense: true,
                      isExpanded: true,
                      items: ['10', '11', '12']
                          .map(
                            (element) => DropdownMenuItem<String?>(
                              value: element,
                              child: Text('Kelas $element'),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            selectedKelas = value;
                          }
                        });
                      },
                      hint: Text(
                        'pilih kelas',
                        style: Styles.greyTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Nama Sekolah',
                  style: Styles.blackTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                TextFormField(
                  controller: _schoolNameTextController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'nama sekolah',
                    hintStyle: Styles.greyTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() == true) {
                      if (selectedKelas != null) {
                        if (jeniskelamin != '') {
                          // Create a UserBody object with the form data
                          UserBody user = UserBody(
                            fullName: _fullNameTextController.text,
                            email: email,
                            schoolName: _schoolNameTextController.text,
                            schoolLevel: 'SMA',
                            schoolGrade: selectedKelas!,
                            gender: jeniskelamin,
                            photoUrl: '',
                          );

                          // Call the registerUser method from the controller
                          controller.registerUser(user: user);
                          Get.snackbar('Valid!!', '....',
                              snackPosition: SnackPosition.BOTTOM);
                          Get.offAllNamed(Routes.dashboard);
                        } else {
                          Get.snackbar(
                            'Invalid!!!',
                            'Jenis Kelamin Harus Diisi!',
                            backgroundColor: Colors.red,
                          );
                        }
                      } else {
                        Get.snackbar(
                          'Invalid!!!',
                          'Kelas Harus Diisi!',
                          backgroundColor: Colors.red,
                        );
                      }
                    } else {
                      Get.snackbar(
                        'Invalid!!',
                        'Selamat Datang',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.blue,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(46),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                  ),
                  child: const Text(
                    'DAFTAR',
                  ),
                ),
              ],
            )),
      );
    });
  }
}
