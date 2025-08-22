import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/core/services/hive_cache_service.dart'; // Keep this import
import 'package:myco_flutter/features/employees/data/datasources/employees_remote_data_source.dart';
import 'package:myco_flutter/features/employees/data/models/branch_model/branch_model.dart';
import 'package:myco_flutter/features/employees/data/models/department_model/department_model.dart';
import 'package:myco_flutter/features/employees/data/models/employee_model/employee_model.dart';

class EmployeeRemoteDataSourceImpl implements EmployeeRemoteDataSource {
  final ApiClient _apiClient;
  // Use the concrete type HiveCacheService here
  final HiveCacheService _hiveCacheService = GetIt.I<HiveCacheService>();

  // Define constants for the Hive box name and cache key
  static const String _employeeBoxName = 'employeeBox';
  static const String _employeeCacheKey = 'employeeResponse';

  EmployeeRemoteDataSourceImpl(this._apiClient);

  Future<Map<String, dynamic>> _postAll({
    required String userId,
    required String companyId,
    String? branchId,
    String? departmentId,
  }) async {
    // Try to load from cache using HiveCacheService
    final cachedJsonString = await _hiveCacheService.get<String>(_employeeBoxName, _employeeCacheKey);
    if (cachedJsonString != null && cachedJsonString.isNotEmpty) {
      final cachedMap = json.decode(cachedJsonString);
      print('🗂️ Loaded employee data from cache.');
      _logJsonSize(cachedJsonString, from: '📂 Cache');
      return cachedMap;
    }

    final requestMap = {
      'getEmployees': 'getEmployees',
      'language_id': '1',
      'user_id': userId,
      'society_id': companyId,
      if (branchId != null) 'block_id': branchId,
      if (departmentId != null) 'floor_id': departmentId,
    };

    final response = await _apiClient.postFormDynamic(
      'employee_controller.php',
      requestMap,
    );

    final decoded = response is String ? json.decode(response) : response;
    final jsonString = jsonEncode(decoded);

    print('📦 API RAW RESPONSE: $jsonString');

    // Save to cache using HiveCacheService
    await _hiveCacheService.put<String>(_employeeBoxName, _employeeCacheKey, jsonString);

    _logJsonSize(jsonString, from: '🛰️ API');

    return decoded;
  }

  void _logJsonSize(String jsonString, {String from = ''}) {
    final bytes = utf8.encode(jsonString);
    final sizeInBytes = bytes.length;
    final sizeInKB = sizeInBytes / 1024;
    final sizeInMB = sizeInKB / 1024;

    print(
      '$from 📏 JSON Size: $sizeInBytes bytes | ${sizeInKB.toStringAsFixed(2)} KB | ${sizeInMB.toStringAsFixed(4)} MB',
    );
  }

  @override
  Future<List<BranchModel>> fetchBranches(
      String userId,
      String companyId,
      ) async {
    final data = await _postAll(userId: userId, companyId: companyId);
    final list = data['branch_list'] as List<dynamic>? ?? [];
    return list.map((e) => BranchModel.fromJson(e)).toList();
  }

  @override
  Future<List<DepartmentModel>> fetchDepartments(
      String userId,
      String companyId,
      ) async {
    final data = await _postAll(userId: userId, companyId: companyId);
    final list = data['departments'] as List<dynamic>? ?? [];
    return list.map((e) => DepartmentModel.fromJson(e)).toList();
  }

  @override
  Future<List<EmployeeModel>> fetchEmployees({
    required String userId,
    required String companyId,
    String? branchId,
    String? departmentId,
  }) async {
    final data = await _postAll(
      userId: userId,
      companyId: companyId,
      branchId: branchId,
      departmentId: departmentId,
    );
    final list = data['employees'] as List<dynamic>? ?? [];
    return list.map((e) => EmployeeModel.fromJson(e)).toList();
  }

  @override
  Future<void> clearCachedEmployeeData() async {
    await _hiveCacheService.delete(_employeeBoxName, _employeeCacheKey);
  }
}