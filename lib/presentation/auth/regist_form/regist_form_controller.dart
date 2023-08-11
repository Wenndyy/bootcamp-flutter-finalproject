import 'dart:async';

import 'package:finalproject/data/model/user_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/register_user_request.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../data/services/firebase_auth_service.dart';

class RegistFormController extends GetxController {
  final FirebaseAuthService firebaseAuthService;
  final AuthRepository authRepository;

  RegistFormController({
    required this.authRepository,
    required this.firebaseAuthService,
  });

  late TextEditingController emailTextController;

  @override
  void onInit() {
    super.onInit();

    String email = firebaseAuthService.getCurrentSignedInUserEmail() ?? '';
    emailTextController = TextEditingController(text: email);
  }

  Future<void> registerUser({required UserBody user}) async {
    // Display a loading dialog while registering the user
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    try {
      // Check if the user already exists by their email address
      UserData? existingUser =
          await authRepository.getUserByEmail(email: user.email);

      if (existingUser != null) {
        // User already exists, show error message
        Get.snackbar(
            'Registration Failed', 'User with this email already exists.',
            snackPosition: SnackPosition.BOTTOM);
        Get.back(); // Close the loading dialog
        return;
      }

      // Call AuthRepository.registerUser() to register the user
      bool registrationSuccess =
          await authRepository.registerUser(userBody: user);

      if (registrationSuccess) {
        // User registration success, show success message
        Get.snackbar('Registration Success', 'User registered successfully.',
            snackPosition: SnackPosition.BOTTOM);

        // You can redirect the user to another page after successful registration,
        // for example, redirect to the login page.
        // Get.toNamed(Routes.login);
      } else {
        // Registration failed, show error message
        Get.snackbar('Registration Failed', 'Failed to register user.',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      // Handle registration error, show error message
      Get.snackbar('Error', 'An error occurred during registration.',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      // Close the loading dialog
      Get.back();
    }
  }
}
