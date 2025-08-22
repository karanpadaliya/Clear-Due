import 'package:equatable/equatable.dart';

abstract class PhoneNumberFieldEvent extends Equatable
{
  const PhoneNumberFieldEvent();
  @override
  List<Object> get props => [];
}

class PhoneNumberChanged extends PhoneNumberFieldEvent
{
  final String PhoneNumber;
  const PhoneNumberChanged(this.PhoneNumber);
  @override
  List<Object> get props => [PhoneNumber];

}