import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/payment_service.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<PaymentInitRequested>(_onInitRequested);
  }

  Future<void> _onInitRequested(PaymentInitRequested event, Emitter<PaymentState> emit) async {
    emit(PaymentLoading());
    try {
      final data = await PaymentService.initPayment(event.bookingId);
      emit(PaymentReady(data));
    } catch (_) {
      emit(const PaymentError("Couldn't start payment. Try again."));
    }
  }
}