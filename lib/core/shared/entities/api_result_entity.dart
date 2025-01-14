import 'package:equatable/equatable.dart';

class ApiResultEntity extends Equatable {
  final int status;
  final String message;

  const ApiResultEntity({required this.status, required this.message});

  @override
  List<Object?> get props => [status, message];
}
