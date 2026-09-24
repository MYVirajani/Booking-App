import 'package:equatable/equatable.dart';

abstract class MyBookingsEvent extends Equatable {
  const MyBookingsEvent();
  @override
  List<Object?> get props => [];
}

class MyBookingsRequested extends MyBookingsEvent {}

class MyBookingCancelRequested extends MyBookingsEvent {
  final String bookingId;
  const MyBookingCancelRequested(this.bookingId);
  @override
  List<Object?> get props => [bookingId];
}