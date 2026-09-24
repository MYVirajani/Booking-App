import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/booking_service.dart';
import 'availability_event.dart';
import 'availability_state.dart';

class AvailabilityBloc extends Bloc<AvailabilityEvent, AvailabilityState> {
  AvailabilityBloc() : super(AvailabilityInitial()) {
    on<AvailabilityRequested>(_onRequested);
  }

  Future<void> _onRequested(AvailabilityRequested event, Emitter<AvailabilityState> emit) async {
    emit(AvailabilityLoading());
    try {
      final slots = await BookingService.getAvailability(courtId: event.courtId, date: event.date);
      emit(AvailabilityLoaded(slots));
    } catch (_) {
      emit(const AvailabilityError("Couldn't load availability."));
    }
  }
}