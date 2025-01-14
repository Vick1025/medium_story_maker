import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_maker/core/shared/blocs/user_info/user_info_bloc.dart';

class UserImageAvatar extends StatelessWidget {
  const UserImageAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserInfoBloc, UserInfoState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is UserInfoLoaded) {
          return const CircleAvatar(
            radius: 30,
            child: Text("T"),
          );
        }
        if (state is UserInfoLoading) {
          return const CircleAvatar(
            radius: 30,
            child: CircularProgressIndicator(),
          );
        }
        return InkWell(
          onTap: () => context.read<UserInfoBloc>().add(
                GetUserInfoEvent("userEmail", "thePassword"),
              ),
          child: const CircleAvatar(
            radius: 30,
            child: Icon(
              Icons.person,
              size: 40,
            ),
          ),
        );
      },
    );
  }
}
