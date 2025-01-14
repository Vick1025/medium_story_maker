part of 'user_info_bloc.dart';

@immutable
sealed class UserInfoState {}

final class UserInfoInitial extends UserInfoState {}

final class UserInfoLoading extends UserInfoState {}

final class UserInfoLoaded extends UserInfoState {
  final String userName;
  final String userEmail;

  UserInfoLoaded(this.userName, this.userEmail);
}
