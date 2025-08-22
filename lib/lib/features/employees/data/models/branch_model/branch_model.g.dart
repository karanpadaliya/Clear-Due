// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchModel _$BranchModelFromJson(Map<String, dynamic> json) => BranchModel(
  branchId: json['block_id'] as String?,
  branchName: json['block_name'] as String?,
  companyId: json['society_id'] as String?,
);

Map<String, dynamic> _$BranchModelToJson(BranchModel instance) =>
    <String, dynamic>{
      'block_id': instance.branchId,
      'block_name': instance.branchName,
      'society_id': instance.companyId,
    };
