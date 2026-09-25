import 'package:equatable/equatable.dart';
import '../../data/payment_service.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();
  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentReady extends PaymentState {
  final PaymentInitData data;
  const PaymentReady(this.data);
  @override
  List<Object?> get props => [data];
}

class PaymentError extends PaymentState {
  final String message;
  const PaymentError(this.message);
  @override
  List<Object?> get props => [message];
}