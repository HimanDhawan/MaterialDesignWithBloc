import 'package:equatable/equatable.dart';

abstract class CreatedListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCreatedListEvent extends CreatedListEvent {
  GetCreatedListEvent();
}
