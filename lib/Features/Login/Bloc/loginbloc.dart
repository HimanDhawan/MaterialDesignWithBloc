import 'package:bloc/bloc.dart';
import 'package:fluttersample/Features/Login/Bloc/LoginEvent/LoginEvent.dart';
import 'package:fluttersample/Features/Login/Bloc/LoginState/LoginState.dart';
import 'package:fluttersample/Features/Login/Bloc/Repository/LoginRepository.dart';
import 'package:fluttersample/Features/Login/Model/RequestModel.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({required this.loginRepository})
      : super(LoginState(status: LoginStatus.initial)) {
    on<LoginUser>(login);
  }

  void login(LoginUser event, Emitter<LoginState> emit) async {
    print("Login bloc called " + event.username + " " + event.password);
    try {
      emit(state.copyWith(null, null, LoginStatus.loading));
      Session session =
          await loginRepository.login(event.username, event.password);
      emit(state.copyWith(session.sessionID, null, LoginStatus.loginSuccess));
    } catch (error) {
      emit(state.copyWith(null, error.toString(), LoginStatus.loginFailure));
    }
  }
}
