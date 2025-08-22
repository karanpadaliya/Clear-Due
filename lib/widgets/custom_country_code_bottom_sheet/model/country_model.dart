import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'country_model.g.dart';

CountryModel countryModelFromJson(String str) =>
    CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

@JsonSerializable()
class CountryModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "code")
  String? code;
  @JsonKey(name: "iso3Code")
  String? iso3Code;
  @JsonKey(name: "dial_code")
  String? dialCode;
  @JsonKey(name: "flag")
  String? flag;

  CountryModel({
    this.id,
    this.name,
    this.code,
    this.iso3Code,
    this.dialCode,
    this.flag,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CountryModel &&
        id == other.id &&
        name == other.name &&
        code == other.code &&
        iso3Code == other.iso3Code &&
        dialCode == other.dialCode &&
        flag == other.flag;
  }

  @override
  int get hashCode => Object.hash(id, name, code, iso3Code, dialCode, flag);
}
