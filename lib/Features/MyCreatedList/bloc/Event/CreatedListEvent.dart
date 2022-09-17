import 'package:equatable/equatable.dart';

abstract class CreatedListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCreatedListEvent extends CreatedListEvent {
  final String session;
  GetCreatedListEvent({required this.session});
}
