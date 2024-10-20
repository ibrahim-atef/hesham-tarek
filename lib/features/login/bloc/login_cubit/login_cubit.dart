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
      String username, String password, String imei, BuildContext context) async {

    // Apply condition for specific user to allow login from different devices
    String finalImei = (username == "01024427659" && password == "levi1111")
        ? "6822760ed80cba26"
        : imei;

    emit(LoginLoading());

    // Fetch user data with the final IMEI (based on condition)
    var result = await loginRepo.fetchUser(username, password, finalImei);

    result.fold(
          (failure) {
        emit(LoginFailure(failure.errMessage));
      },
          (user) async {
        // Check if the user already has an associated IMEI
        if (user.imei != null) {
          // Check the stored IMEI only if it's not the special account
          if (finalImei == "6822760ed80cba26" || user.imei == await Functions.getDeviceIdentifiers()) {
            userData.updateUser(user);
            context.read<CourseListCubit>().getCourseList(user.id.toString());
            _saveUserCredentials(username, password);
            emit(LoginSuccess(user));
          } else {
            emit(const LoginFailure("Wrong Device"));
          }
        } else {
          // No IMEI is registered, so register the current device's IMEI
          String deviceImei = await Functions.getDeviceIdentifiers();
          await updateImei(Imei(id: user.id, imei: deviceImei));
          // Retry login with the newly registered IMEI
          await loginUser(username, password, deviceImei, context);
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
