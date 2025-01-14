import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'draft_keeper_event.dart';
part 'draft_keeper_state.dart';

class DraftKeeperBloc extends Bloc<DraftKeeperEvent, DraftKeeperState> {
  DraftKeeperBloc() : super(DraftKeeperInitial()) {
    on<DraftKeeperEvent>((event, emit) {});
  }
}
