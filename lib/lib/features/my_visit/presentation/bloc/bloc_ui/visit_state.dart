part of 'visit_bloc.dart';

abstract class VisitState {}

class VisitInitial extends VisitState {}

class VisitLoading extends VisitState {}

class VisitLoaded extends VisitState {
  final CameraController? cameraController;
  final String dateTime;
  final String scanningState;
  final String remainingTime;
  final double progress;
  final List<Map<String, String>> branchTags;
  final List<Map<String, String>> departmentTags;
  final Map<String, String> AssignedBranch;
  final int selectedIndex;
  final DateTime selectedDate;
  final List<int> selectedEmployeeIndexes;
  final bool isButtonTapped;
  final String actionType;
  final bool ToggleAutoExpence;
  final String contactCode;
  final String contactId;
  final String alternativeCode;
  final String alternativeId;
  final String? cityName;
  final String? areaName;
  final String selectedVisitType;

  VisitLoaded({
    required this.dateTime,
    required this.scanningState,
    required this.remainingTime,
    required this.progress,
    this.cameraController,
    this.AssignedBranch = const {},
    this.branchTags = const [],
    this.departmentTags = const [],
    DateTime? selectedDate,
    this.selectedEmployeeIndexes = const [],
    this.isButtonTapped = false,
    this.actionType = '',
    this.contactCode = '+91',
    this.contactId = 'IND',
    this.alternativeCode = '+91',
    this.alternativeId = 'IND',
    this.cityName,
    this.areaName,
    this.selectedVisitType = 'Self Visit',
    this.ToggleAutoExpence = false,
    this.selectedIndex = 0,
  }) : selectedDate = selectedDate ?? DateTime.now();

  VisitLoaded copyWith({
    CameraController? cameraController,
    String? dateTime,
    String? scanningState,
    String? remainingTime,
    double? progress,
    Map<String, String>? AssignedBranch,
    List<Map<String, String>>? branchTags,
    List<int>? selectedBranchIds,
    List<Map<String, String>>? departmentTags,
    List<int>? selectedDepartmentIds,
    DateTime? selectedDate,
    List<int>? selectedEmployeeIndexes,
    bool? isButtonTapped,
    String? actionType,
    bool? ToggleAutoExpence,
    int? selectedIndex,
    String? contactCode,
    String? contactId,
    String? alternativeCode,
    String? alternativeId,
    String? cityName,
    String? areaName,
    String? selectedVisitType,
  }) => VisitLoaded(
    cameraController: cameraController ?? this.cameraController,
    dateTime: dateTime ?? this.dateTime,
    scanningState: scanningState ?? this.scanningState,
    remainingTime: remainingTime ?? this.remainingTime,
    progress: progress ?? this.progress,
    AssignedBranch: AssignedBranch ?? this.AssignedBranch,
    branchTags: branchTags ?? this.branchTags,
    departmentTags: departmentTags ?? this.departmentTags,
    selectedEmployeeIndexes:
        selectedEmployeeIndexes ?? this.selectedEmployeeIndexes,
    selectedDate: selectedDate ?? this.selectedDate,
    isButtonTapped: isButtonTapped ?? this.isButtonTapped,
    actionType: actionType ?? this.actionType,
    contactCode: contactCode ?? this.contactCode,
    contactId: contactId ?? this.contactId,
    alternativeCode: alternativeCode ?? this.alternativeCode,
    alternativeId: alternativeId ?? this.alternativeId,
    cityName: cityName ?? this.cityName,
    areaName: areaName ?? this.areaName,
    selectedVisitType: selectedVisitType ?? this.selectedVisitType,
    ToggleAutoExpence: ToggleAutoExpence ?? this.ToggleAutoExpence,
    selectedIndex: selectedIndex ?? this.selectedIndex,
  );
}

class VisitError extends VisitState {
  final String message;

  VisitError({required this.message});
}
