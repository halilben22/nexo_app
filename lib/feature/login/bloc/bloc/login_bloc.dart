import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nexo_app/feature/login/repo/login_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  LoginBloc({required this.loginRepository}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      emit(LoginInitial());
    });

    on<LoginWithGoogle>((event, emit) async {
      emit(LoginLoading());
      try {
        await loginRepository.signInWithGoogle();
        emit(LoginSuccess("Login success!"));
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });

    on<SignOut>((event, emit) async {
      emit(SigningOut());
      try {
        await loginRepository.signOut();
        emit(SignedOutSuccess("Sign out successfull!"));
      } catch (e) {
        emit(SignedOutFailure("Couldn't sign out due to $e"));
      }
    });
  }
}
