import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../booking/domain/booking.dart';
import '../../../booking/presentation/screens/bookings_screen.dart';
import '../../../court/domain/court.dart';
import '../bloc/payment_bloc.dart';
import '../bloc/payment_event.dart';
import '../bloc/payment_state.dart';

class PaymentScreen extends StatelessWidget {
  final Booking booking;
  final Court court;
  const PaymentScreen({super.key, required this.booking, required this.court});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentBloc(),
      child: _PaymentView(booking: booking, court: court),
    );
  }
}

class _PaymentView extends StatefulWidget {
  final Booking booking;
  final Court court;
  const _PaymentView({required this.booking, required this.court});

  @override
  State<_PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<_PaymentView> {
  String? _sdkError;

  void _launchPayHere(BuildContext context, PaymentReady state) {
    final init = state.data;
    final paymentObject = {
      "sandbox": init.sandbox,
      "merchant_id": init.merchantId,
      "notify_url": init.notifyUrl,
      "order_id": init.orderId,
      "items": init.items,
      "amount": init.amount.toStringAsFixed(2),
      "currency": init.currency,
      "hash": init.hash,
      "first_name": "Guest",
      "last_name": "User",
      "email": "guest@example.com",
      "phone": "0770000000",
      "address": "No Address",
      "city": "Colombo",
      "country": "Sri Lanka",
    };

    PayHere.startPayment(
      paymentObject,
          (paymentId) {

        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const BookingsScreen()),
              (route) => false,
        );
      },
          (error) {
        if (!mounted) return;
        setState(() => _sdkError = "Payment failed: $error");
      },
          () {
        if (!mounted) return;
        setState(() => _sdkError = "Payment cancelled.");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final b = widget.booking;
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is PaymentReady) _launchPayHere(context, state);
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("Confirm & Pay", style: TextStyle(color: AppColors.textPrimary)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: AppColors.cardFill.withOpacity(0.05), borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(color: AppColors.accent.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                          child: Icon(widget.court.icon, color: AppColors.accent),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(widget.court.name,
                              style: const TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.white12, height: 32),
                    _row("Date", "${b.startTime.day}/${b.startTime.month}/${b.startTime.year}"),
                    _row("Time", "${_fmt(b.startTime)} - ${_fmt(b.endTime)}"),
                    _row("Duration", "${b.endTime.difference(b.startTime).inHours} hr(s)"),
                    const Divider(color: Colors.white12, height: 32),
                    _row("Total", "LKR ${b.totalAmount.toStringAsFixed(0)}", isTotal: true),
                  ],
                ),
              ),
              const Spacer(),
              BlocBuilder<PaymentBloc, PaymentState>(
                builder: (context, state) {
                  final isLoading = state is PaymentLoading;
                  final error = _sdkError ?? (state is PaymentError ? state.message : null);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (error != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(error, style: const TextStyle(color: AppColors.danger)),
                        ),
                      ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                          setState(() => _sdkError = null);
                          context.read<PaymentBloc>().add(PaymentInitRequested(widget.booking.id));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentAlt,
                          foregroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 60),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: isLoading
                            ? const SizedBox(height: 22, width: 22, child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.black))
                            : const Text("PAY WITH PAYHERE", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _fmt(DateTime t) {
    final h = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final m = t.minute.toString().padLeft(2, '0');
    final period = t.hour >= 12 ? "PM" : "AM";
    return "$h:$m $period";
  }

  Widget _row(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: isTotal ? AppColors.textPrimary : AppColors.textMuted, fontSize: isTotal ? 16 : 14)),
          Text(value,
              style: TextStyle(
                color: isTotal ? AppColors.accent : AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: isTotal ? 20 : 14,
              )),
        ],
      ),
    );
  }
}