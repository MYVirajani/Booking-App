import 'package:equatable/equatable.dart';

abstract class AvailabilityEvent extends Equatable {
  const AvailabilityEvent();
  @override
  List<Object?> get props => [];
}

class AvailabilityRequested extends AvailabilityEvent {
  final String courtId;
  final DateTime date;
  const AvailabilityRequested({required this.courtId, required this.date});
  @override
  List<Object?> get props => [courtId, date];
}