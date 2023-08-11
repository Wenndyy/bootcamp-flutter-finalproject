class Routes {
  static const splash = '/';
  static const dashboard = '/dashboard';
  static const login = '/login';
  static const registerForm = '/register_form';

  static const editForm = '/profile/edit';

  static const courseList = '$dashboard/course';
  static const exerciseList = '$courseList/exercises';

  static const exerciseQuestionsForm = '$exerciseList/questions';
  static const exerciseResult = '$exerciseList/result';
}
