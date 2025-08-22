// To parse this JSON data, do
//
//     final appSupportResponseModel = appSupportResponseModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:myco_flutter/features/my_profile/domain/entites/app_support_entity.dart';

part 'app_support_response_model.g.dart';

AppSupportResponseModel appSupportResponseModelFromJson(String str) =>
    AppSupportResponseModel.fromJson(json.decode(str));

String appSupportResponseModelToJson(AppSupportResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class AppSupportResponseModel {
  @JsonKey(name: "faq")
  List<Faq>? faq;
  @JsonKey(name: "category")
  List<Category>? category;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "status")
  String? status;

  AppSupportResponseModel({this.faq, this.category, this.message, this.status});

  factory AppSupportResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AppSupportResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppSupportResponseModelToJson(this);
}

@JsonSerializable()
class Category {
  @JsonKey(name: "category_id")
  String? categoryId;
  @JsonKey(name: "category_name")
  String? categoryName;

  Category({this.categoryId, this.categoryName});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Faq {
  @JsonKey(name: "faq_id")
  String? faqId;
  @JsonKey(name: "question")
  String? question;
  @JsonKey(name: "answer")
  String? answer;
  @JsonKey(name: "platform")
  String? platform;
  @JsonKey(name: "category_id")
  String? categoryId;
  @JsonKey(name: "attachment")
  String? attachment;

  Faq({
    this.faqId,
    this.question,
    this.answer,
    this.platform,
    this.categoryId,
    this.attachment,
  });

  factory Faq.fromJson(Map<String, dynamic> json) => _$FaqFromJson(json);

  Map<String, dynamic> toJson() => _$FaqToJson(this);
}

extension AppSupportResponseModelMapper on AppSupportResponseModel {
  AppSupportEntity toEntity() => AppSupportEntity(
    faqList: faq?.map((e) => e.toEntity()).toList() ?? [],
    categoryList: category?.map((e) => e.toEntity()).toList() ?? [],
    message: message ?? '',
    status: status ?? '',
  );
}

extension CategoryMapper on Category {
  CategoryEntity toEntity() => CategoryEntity(
    categoryId: categoryId ?? '',
    categoryName: categoryName ?? '',
  );
}

extension FaqMapper on Faq {
  FaqEntity toEntity() => FaqEntity(
    faqId: faqId ?? '',
    question: question ?? '',
    answer: answer ?? '',
    platform: platform ?? '',
    categoryId: categoryId ?? '',
    attachment: attachment ?? '',
  );
}
