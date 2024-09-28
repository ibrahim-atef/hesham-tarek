import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hesham_tarek/core/utils/api_service.dart';
import 'package:hesham_tarek/features/home/data/repos/course_repo_implementation.dart';
import 'package:hesham_tarek/features/login/data/models/login_model.dart';
import 'package:hesham_tarek/features/login/data/repos/login_repo_implementation.dart';
import 'package:hesham_tarek/features/my_courses/data/repo/course_detail_repo_implementation.dart';
import 'package:hesham_tarek/features/register/data/repo/create_user_repo_implementation.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<LoginRepoImplementation>(
      LoginRepoImplementation(getIt.get<ApiService>()));
  getIt.registerSingleton<CourseRepoImplementation>(
      CourseRepoImplementation(getIt.get<ApiService>()));
  getIt.registerSingleton<CourseDetailRepoImplementation>(
      CourseDetailRepoImplementation(getIt.get<ApiService>()));
  getIt.registerSingleton<CreateUserRepoImplementation>(
      CreateUserRepoImplementation(getIt.get<ApiService>()));
  getIt.registerSingleton<UserData>(UserData());
}

class UserData {
  static final UserData _instance = UserData._internal();

  factory UserData() {
    return _instance;
  }

  UserData._internal();
  LoginModel? user;

  void updateUser(LoginModel newUser) {
    user = newUser;
  }

  void logOutUser() {
    user = null;
  }
}
