part of 'menu_bloc.dart';

sealed class MenuState {
  const MenuState();
}

class MenuScreenState extends MenuState {
  final String selectedItem;

  MenuScreenState({required this.selectedItem});
}
