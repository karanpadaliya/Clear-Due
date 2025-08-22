import 'package:equatable/equatable.dart';

// The main entity for the company response.
class CompanyResponseEntity extends Equatable {
  final List<SocietyEntity>? society;
  final String? status;
  final String? message;
  final bool? takeRequestSociety;

  const CompanyResponseEntity({
    this.society,
    this.status,
    this.message,
    this.takeRequestSociety,
  });

  @override
  List<Object?> get props => [society, status, message, takeRequestSociety];
}

// The entity for a single society.
class SocietyEntity extends Equatable {
  final String? companyId;
  final String? companyName;
  final String? companyAddress;
  final String? secretaryEmail;
  final String? secretaryMobile;
  final String? companyLogo;
  final String? shareAppContent;
  final String? companyStatus;
  final String? subDomain;
  final bool? isSociety;
  final String? apiKey;
  final bool? isFirebase;
  final String? countryId;
  final String? stateId;
  final String? cityId;
  final String? societyType;
  final String? stateCountryName;
  final String? loginVia;
  final String? googleLogin;

  const SocietyEntity({
    this.companyId,
    this.companyName,
    this.companyAddress,
    this.secretaryEmail,
    this.secretaryMobile,
    this.companyLogo,
    this.shareAppContent,
    this.companyStatus,
    this.subDomain,
    this.isSociety,
    this.apiKey,
    this.isFirebase,
    this.countryId,
    this.stateId,
    this.cityId,
    this.societyType,
    this.stateCountryName,
    this.loginVia,
    this.googleLogin,
  });

  @override
  List<Object?> get props => [
    companyId,
    companyName,
    companyAddress,
    secretaryEmail,
    secretaryMobile,
    companyLogo,
    shareAppContent,
    companyStatus,
    subDomain,
    isSociety,
    apiKey,
    isFirebase,
    countryId,
    stateId,
    cityId,
    societyType,
    stateCountryName,
    loginVia,
    googleLogin,
  ];
}
