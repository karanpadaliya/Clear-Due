import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:myco_flutter/features/my_visit/domain/entites/get_branch_entity.dart';

part 'get_branch_model.g.dart';

GetBranchModel getBranchModelFromJson(String str) =>
    GetBranchModel.fromJson(json.decode(str));

String getBranchModelToJson(GetBranchModel data) => json.encode(data.toJson());

@JsonSerializable()
class GetBranchModel {
  @JsonKey(name: "branch_list")
  List<BranchList>? branchList;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "status")
  String? status;

  GetBranchModel({this.branchList, this.message, this.status});

  factory GetBranchModel.fromJson(Map<String, dynamic> json) =>
      _$GetBranchModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetBranchModelToJson(this);

  /// Convert to Entity
  GetBranchEntity toEntity() => GetBranchEntity(
    branchList: branchList?.map((e) => e.toEntity()).toList() ?? [],
    message: message ?? '',
    status: status ?? '',
  );
}

@JsonSerializable()
class BranchList {
  @JsonKey(name: "block_id")
  String? blockId;

  @JsonKey(name: "society_id")
  String? societyId;

  @JsonKey(name: "block_name")
  String? blockName;

  BranchList({this.blockId, this.societyId, this.blockName});

  factory BranchList.fromJson(Map<String, dynamic> json) =>
      _$BranchListFromJson(json);

  Map<String, dynamic> toJson() => _$BranchListToJson(this);

  /// Convert to Entity
  BranchEntity toEntity() => BranchEntity(
    blockId: blockId ?? '',
    societyId: societyId ?? '',
    blockName: blockName ?? '',
  );
}
