import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/network/api_client.dart';
import '../../../data/booking_service.dart';
import 'booking_event.dart';
import 'booking_state.dart';

class BookingBloc extends Bloc<BookingCreationEvent, BookingCreationState> {
  BookingBloc() : super(BookingCreationInitial()) {
    on<BookingCreateRequested>(_onCreateRequested);
    on<BookingCreationReset>((event, emit) => emit(BookingCreationInitial()));
  }

  Future<void> _onCreateRequested(
      BookingCreateRequested event,
      Emitter<BookingCreationState> emit,
      ) async {
    emit(BookingCreationLoading());
    try {
      final booking = await BookingService.createBooking(
        courtId: event.courtId,
        startTime: event.startTime,
        endTime: event.endTime,
      );
      emit(BookingCreationSuccess(booking));
    } on ApiException catch (e) {
      if (e.statusCode == 409) {
        emit(BookingCreationConflict(e.message));
      } else {
        emit(BookingCreationError(e.message));
      }
    } catch (_) {
      emit(const BookingCreationError("Couldn't reach the server. Try again."));
    }
  }
}