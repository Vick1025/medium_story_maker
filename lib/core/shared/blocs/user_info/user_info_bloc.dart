import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

///User info might be use in many places, so we create a separate bloc to manage it.

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  UserInfoBloc() : super(UserInfoInitial()) {
    on<UserInfoEvent>((event, emit) {});
    on<GetUserInfoEvent>(_onGetUserInfo);
  }

  ///Just for testing, Simulate a network call to get user info
  Future<void> _onGetUserInfo(
      GetUserInfoEvent event, Emitter<UserInfoState> emit) async {
    emit(UserInfoLoading());
    //Call api to get user info (event.account, event.password)
    await Future.delayed(const Duration(seconds: 2));
    emit(UserInfoLoaded("TestName", "test@test.com"));
  }
}
