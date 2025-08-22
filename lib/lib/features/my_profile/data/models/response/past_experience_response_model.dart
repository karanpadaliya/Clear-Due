import 'package:json_annotation/json_annotation.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/past_experience_entity.dart';

part 'past_experience_response_model.g.dart';

@JsonSerializable()
class PastExperienceModel {
  @JsonKey(name: "experience")
  List<Experience>? experience;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "status")
  String? status;

  PastExperienceModel({
    this.experience,
    this.message,
    this.status,
  });

  factory PastExperienceModel.fromJson(Map<String, dynamic> json) => _$PastExperienceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PastExperienceModelToJson(this);

  PastExperienceEntity toEntity()=> PastExperienceEntity(
        experience: experience?.map((e) => e.toEntity()).toList(),
        message: message,
        status: status,
      );
}

@JsonSerializable()
class Experience {
  @JsonKey(name: "employee_experience_id")
  String? employeeExperienceId;
  @JsonKey(name: "designation")
  String? designation;
  @JsonKey(name: "work_from")
  String? workFrom;
  @JsonKey(name: "company_location")
  String? companyLocation;
  @JsonKey(name: "exp_company_name")
  String? expCompanyName;

  Experience({
    this.employeeExperienceId,
    this.designation,
    this.workFrom,
    this.companyLocation,
    this.expCompanyName,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => _$ExperienceFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);

  ExperienceItemEntity toEntity() => ExperienceItemEntity(
        employeeExperienceId: employeeExperienceId,
        designation: designation,
        workFrom: workFrom,
        companyLocation: companyLocation,
        expCompanyName: expCompanyName,
      );
}
