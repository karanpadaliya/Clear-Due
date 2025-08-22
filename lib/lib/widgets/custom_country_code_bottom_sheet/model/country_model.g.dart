// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) => CountryModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      iso3Code: json['iso3Code'] as String?,
      dialCode: json['dial_code'] as String?,
      flag: json['flag'] as String?,
    );

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'iso3Code': instance.iso3Code,
      'dial_code': instance.dialCode,
      'flag': instance.flag,
    };
