// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'past_experience_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PastExperienceModel _$PastExperienceModelFromJson(Map<String, dynamic> json) =>
    PastExperienceModel(
      experience:
          (json['experience'] as List<dynamic>?)
              ?.map((e) => Experience.fromJson(e as Map<String, dynamic>))
              .toList(),
      message: json['message'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$PastExperienceModelToJson(
  PastExperienceModel instance,
) => <String, dynamic>{
  'experience': instance.experience,
  'message': instance.message,
  'status': instance.status,
};

Experience _$ExperienceFromJson(Map<String, dynamic> json) => Experience(
  employeeExperienceId: json['employee_experience_id'] as String?,
  designation: json['designation'] as String?,
  workFrom: json['work_from'] as String?,
  companyLocation: json['company_location'] as String?,
  expCompanyName: json['exp_company_name'] as String?,
);

Map<String, dynamic> _$ExperienceToJson(Experience instance) =>
    <String, dynamic>{
      'employee_experience_id': instance.employeeExperienceId,
      'designation': instance.designation,
      'work_from': instance.workFrom,
      'company_location': instance.companyLocation,
      'exp_company_name': instance.expCompanyName,
    };
