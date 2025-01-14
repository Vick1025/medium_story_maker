import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_maker/core/shared/blocs/user_info/user_info_bloc.dart';

class UserNameDisplay extends StatelessWidget {
  const UserNameDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserInfoBloc, UserInfoState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is UserInfoLoaded) {
          return Text(
            state.userName,
            style: const TextStyle(
              fontSize: 20,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
