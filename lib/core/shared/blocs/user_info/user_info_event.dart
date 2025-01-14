part of 'user_info_bloc.dart';

@immutable
sealed class UserInfoEvent {}

class GetUserInfoEvent extends UserInfoEvent {
  final String account;
  final String password;

  GetUserInfoEvent(this.account, this.password);
}
