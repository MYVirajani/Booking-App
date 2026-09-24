import 'package:equatable/equatable.dart';

abstract class SlotSelectionEvent extends Equatable {
  const SlotSelectionEvent();
  @override
  List<Object?> get props => [];
}

class SlotDateSelected extends SlotSelectionEvent {
  final DateTime date;
  const SlotDateSelected(this.date);
  @override
  List<Object?> get props => [date];
}

class SlotHourToggled extends SlotSelectionEvent {
  final int hour;
  const SlotHourToggled(this.hour);
  @override
  List<Object?> get props => [hour];
}

class SlotSelectionCleared extends SlotSelectionEvent {}