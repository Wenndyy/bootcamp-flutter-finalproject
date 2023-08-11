import 'package:finalproject/core/styles.dart';
import 'package:finalproject/core/values/colors.dart';
import 'package:finalproject/core/values/images.dart';
import 'package:finalproject/presentation/auth/login/login_controller.dart';
import 'package:finalproject/presentation/widgets/signin_google_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Login',
                  style: Styles.blackTextStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SvgPicture.asset(
                ImagesAssets.imageIllustrationLoginSvg,
                height: 255,
              ),
              const SizedBox(
                height: 56,
              ),
              Text(
                'Selamat Datang',
                style: Styles.blackTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                ),
              ),
              Text(
                'Selamat Datang di Aplikasi Widya Edu Aplikasi Latihan dan Konsultasi Soal',
                style: Styles.greyTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 24,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    SocialLoginButton(
                      text: 'Masuk dengan Google',
                      iconAsset: ImagesAssets.iconGooglePng,
                      textColor: AppColors.black,
                      backgroundColor: AppColors.white,
                      outlineBorderColor: AppColors.mint,
                      onPressed: () async {
                        await Get.find<LoginController>().onGoogleSignIn();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SocialLoginButton(
                      text: 'Masuk dengan Apple ID',
                      iconAsset: ImagesAssets.iconApplePng,
                      textColor: AppColors.white,
                      backgroundColor: AppColors.black,
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
