class FaqEntity {
  final String faqId;
  final String question;
  final String answer;
  final String platform;
  final String categoryId;
  final String attachment;

  FaqEntity({
    required this.faqId,
    required this.question,
    required this.answer,
    required this.platform,
    required this.categoryId,
    required this.attachment,
  });
}

class CategoryEntity {
  final String categoryId;
  final String categoryName;

  CategoryEntity({required this.categoryId, required this.categoryName});
}

class AppSupportEntity {
  final List<FaqEntity> faqList;
  final List<CategoryEntity> categoryList;
  final String message;
  final String status;

  AppSupportEntity({
    required this.faqList,
    required this.categoryList,
    required this.message,
    required this.status,
  });
}
