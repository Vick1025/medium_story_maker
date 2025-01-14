part of 'draft_keeper_bloc.dart';

sealed class DraftKeeperState extends Equatable {
  const DraftKeeperState();
  
  @override
  List<Object> get props => [];
}

final class DraftKeeperInitial extends DraftKeeperState {}
