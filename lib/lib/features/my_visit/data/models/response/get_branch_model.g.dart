// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_branch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBranchModel _$GetBranchModelFromJson(Map<String, dynamic> json) =>
    GetBranchModel(
      branchList:
          (json['branch_list'] as List<dynamic>?)
              ?.map((e) => BranchList.fromJson(e as Map<String, dynamic>))
              .toList(),
      message: json['message'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$GetBranchModelToJson(GetBranchModel instance) =>
    <String, dynamic>{
      'branch_list': instance.branchList,
      'message': instance.message,
      'status': instance.status,
    };

BranchList _$BranchListFromJson(Map<String, dynamic> json) => BranchList(
  blockId: json['block_id'] as String?,
  societyId: json['society_id'] as String?,
  blockName: json['block_name'] as String?,
);

Map<String, dynamic> _$BranchListToJson(BranchList instance) =>
    <String, dynamic>{
      'block_id': instance.blockId,
      'society_id': instance.societyId,
      'block_name': instance.blockName,
    };
