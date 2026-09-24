import 'package:equatable/equatable.dart';

class SlotSelectionState extends Equatable {
  final DateTime selectedDate;
  final Set<int> selectedHours;

  const SlotSelectionState({required this.selectedDate, required this.selectedHours});

  factory SlotSelectionState.initial() {
    final today = DateTime.now();
    return SlotSelectionState(
      selectedDate: DateTime(today.year, today.month, today.day),
      selectedHours: const {},
    );
  }

  SlotSelectionState copyWith({DateTime? selectedDate, Set<int>? selectedHours}) {
    return SlotSelectionState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedHours: selectedHours ?? this.selectedHours,
    );
  }

  ({DateTime start, DateTime end})? get range {
    if (selectedHours.isEmpty) return null;
    final hours = selectedHours.toList()..sort();
    final start = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, hours.first);
    final end = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, hours.last + 1);
    return (start: start, end: end);
  }

  @override
  List<Object?> get props => [selectedDate, selectedHours];
}