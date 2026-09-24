import 'package:equatable/equatable.dart';
import '../../../models/booking.dart';

abstract class BookingCreationState extends Equatable {
  const BookingCreationState();
  @override
  List<Object?> get props => [];
}

class BookingCreationInitial extends BookingCreationState {}

class BookingCreationLoading extends BookingCreationState {}

class BookingCreationSuccess extends BookingCreationState {
  final Booking booking;
  const BookingCreationSuccess(this.booking);
  @override
  List<Object?> get props => [booking];
}

class BookingCreationConflict extends BookingCreationState {
  final String message;
  const BookingCreationConflict(this.message);
  @override
  List<Object?> get props => [message];
}

class BookingCreationError extends BookingCreationState {
  final String message;
  const BookingCreationError(this.message);
  @override
  List<Object?> get props => [message];
}