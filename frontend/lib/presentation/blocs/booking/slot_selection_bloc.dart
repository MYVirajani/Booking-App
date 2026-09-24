import 'package:flutter_bloc/flutter_bloc.dart';
import 'slot_selection_event.dart';
import 'slot_selection_state.dart';

class SlotSelectionBloc extends Bloc<SlotSelectionEvent, SlotSelectionState> {
  SlotSelectionBloc() : super(SlotSelectionState.initial()) {
    on<SlotDateSelected>((event, emit) {
      emit(state.copyWith(selectedDate: event.date, selectedHours: {}));
    });

    on<SlotHourToggled>((event, emit) {
      final updated = Set<int>.from(state.selectedHours);
      if (updated.contains(event.hour)) {
        updated.remove(event.hour);
      } else {
        updated.add(event.hour);
      }
      emit(state.copyWith(selectedHours: updated));
    });

    on<SlotSelectionCleared>((event, emit) {
      emit(state.copyWith(selectedHours: {}));
    });
  }
}