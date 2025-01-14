part of 'menu_bloc.dart';

abstract class MenuEvent {}

class MenuItemSelectedEvent extends MenuEvent {
  final String item;
  MenuItemSelectedEvent(this.item);
}
