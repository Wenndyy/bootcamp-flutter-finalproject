import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/values/colors.dart';
import 'exercise_result_controller.dart';

class ExerciseResultPage extends GetView<ExerciseResultController> {
  const ExerciseResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.close_outlined,
                        color: AppColors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Tutup',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Text(
                'Selamat',
                style: GoogleFonts.poppins(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Kamu telah menyelesaikan Kuiz ini',
                style: GoogleFonts.poppins(
                  color: AppColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36),
              Image.asset(
                'assets/images/final-quiz.png',
                height: 180,
              ),
              const SizedBox(height: 25),
              const Text(
                'Nilai Kamu: ',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                controller.resultScore,
                style: GoogleFonts.poppins(
                  color: AppColors.white,
                  fontSize: 96,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
