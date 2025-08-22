import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/core/error/global_error_handler/global_error_cubit.dart';
import 'package:myco_flutter/core/network/network_info.dart';
import 'package:myco_flutter/features/dashboard/data/datasources/dashboard_local_data_source.dart';
import 'package:myco_flutter/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:myco_flutter/features/dashboard/data/models/requests/attendance_requests.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/attendance_punch_in_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/attendance_punch_out_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/attendance_type_response_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/break_in_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/break_out_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/home_menu_response_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/id_card_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/my_unit_response_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/requests/get_attendance_type_request.dart';
import 'package:myco_flutter/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;
  final DashboardLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final GlobalErrorCubit globalErrorCubit;

  DashboardRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
    required this.globalErrorCubit,
  });

  @override
  Future<Either<Failure, IdCardEntity>> getIDCardDetails(
    Map<String, dynamic> dataMap,
  ) async {
    // 1. Get the result from the data source, which is already an Either.
    final result = await remoteDataSource.getIDCardDetails(dataMap);

    // 2. Use .map() to transform the Right side (the model) into an entity.
    // This correctly handles the Either type.
    return result.fold(Left.new, (idCardData) => Right(idCardData.toEntity()));
  }

  @override
  Future<Either<Failure, HomeMenuResponseEntity>> getAppMenuGridWithCategory(
    Map<String, dynamic> dataMap,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      final remoteResult = await remoteDataSource.getAppMenuGridWithCategory(
        dataMap,
      );

      return remoteResult.fold(
        (failure) async {
          globalErrorCubit.showGlobalError(failure.message);
          // *** MODIFICATION START ***
          // If the remote call fails, try the cache as a fallback.

          final localMenu = await localDataSource.getHomeMenu();
          if (localMenu != null) {
            return Right(localMenu.toEntity());
          } else {
            // If cache is also empty, return the original failure.
            return Left(failure);
          }
          // *** MODIFICATION END ***
        },
        (menuModel) {
          localDataSource.cacheHomeMenu(menuModel);
          return Right(menuModel.toEntity());
        },
      );
    } else {
      // If offline, try to get data from the local cache.
      final localMenu = await localDataSource.getHomeMenu();
      if (localMenu != null) {
        return Right(localMenu.toEntity());
      } else {
        return const Left(
          NetworkFailure('No Internet Connection and no cache available.'),
        );
      }
    }
  }

  @override
  Future<Either<Failure, MyUnitResponseEntity>> getMyUnits(
    Map<String, dynamic> dataMap,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      final remoteResult = await remoteDataSource.getMyUnits(dataMap);

      return remoteResult.fold(
        (failure) async {
          globalErrorCubit.showGlobalError(failure.message);

          // *** MODIFICATION START ***
          // If the remote call fails, try the cache as a fallback.
          final localUnits = await localDataSource.getMyUnits();
          if (localUnits != null) {
            return Right(localUnits.toEntity());
          } else {
            // If cache is also empty, return the original failure.
            return Left(failure);
          }
          // *** MODIFICATION END ***
        },
        (unitModel) {
          localDataSource.cacheMyUnits(unitModel);
          return Right(unitModel.toEntity());
        },
      );
    } else {
      final localUnits = await localDataSource.getMyUnits();
      if (localUnits != null) {
        return Right(localUnits.toEntity());
      } else {
        return const Left(
          NetworkFailure('No Internet Connection and no cache available.'),
        );
      }
    }
  }

  @override
  Future<Either<Failure, AttendanceTypeResponseEntity>> getAttendanceType(
    GetAttendanceTypeRequest dataMap,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      final remoteResult = await remoteDataSource.getAttendanceType(dataMap);
      return remoteResult.fold(
        (failure) async {
          globalErrorCubit.showGlobalError(failure.message);

          final localData = await localDataSource.getAttendanceType();
          if (localData != null) {
            return Right(localData.toEntity());
          } else {
            return Left(failure);
          }
        },
        (attendanceTypeModel) async {
          await localDataSource.cacheAttendanceType(attendanceTypeModel);
          return Right(attendanceTypeModel.toEntity());
        },
      );
    } else {
      final localData = await localDataSource.getAttendanceType();
      if (localData != null) {
        return Right(localData.toEntity());
      } else {
        return const Left(
          NetworkFailure('No Internet Connection and no cache available.'),
        );
      }
    }
  }

  @override
  Future<Either<Failure, AttendancePunchInEntity>> attendancePunchIn(
    AttendancePunchInRequest request,
  ) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.attendancePunchIn(request);
      return result.fold(
        (failure) => Left(failure),
        (response) => Right(response.toEntity()),
      );
    } else {
      return const Left(NetworkFailure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, AttendancePunchOutEntity>> attendancePunchOut(
    AttendancePunchOutRequest request,
  ) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.attendancePunchOut(request);
      return result.fold(
        (failure) => Left(failure),
        (response) => Right(response.toEntity()),
      );
    } else {
      return const Left(NetworkFailure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, BreakInEntity>> breakIn(BreakInRequest request) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.breakIn(request);
      return result.fold(
        (failure) => Left(failure),
        (response) => Right(response.toEntity()),
      );
    } else {
      return const Left(NetworkFailure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, BreakOutEntity>> breakOut(
    BreakOutRequest request,
  ) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.breakOut(request);
      return result.fold(
        (failure) => Left(failure),
        (response) => Right(response.toEntity()),
      );
    } else {
      return const Left(NetworkFailure('No Internet Connection'));
    }
  }
}
