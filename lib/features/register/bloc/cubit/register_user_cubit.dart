import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hesham_tarek/features/register/data/repo/create_user_repo.dart';

part 'register_user_state.dart';

class RegisterUserCubit extends Cubit<RegisterUserState> {
  final CreateUserRepo createUserRepo;
  RegisterUserCubit(this.createUserRepo) : super(RegisterUserInitial());
  Future<void> registerUser(
      String username, password, phoneNumber, email, imei) async {
    emit(RegisterUserLoading());
    var result = await createUserRepo.createUser(
        username, password, phoneNumber, email, imei);
    result.fold(
      (failure) {
        emit(RegisterUserFailure(failure.errMessage));
      },
      (user) async {
        emit(RegisterUserSuccess());
      },
    );
  }
}
