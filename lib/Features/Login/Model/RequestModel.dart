import 'package:equatable/equatable.dart';

class RequestTokenModel extends Equatable {
  final bool success;
  final String requestToken;

  RequestTokenModel({required this.success, required this.requestToken});

  factory RequestTokenModel.fromJson(Map<String, dynamic> json) {
    return RequestTokenModel(
        success: json['success'], requestToken: json['request_token']);
  }

  @override
  List<Object?> get props => [success, requestToken];
}

class SessionWithLoginPassWordTokenModel extends Equatable {
  final bool success;
  final String requestToken;

  SessionWithLoginPassWordTokenModel(
      {required this.success, required this.requestToken});

  factory SessionWithLoginPassWordTokenModel.fromJson(
      Map<String, dynamic> json) {
    return SessionWithLoginPassWordTokenModel(
        success: json['success'], requestToken: json['request_token']);
  }

  @override
  List<Object?> get props => [success, requestToken];
}

class Session extends Equatable {
  final bool success;
  final String sessionID;

  Session({required this.success, required this.sessionID});

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(success: json['success'], sessionID: json['session_id']);
  }

  @override
  List<Object?> get props => [success, sessionID];
}
