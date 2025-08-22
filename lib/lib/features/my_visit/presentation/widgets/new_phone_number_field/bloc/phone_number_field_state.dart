import 'package:equatable/equatable.dart';

abstract class PhoneNumberFieldState extends Equatable {
  const PhoneNumberFieldState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class PhoneNumberFieldInitial extends PhoneNumberFieldState {}

/// Loading state
class PhoneNumberLoading extends PhoneNumberFieldState {}

/// Loaded successfully
class PhoneNumberFieldLoaded extends PhoneNumberFieldState {
  final String phoneNumber;

  const PhoneNumberFieldLoaded(this.phoneNumber);

  bool get hasText => phoneNumber.isNotEmpty;

  @override
  List<Object?> get props => [phoneNumber];
}

/// Error state
class PhoneNumberFieldFailure extends PhoneNumberFieldState {
  final String massage;

  const PhoneNumberFieldFailure(this.massage);

  @override
  List<Object?> get props => [massage];
}
