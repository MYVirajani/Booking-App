import 'package:equatable/equatable.dart';
import '../../../models/booking.dart';

abstract class AvailabilityState extends Equatable {
  const AvailabilityState();
  @override
  List<Object?> get props => [];
}

class AvailabilityInitial extends AvailabilityState {}

class AvailabilityLoading extends AvailabilityState {}

class AvailabilityLoaded extends AvailabilityState {
  final List<AvailabilitySlot> bookedSlots;
  const AvailabilityLoaded(this.bookedSlots);
  @override
  List<Object?> get props => [bookedSlots];
}

class AvailabilityError extends AvailabilityState {
  final String message;
  const AvailabilityError(this.message);
  @override
  List<Object?> get props => [message];
}