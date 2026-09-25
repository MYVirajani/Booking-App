import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../court/domain/court.dart';
import '../../../payment/presentation/screens/payment_screen.dart';
import '../../domain/booking.dart';
import '../bloc/availability/availability_bloc.dart';
import '../bloc/availability/availability_event.dart';
import '../bloc/availability/availability_state.dart';
import '../bloc/booking/booking_bloc.dart';
import '../bloc/booking/booking_event.dart';
import '../bloc/booking/booking_state.dart';
import '../bloc/slot_selection/slot_selection_bloc.dart';
import '../bloc/slot_selection/slot_selection_event.dart';
import '../bloc/slot_selection/slot_selection_state.dart';

class SlotPickerScreen extends StatelessWidget {
  final Court court;
  const SlotPickerScreen({super.key, required this.court});

  static const _openHour = 6;
  static const _closeHour = 23;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SlotSelectionBloc()),
        BlocProvider(create: (context) => AvailabilityBloc()
          ..add(AvailabilityRequested(
            courtId: court.id,
            date: context.read<SlotSelectionBloc>().state.selectedDate,
          ))),
        BlocProvider(create: (_) => BookingBloc()),
      ],
      child: _SlotPickerView(court: court, openHour: _openHour, closeHour: _closeHour),
    );
  }
}

class _SlotPickerView extends StatelessWidget {
  final Court court;
  final int openHour;
  final int closeHour;
  const _SlotPickerView({required this.court, required this.openHour, required this.closeHour});

  bool _isHourBooked(BuildContext context, int hour, List<AvailabilitySlot> booked) {
    final date = context.read<SlotSelectionBloc>().state.selectedDate;
    final start = DateTime(date.year, date.month, date.day, hour);
    final end = start.add(const Duration(hours: 1));
    return booked.any((slot) => slot.overlaps(start, end));
  }

  bool _isHourPast(BuildContext context, int hour) {
    final date = context.read<SlotSelectionBloc>().state.selectedDate;
    return DateTime(date.year, date.month, date.day, hour).isBefore(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final startOfToday = DateTime(today.year, today.month, today.day);
    final next14Days = List.generate(14, (i) => startOfToday.add(Duration(days: i)));
    final hours = List.generate(closeHour - openHour, (i) => openHour + i);

    return BlocListener<BookingBloc, BookingCreationState>(
      listener: (context, state) {
        if (state is BookingCreationSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PaymentScreen(booking: state.booking, court: court)),
          );
        }
        if (state is BookingCreationConflict) {
          // Someone else took the slot - refresh availability and clear selection.
          final date = context.read<SlotSelectionBloc>().state.selectedDate;
          context.read<AvailabilityBloc>().add(AvailabilityRequested(courtId: court.id, date: date));
          context.read<SlotSelectionBloc>().add(SlotSelectionCleared());
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 24, 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(court.name, style: const TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(court.priceLabel, style: const TextStyle(color: AppColors.accent, fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Date strip
              BlocBuilder<SlotSelectionBloc, SlotSelectionState>(
                builder: (context, selection) {
                  return SizedBox(
                    height: 76,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: next14Days.length,
                      itemBuilder: (context, index) {
                        final day = next14Days[index];
                        final isSelected = day.year == selection.selectedDate.year &&
                            day.month == selection.selectedDate.month &&
                            day.day == selection.selectedDate.day;
                        return GestureDetector(
                          onTap: () {
                            context.read<SlotSelectionBloc>().add(SlotDateSelected(day));
                            context.read<AvailabilityBloc>().add(AvailabilityRequested(courtId: court.id, date: day));
                          },
                          child: Container(
                            width: 56,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.accent : AppColors.cardFill.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(DateFormat('E').format(day).toUpperCase(),
                                    style: TextStyle(
                                        color: isSelected ? Colors.black54 : AppColors.textMuted,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text(DateFormat('d').format(day),
                                    style: TextStyle(
                                        color: isSelected ? Colors.black : AppColors.textPrimary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 10),
              BlocBuilder<SlotSelectionBloc, SlotSelectionState>(
                builder: (context, selection) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat('EEEE, d MMMM').format(selection.selectedDate),
                          style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16)),
                      _legendDot(AppColors.accent, "Free"),
                      _legendDot(Colors.white24, "Booked"),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: BlocBuilder<AvailabilityBloc, AvailabilityState>(
                  builder: (context, availabilityState) {
                    if (availabilityState is AvailabilityLoading || availabilityState is AvailabilityInitial) {
                      return const Center(child: CircularProgressIndicator(color: AppColors.accent));
                    }
                    if (availabilityState is AvailabilityError) {
                      return Center(child: Text(availabilityState.message, style: const TextStyle(color: AppColors.textMuted)));
                    }
                    final booked = (availabilityState as AvailabilityLoaded).bookedSlots;

                    return BlocBuilder<SlotSelectionBloc, SlotSelectionState>(
                      builder: (context, selection) {
                        return GridView.builder(
                          padding: const EdgeInsets.fromLTRB(24, 16, 24, 140),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 2.0,
                          ),
                          itemCount: hours.length,
                          itemBuilder: (context, index) {
                            final hour = hours[index];
                            final isBooked = _isHourBooked(context, hour, booked);
                            final isPast = _isHourPast(context, hour);
                            final isDisabled = isBooked || isPast;
                            final isSelected = selection.selectedHours.contains(hour);
                            final label = DateFormat('h:mm a').format(DateTime(2000, 1, 1, hour));

                            return GestureDetector(
                              onTap: isDisabled ? null : () => context.read<SlotSelectionBloc>().add(SlotHourToggled(hour)),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.accent
                                      : isDisabled
                                      ? Colors.white.withOpacity(0.03)
                                      : AppColors.cardFill.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: isSelected ? AppColors.accent : Colors.white.withOpacity(0.06)),
                                ),
                                child: Center(
                                  child: Text(
                                    label,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? Colors.black : (isDisabled ? Colors.white24 : AppColors.textPrimary),
                                      decoration: isBooked ? TextDecoration.lineThrough : null,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomSheet: BlocBuilder<SlotSelectionBloc, SlotSelectionState>(
          builder: (context, selection) {
            final totalHours = selection.selectedHours.length;
            if (totalHours == 0) return const SizedBox.shrink();
            final totalPrice = totalHours * court.ratePerHour;

            return Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
              ),
              child: SafeArea(
                top: false,
                child: BlocBuilder<BookingBloc, BookingCreationState>(
                  builder: (context, bookingState) {
                    final isBooking = bookingState is BookingCreationLoading;
                    final error = bookingState is BookingCreationConflict
                        ? bookingState.message
                        : bookingState is BookingCreationError
                        ? bookingState.message
                        : null;

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (error != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(error, style: const TextStyle(color: AppColors.danger, fontSize: 13)),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$totalHours hr${totalHours > 1 ? 's' : ''} selected", style: const TextStyle(color: AppColors.textMuted)),
                            Text("LKR ${totalPrice.toStringAsFixed(0)}",
                                style: const TextStyle(color: AppColors.accent, fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: isBooking
                              ? null
                              : () {
                            final range = selection.range;
                            if (range == null) return;
                            context.read<BookingBloc>().add(BookingCreateRequested(
                              courtId: court.id,
                              startTime: range.start,
                              endTime: range.end,
                            ));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accentAlt,
                            foregroundColor: Colors.black,
                            minimumSize: const Size(double.infinity, 56),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          child: isBooking
                              ? const SizedBox(
                              height: 22, width: 22,
                              child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.black))
                              : const Text("CONTINUE TO PAYMENT", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
      ],
    );
  }
}