import 'package:equatable/equatable.dart';

abstract class CourtEvent extends Equatable {
  const CourtEvent();
  @override
  List<Object?> get props => [];
}

class CourtListRequested extends CourtEvent {}