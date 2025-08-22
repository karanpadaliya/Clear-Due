abstract class CustomToggleSwitchEvent {}

class ToggleSwitchToggled extends CustomToggleSwitchEvent {}

class ToggleSwitchSetInitial extends CustomToggleSwitchEvent {
  final bool initialValue;
  ToggleSwitchSetInitial(this.initialValue);
}
