import 'package:equatable/equatable.dart';

abstract class BookingCreationEvent extends Equatable {
  const BookingCreationEvent();
  @override
  List<Object?> get props => [];
}

class BookingCreateRequested extends BookingCreationEvent {
  final String courtId;
  final DateTime startTime;
  final DateTime endTime;
  const BookingCreateRequested({
    required this.courtId,
    required this.startTime,
    required this.endTime,
  });
  @override
  List<Object?> get props => [courtId, startTime, endTime];
}

class BookingCreationReset extends BookingCreationEvent {}