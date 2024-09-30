part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}
final class LoginSuccess extends LoginState {
  final LoginModel loginModel;
  const LoginSuccess(this.loginModel);
}

final class LoginFailure extends LoginState {
  final String errMessage;
  const LoginFailure(this.errMessage);
}
final class ImeiUpdateLoading extends LoginState {}
final class ImeiUpdateError extends LoginState {
  final String errMessage;
  const ImeiUpdateError(this.errMessage);
}
final class ImeiUpdateSuccess extends LoginState {}
