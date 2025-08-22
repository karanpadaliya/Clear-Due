// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_support_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppSupportResponseModel _$AppSupportResponseModelFromJson(
  Map<String, dynamic> json,
) => AppSupportResponseModel(
  faq:
      (json['faq'] as List<dynamic>?)
          ?.map((e) => Faq.fromJson(e as Map<String, dynamic>))
          .toList(),
  category:
      (json['category'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
  message: json['message'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$AppSupportResponseModelToJson(
  AppSupportResponseModel instance,
) => <String, dynamic>{
  'faq': instance.faq,
  'category': instance.category,
  'message': instance.message,
  'status': instance.status,
};

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  categoryId: json['category_id'] as String?,
  categoryName: json['category_name'] as String?,
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'category_id': instance.categoryId,
  'category_name': instance.categoryName,
};

Faq _$FaqFromJson(Map<String, dynamic> json) => Faq(
  faqId: json['faq_id'] as String?,
  question: json['question'] as String?,
  answer: json['answer'] as String?,
  platform: json['platform'] as String?,
  categoryId: json['category_id'] as String?,
  attachment: json['attachment'] as String?,
);

Map<String, dynamic> _$FaqToJson(Faq instance) => <String, dynamic>{
  'faq_id': instance.faqId,
  'question': instance.question,
  'answer': instance.answer,
  'platform': instance.platform,
  'category_id': instance.categoryId,
  'attachment': instance.attachment,
};
