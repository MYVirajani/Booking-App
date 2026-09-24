import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../services/booking_service.dart';
import 'my_booking_event.dart';
import 'my_booking_state.dart';

class MyBookingsBloc extends Bloc<MyBookingsEvent, MyBookingsState> {
  MyBookingsBloc() : super(MyBookingsInitial()) {
    on<MyBookingsRequested>(_onRequested);
    on<MyBookingCancelRequested>(_onCancelRequested);
  }

  Future<void> _onRequested(MyBookingsRequested event, Emitter<MyBookingsState> emit) async {
    emit(MyBookingsLoading());
    try {
      final bookings = await BookingService.myBookings();
      emit(MyBookingsLoaded(bookings));
    } catch (_) {
      emit(const MyBookingsError("Couldn't load bookings."));
    }
  }

  Future<void> _onCancelRequested(
      MyBookingCancelRequested event,
      Emitter<MyBookingsState> emit,
      ) async {
    try {
      await BookingService.cancelBooking(event.bookingId);
      add(MyBookingsRequested());
    } catch (_) {
      emit(const MyBookingsError("Couldn't cancel that booking. Try again."));
    }
  }
}