import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/admin_view/dashboard/data/models/admin_view_request.dart';
import 'package:myco_flutter/features/admin_view/dashboard/domain/entities/admin_view_entity.dart';
import 'package:myco_flutter/features/admin_view/dashboard/domain/repositories/admin_view_repository.dart';

class AdminViewUseCase {
  final AdminViewRepository repository;

  AdminViewUseCase({required this.repository});

  /// Fetches fresh admin view data from the repository
  Future<Either<Failure, AdminViewResponseEntity>> getAdminView(
    AdminViewRequest params,
  ) async => await repository.getAdminView(params);

  /// Fetches cached admin view data from the repository
  Future<Either<Failure, AdminViewResponseEntity>> getCachedAdminView(
    String companyId,
  ) async => await repository.getCachedAdminView(companyId);
}
