import 'package:finalproject/presentation/auth/login/login_binding.dart';
import 'package:finalproject/presentation/auth/login/login_page.dart';
import 'package:finalproject/presentation/auth/regist_form/regist_form_binding.dart';
import 'package:finalproject/presentation/auth/regist_form/regist_form_page.dart';
import 'package:finalproject/presentation/course/course_list_binding.dart';
import 'package:finalproject/presentation/course/course_list_page.dart';
import 'package:finalproject/presentation/dashboard/dashboard_binding.dart';
import 'package:finalproject/presentation/dashboard/dashboard_page.dart';
import 'package:finalproject/presentation/dashboard/discussion/discussion_binding.dart';

import 'package:finalproject/presentation/dashboard/profile/edit_profile/edit_profile_binding.dart';
import 'package:finalproject/presentation/dashboard/profile/edit_profile/edit_profile_page.dart';
import 'package:finalproject/presentation/dashboard/profile/profile_binding.dart';
import 'package:finalproject/presentation/exercise/list/exercise_list_binding.dart';
import 'package:finalproject/presentation/exercise/list/exercise_list_page.dart';
import 'package:finalproject/presentation/exercise/questions_form/exercise_questions_form_binding.dart';
import 'package:finalproject/presentation/exercise/questions_form/exercise_questions_form_page.dart';
import 'package:finalproject/presentation/exercise/result/exercise_result_binding.dart';
import 'package:finalproject/presentation/exercise/result/exercise_result_page.dart';
import 'package:finalproject/presentation/splash/splash_binding.dart';
import 'package:finalproject/presentation/splash/splash_page.dart';
import 'package:get/get.dart';

import 'routes.dart';

class Pages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.registerForm,
      page: () => const RegistFormPage(),
      binding: RegistFormBinding(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardPage(),
      bindings: [
        DashboardBinding(),
        ProfileBinding(),
        DiscussionBinding(),
        //HomeBinding(),
      ],
    ),
    GetPage(
      name: Routes.registerForm,
      page: () => const RegistFormPage(),
      binding: RegistFormBinding(),
    ),
    GetPage(
      name: Routes.courseList,
      page: () => const CourseListPage(),
      binding: CourseListBinding(),
    ),
    GetPage(
      name: Routes.exerciseList,
      page: () => const ExerciseListPage(),
      binding: ExerciseListBinding(),
      arguments: ExerciseListPageArgs,
    ),
    GetPage(
      name: Routes.exerciseQuestionsForm,
      page: () => const ExerciseQuestionsFormPage(),
      binding: ExerciseQuestionsFormBinding(),
      arguments: String,
    ),
    GetPage(
      name: Routes.exerciseResult,
      page: () => const ExerciseResultPage(),
      binding: ExerciseResultBinding(),
      arguments: String,
    ),
    GetPage(
      name: EditProfilePage.routeName,
      page: () => const EditProfilePage(),
      binding: EditProfileBinding(),
      arguments: EditProfileArgs,
    ),
  ];
}
