import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static const String companyName = 'company_name';
  static const String companyId = 'company_id';
  static const String countryId = 'country_id';
  static const String stateId = 'state_id';
  static const String cityId = 'city_id';
  static const String companyAddress = 'company_address';
  static const String baseUrl = 'base_url';
  static const String appLanguage = 'lang_app';
  static const String languageId = 'lang_id';
  static const String userId = 'user_id';
  static const String shiftTimeId = 'shift_time_id';
  static const String unitId = 'unit_id';
  static const String unitName = 'unit_name';
  static const String menuChat = 'menu_chat';
  static const String branchId = 'branch_id';
  static const String zoneId = 'zone_id';
  static const String levelId = 'level_id';
  static const String branchName = 'branch_id';
  static const String departmentId = 'department_id';
  static const String departmentName = 'department_name';
  static const String userName = 'user_name';
  static const String mobileNo = 'mobile_no';
  static const String registrationRequestPendingUserId =
      'registration_request_pending_user_id';
  static const String subEnd = 'employeeMobileApi/';
  static const String residentApiEnd = 'residentApiNew/';
  static const String mainKey = 'bmsapikey';
  static const String mainURL = 'https://master.my-company.app/mainApiEnc/';
  static const String masterAPICall = 'masterAPICall';
  static const String employeeMobileApi = 'employeeMobileApi';
  static const String residentApiNew = 'residentApiNew';
  static const String cachedEmployeeResponse = 'cached_employee_response';
  static const String designation = 'designation';
  static const String labelMemberType = 'label_member_type';
  static const String labelSettingApartment = 'label_setting_apartment';
  static const String labelSettingResident = 'label_setting_resident';
  static const String memberStatus = 'member_status';
  static const String gender = 'gender';
  static const String userType = 'user_type';
  static const String memberDateOfBirth = 'member_date_of_birth';
  static const String weddingAnniversaryDate = 'wedding_anniversaryD_date';
  static const String userProfilePic = 'user_profile_pic';
  static const String userFirstName = 'user_first_name';
  static const String userLastName = 'user_last_name';
  static const String userFullName = 'user_full_name';
  static const String userEmail = 'user_email';
  static const String bloodGroup = 'blood_group';
  static const String altMobile = 'alt_mobile';
  static const String countryCode = 'country_code';
  static const String countryCodeAlt = 'country_code_alt';
  static const String publicMobile = 'public_mobile';
  static const String plotLatitude = 'plot_latitude';
  static const String plotLongitude = 'plot_longitude';
  static const String isExpenseON = 'is_expense_on';
  static const String maxExpenseAmount = 'max_expense_amount';
  static const String stateIdEmployee = 'state_id_employee';
  static const String unitStatus = 'unit_status';
  static const String facebook = 'facebook';
  static const String instagram = 'instagram';
  static const String linkedin = 'linkedin';
  static const String punchInDate = 'punchInDate';

  static final PreferenceManager _instance = PreferenceManager._internal();

  factory PreferenceManager() => _instance;

  PreferenceManager._internal();

  Future<void> clearSecureStorageOnFreshInstall() async {
    final prefs = await SharedPreferences.getInstance();
    const installFlag = 'hasInstalled';

    final hasInstalled = prefs.getBool(installFlag) ?? false;

    if (!hasInstalled) {
      await prefs.clear(); // 🧹 Clear all stored preferences
      await prefs.setBool(installFlag, true);
    }
  }

  // ====== String ======
  Future<void> writeString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> readString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // ====== Int ======
  Future<void> writeInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  Future<int?> readInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  // ====== Double ======
  Future<void> writeDouble(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value);
  }

  Future<double?> readDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  // ====== Bool ======
  Future<void> writeBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<bool?> readBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  // ====== Object ======
  Future<void> writeObject<T>(
    String key,
    T object,
    Map<String, dynamic> Function(T) toJson,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(toJson(object));
    await prefs.setString(key, jsonString);
  }

  Future<T?> readObject<T>(
    String key,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString == null) return null;
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return fromJson(jsonMap);
  }

  // ====== Delete / Clear ======
  Future<void> delete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> setKeyValueString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // Get string value
  Future<String> getKeyValueString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  // Set boolean value
  Future<void> setKeyValueBoolean(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Get boolean value
  Future<bool> getKeyValueBoolean(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false; // default to false if null
  }

  // ====== Custom Methods ======

  Future<void> setUserId(String value) async {
    await writeString(userId, value);
  }

  //TODO: Dummy static return for now
  Future<String?> getUserId() => readString(userId);

  Future<void> setUnitId(String value) async {
    await writeString(unitId, value);
  }

  Future<String?> getShiftTimeId() => readString(shiftTimeId);

  Future<void> setShiftTimeId(String value) async {
    await writeString(shiftTimeId, value);
  }

  //TODO: Dummy static return for now
  Future<String?> getUnitId() => readString(unitId);

  Future<void> setUnitName(String value) async {
    await writeString(unitName, value);
  }

  Future<String?> getUnitName() => readString(unitName);

  Future<void> setDepartmentId(String value) async {
    await writeString(departmentId, value);
  }

  //TODO: Dummy static return for now
  Future<String?> getDepartmentId() => readString(departmentId);

  Future<void> setDepartmentName(String value) async {
    await writeString(departmentName, value);
  }

  Future<String?> getDepartmentName() => readString(departmentName);

  Future<void> setUserName(String value) async {
    await writeString(userName, value);
  }

  //TODO: Dummy static return for now
  Future<String?> getUserName() => readString(userName);

  Future<void> setUserMobileNo(String value) async {
    await writeString(mobileNo, value);
  }

  Future<String?> getUserMobileNo() => readString(mobileNo);

  Future<void> setLanguageId(String value) async {
    await writeString(languageId, value);
  }

  Future<String?> getLanguageId() => readString(languageId);

  Future<void> setCompanyId(String value) async {
    await writeString(companyId, value);
  }

  Future<String?> getCompanyId() => readString(companyId);

  Future<void> setCountryId(String value) async {
    await writeString(countryId, '101');
  }

  Future<String?> getCountryId() => readString(countryId);

  Future<void> setBranchName(String value) async {
    await writeString(branchName, value);
  }

  Future<String?> getBranchName() => readString(branchName);

  Future<void> setStateId(String value) async {
    await writeString(stateId, '1');
  }

  Future<String?> getStateId() => readString(stateId);

  Future<void> setCityId(String value) async {
    await writeString(cityId, '1');
  }

  Future<String?> getCityId() => readString(cityId);

  Future<void> setDesignation(String value) async {
    await writeString(designation, value);
  }

  Future<String?> getDesignation() => readString(designation);

  Future<void> setLabelMemberType(String value) async {
    await writeString(labelMemberType, value);
  }

  Future<String?> getLabelMemberType() => readString(labelMemberType);

  Future<void> setLabelSettingApartment(String value) async {
    await writeString(labelSettingApartment, value);
  }

  Future<String?> getLabelSettingApartment() =>
      readString(labelSettingApartment);

  Future<void> setLabelSettingResident(String value) async {
    await writeString(labelSettingResident, value);
  }

  Future<String?> getLabelSettingResident() => readString(labelSettingResident);

  Future<void> setMemberStatus(String value) async {
    await writeString(memberStatus, value);
  }

  Future<String?> getMemberStatus() => readString(memberStatus);

  Future<void> setGender(String value) async {
    await writeString(gender, value);
  }

  Future<String?> getGender() => readString(gender);

  Future<void> setUserType(String value) async {
    await writeString(userType, value);
  }

  Future<String?> getUserType() => readString(userType);

  Future<void> setMenuChat(bool value) async {
    await writeBool(menuChat, value);
  }

  Future<bool?> getMenuChat() => readBool(menuChat);

  Future<void> setMemberDateOfBirth(String value) async {
    await writeString(memberDateOfBirth, value);
  }

  Future<String?> getMemberDateOfBirth() => readString(memberDateOfBirth);

  Future<void> setWeddingAnniversaryDate(String value) async {
    await writeString(weddingAnniversaryDate, value);
  }

  Future<String?> getWeddingAnniversaryDate() =>
      readString(weddingAnniversaryDate);

  Future<void> setUserProfilePic(String value) async {
    await writeString(userProfilePic, value);
  }

  Future<String?> getUserProfilePic() => readString(userProfilePic);

  Future<void> setUserFirstName(String value) async {
    await writeString(userFirstName, value);
  }

  Future<String?> getUserFirstName() => readString(userFirstName);

  Future<void> setUserLastName(String value) async {
    await writeString(userLastName, value);
  }

  Future<String?> getUserLastName() => readString(userLastName);

  Future<void> setUserFullName(String value) async {
    await writeString(userFullName, value);
  }

  Future<String?> getUserFullName() => readString(userFullName);

  Future<void> setUserEmail(String value) async {
    await writeString(userEmail, value);
  }

  Future<String?> getUserEmail() => readString(userEmail);

  Future<void> setBloodGroup(String value) async {
    await writeString(bloodGroup, value);
  }

  Future<String?> getBloodGroup() => readString(bloodGroup);

  Future<void> setAltMobile(String value) async {
    await writeString(altMobile, value);
  }

  Future<String?> getAltMobile() => readString(altMobile);

  Future<void> setCountryCode(String value) async {
    await writeString(countryCode, value);
  }

  Future<String?> getCountryCode() => readString(countryCode);

  Future<void> setCountryCodeAlt(String value) async {
    await writeString(countryCodeAlt, value);
  }

  Future<String?> getCountryCodeAlt() => readString(countryCodeAlt);

  Future<void> setPublicMobile(String value) async {
    await writeString(publicMobile, value);
  }

  Future<String?> getPublicMobile() => readString(publicMobile);

  Future<void> setPlotLatitude(String value) async {
    await writeString(plotLatitude, value);
  }

  Future<String?> getPlotLatitude() => readString(plotLatitude);

  Future<void> setPlotLongitude(String value) async {
    await writeString(plotLongitude, value);
  }

  Future<String?> getPlotLongitude() => readString(plotLongitude);

  Future<void> setIsExpenseON(bool value) async {
    await writeBool(isExpenseON, value);
  }

  Future<bool?> getIsExpenseON() => readBool(isExpenseON);

  Future<void> setMaxExpenseAmount(String value) async {
    await writeString(maxExpenseAmount, value);
  }

  Future<String?> getMaxExpenseAmount() => readString(maxExpenseAmount);

  Future<void> setStateIdEmployee(String value) async {
    await writeString(stateIdEmployee, value);
  }

  Future<String?> getStateIdEmployee() => readString(stateIdEmployee);

  Future<void> setUnitStatus(String value) async {
    await writeString(unitStatus, value);
  }

  Future<String?> getUnitStatus() => readString(unitStatus);

  Future<void> setFacebook(String value) async {
    await writeString(facebook, value);
  }

  Future<String?> getFacebook() => readString(facebook);

  Future<void> setInstagram(String value) async {
    await writeString(instagram, value);
  }

  Future<String?> getInstagram() => readString(instagram);

  Future<void> setLinkedin(String value) async {
    await writeString(linkedin, value);
  }

  Future<String?> getLinkedin() => readString(linkedin);

  Future<void> setCompanyName(String value) async {
    await writeString(companyName, value);
  }

  Future<String?> getCompanyName() => readString(companyName);

  Future<void> setCompanyAddress(String value) async {
    await writeString(companyAddress, value);
  }

  Future<String?> getCompanyAddress() => readString(companyAddress);

  Future<void> setBaseUrl(String value) async {
    await writeString(baseUrl, value);
  }

  Future<String?> getBaseUrl() => readString(baseUrl);

  Future<void> setAppLanguage(String value) async {
    await writeString(appLanguage, value);
  }

  Future<String?> getAppLanguage() => readString(appLanguage);

  Future<String?> getBranchId() => readString(branchId);

  Future<void> setBranchId(String value) async {
    await writeString(branchId, '0');
  }

  Future<void> setZoneId(String value) async {
    await writeString(zoneId, value);
  }

  Future<String?> getZoneId() => readString(zoneId);

  Future<void> setLevelId(String value) async {
    await writeString(levelId, value);
  }

  Future<String?> getLevelId() => readString(levelId);

  /// Save API key
  Future<void> setApiKey(String wiFiSession) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('key', wiFiSession);
  }

  /// Get API key
  Future<String> getApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('key') ?? '0';
  }

  // Future<Society?> getSelectedCompany() async {
  //   final jsonString = await readString('selectedCompany');
  //   if (jsonString == null) return null;
  //   final json = jsonDecode(jsonString);
  //   return Society.fromJson(json);
  // }

  // ====== Employee Methods ======
  Future<void> setCachedEmployeeResponse(String json) =>
      writeString(cachedEmployeeResponse, json);

  Future<String?> getCachedEmployeeResponse() =>
      readString(cachedEmployeeResponse);

  Future<void> clearCachedEmployeeResponse() => delete(cachedEmployeeResponse);

  Future<void> setLoginSession(bool value) async {
    await writeBool('loginSession', value);
  }

  Future<bool?> getLoginSession() => readBool('loginSession');

  Future<void> setPunchInDate(String value) async {
    await writeString(punchInDate, value);
  }

  Future<String?> getPunchInDate() => readString(punchInDate);
}
