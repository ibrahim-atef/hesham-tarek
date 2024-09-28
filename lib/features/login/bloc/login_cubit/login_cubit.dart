import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hesham_tarek/core/utils/functions.dart';
import 'package:hesham_tarek/core/utils/service_locator.dart';
import 'package:hesham_tarek/features/home/bloc/courseList/course_list_cubit.dart';
import 'package:hesham_tarek/features/login/data/models/login_model.dart';
import 'package:hesham_tarek/features/login/data/repos/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepo;
  final UserData userData = GetIt.instance<UserData>();
  LoginCubit(this.loginRepo) : super(LoginInitial());
  Future<void> loginUser(
      String username, password, imei, BuildContext context) async {
    emit(LoginLoading());
    var result = await loginRepo.fetchUser(username, password, imei);
    result.fold(
      (failure) {
        emit(LoginFailure(failure.errMessage));
      },
      (user) async {
        if (!context.mounted) return; // Check if context is still valid
        userData.updateUser(user);
        context.read<CourseListCubit>().getCourseList(user.id.toString());
        _saveUserCredentials(username, password);
        emit(LoginSuccess(user));
      },
    );
  }

  Future<void> _saveUserCredentials(String username, String password) async {
    await loginRepo.saveUserCredentials(username, password);
  }

  Future<void> logoutUser() async {
    await loginRepo.logout();
    userData.logOutUser;
    emit(LoginInitial());
  }

  Future<void> checkLoginStatus(BuildContext context) async {
    final credentials = await loginRepo.getUserCredentials();
    if (credentials != null) {
      await loginUser(credentials['username']!, credentials['password']!,
          await Functions.getDeviceIdentifiers(), context);
    } else {
      emit(LoginInitial());
    }
  }
}
