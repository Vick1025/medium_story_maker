import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuScreenState(selectedItem: 'home'.tr())) {
    on<MenuItemSelectedEvent>(_onMenuItemSelected);
  }

  /// When the user selects a menu item, we need to update the state.
  void _onMenuItemSelected(
      MenuItemSelectedEvent event, Emitter<MenuState> emit) {
    emit(MenuScreenState(selectedItem: event.item));
  }
}
