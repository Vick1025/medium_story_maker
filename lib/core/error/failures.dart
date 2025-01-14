import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]) : super();

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  final int statusCode;
  final String message;

  const ServerFailure({required this.statusCode, required this.message});
}
