class PastExperienceEntity {
  final List<ExperienceItemEntity>? experience;
  final String? message;
  final String? status;

  PastExperienceEntity({
    this.experience,
    this.message,
    this.status,
  });
}

class ExperienceItemEntity {
  final String? employeeExperienceId;
  final String? designation;
  final String? workFrom;
  final String? companyLocation;
  final String? expCompanyName;

  ExperienceItemEntity({
    this.employeeExperienceId,
    this.designation,
    this.workFrom,
    this.companyLocation,
    this.expCompanyName,
  });
}
