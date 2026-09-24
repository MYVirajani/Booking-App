import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/court_service.dart';
import 'court_event.dart';
import 'court_state.dart';

class CourtBloc extends Bloc<CourtEvent, CourtState> {
  CourtBloc() : super(CourtInitial()) {
    on<CourtListRequested>(_onListRequested);
  }

  Future<void> _onListRequested(CourtListRequested event, Emitter<CourtState> emit) async {
    emit(CourtLoading());
    try {
      final courts = await CourtService.listCourts();
      emit(CourtLoaded(courts));
    } catch (_) {
      emit(const CourtError("Couldn't load courts. Pull down to retry."));
    }
  }
}