import 'package:equatable/equatable.dart';

enum LoginStatus { initial, loginSuccess, loginFailure, loading }

class LoginState extends Equatable {
  final LoginStatus status;
  final String? session;
  final String? error;
  LoginState({String? session, String? error, required this.status})
      : session = session,
        error = error;

  LoginState copyWith(
      String? session, String? error, LoginStatus loginSuccess) {
    return LoginState(session: session, error: error, status: loginSuccess);
  }

  @override
  List<Object?> get props => [status];
}
