import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();
  @override
  List<Object?> get props => [];
}

class PaymentInitRequested extends PaymentEvent {
  final String bookingId;
  const PaymentInitRequested(this.bookingId);
  @override
  List<Object?> get props => [bookingId];
}