import 'package:equatable/equatable.dart';

class Branch extends Equatable {
  final String? branchId;
  final String? companyId;
  final String? branchName;

  const Branch({this.branchId, this.companyId, this.branchName});

  @override
  List<Object?> get props => [branchId, companyId, branchName];
}
