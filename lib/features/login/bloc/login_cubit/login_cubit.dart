import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hesham_tarek/core/utils/functions.dart';
import 'package:hesham_tarek/core/utils/service_locator.dart';
import 'package:hesham_tarek/features/home/bloc/courseList/course_list_cubit.dart';
import 'package:hesham_tarek/features/login/data/models/imei.dart';
import 'package:hesham_tarek/features/login/data/models/login_model.dart';
import 'package:hesham_tarek/features/login/data/repos/imei_repo.dart';
import 'package:hesham_tarek/features/login/data/repos/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepo;
  final ImeiRepo imeiRepo;
  final UserData userData = GetIt.instance<UserData>();
  LoginCubit(this.loginRepo, this.imeiRepo) : super(LoginInitial());

  Future<void> loginUser(
      String username, password, imei, BuildContext context) async {
    emit(LoginLoading());
    var result = await loginRepo.fetchUser(username, password, imei);
    result.fold(
      (failure) {
        emit(LoginFailure(failure.errMessage));
      },
      (user) async {
        if (user.imei != null) {
          if (user.imei == await Functions.getDeviceIdentifiers()) {
            userData.updateUser(user);
            context.read<CourseListCubit>().getCourseList(user.id.toString());
            _saveUserCredentials(username, password);
            emit(LoginSuccess(user));
          } else {
            emit(const LoginFailure("Wrong Device"));
          }
        } else {
          String deviceImei = await Functions.getDeviceIdentifiers();
          await updateImei(Imei(id: user.id, imei: deviceImei));
          await loginUser(username, password, imei, context);
        }
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

  Future<void> updateImei(Imei imei) async {
    emit(ImeiUpdateLoading());
    var result = await imeiRepo.updateImei(imei);
    result.fold(
      (failure) {
        emit(ImeiUpdateError(failure.errMessage));
      },
      (data) {
        emit(ImeiUpdateSuccess());
      },
    );
  }
}
