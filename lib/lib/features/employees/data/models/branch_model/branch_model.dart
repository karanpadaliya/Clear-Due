import 'package:json_annotation/json_annotation.dart';
import 'package:myco_flutter/features/employees/domain/entites/branch_entity.dart'; // Import the entity
import 'package:equatable/equatable.dart';
import 'dart:convert';

part 'branch_model.g.dart';

BranchModel branchModelFromJson(String str) =>
    BranchModel.fromJson(json.decode(str));

String branchModelToJson(BranchModel data) => json.encode(data.toJson());

@JsonSerializable()
class BranchModel extends Equatable {
  @JsonKey(name: "block_id")
  final String? branchId;

  @JsonKey(name: "block_name")
  final String? branchName;

  @JsonKey(name: "society_id")
  final String? companyId;

  const BranchModel({this.branchId, this.branchName, this.companyId});

  factory BranchModel.fromJson(Map<String, dynamic> json) =>
      _$BranchModelFromJson(json);

  Map<String, dynamic> toJson() => _$BranchModelToJson(this);

  Branch toEntity() =>
      Branch(branchId: branchId, branchName: branchName, companyId: companyId);

  @override
  List<Object?> get props => [branchId, branchName, companyId];
}
