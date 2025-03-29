import 'package:test_web_project/core/api_service/domain/entities/detail_course_entity.dart';

class DetailCourseModel extends DetailCourseEntity {
  @override
  final int? id;
  @override
  final int? creatorId;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final DateTime? createdAt;
  @override
  final FeaturedImageModel? featuredImage;

  const DetailCourseModel({
    this.id,
    this.creatorId,
    this.title,
    this.description,
    this.createdAt,
    this.featuredImage,
  }) : super(
          id: id,
          creatorId: creatorId,
          title: title,
          description: description,
          createdAt: createdAt,
          featuredImage: featuredImage,
        );

  factory DetailCourseModel.fromJson(Map<String, dynamic> json) {
    return DetailCourseModel(
      id: json['id'] as int?,
      creatorId: json['creator_id'] as int?, // 👈 Используем snake_case как в JSON
      title: json['title'] as String?,
      description: json['description'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      featuredImage: json['featuredImage'] != null
          ? FeaturedImageModel.fromJson(json['featuredImage'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creator_id': creatorId,
      'title': title,
      'description': description,
      'created_at': createdAt?.toIso8601String(),
      'featuredImage': featuredImage?.toJson(),
    };
  }
}

class FeaturedImageModel extends FeaturedImageEntity {
  const FeaturedImageModel({
    super.original,
    super.small,
  });

  factory FeaturedImageModel.fromJson(Map<String, dynamic> json) {
    return FeaturedImageModel(
      original: json['original'] as String?,
      small: json['small'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'original': original,
      'small': small,
    };
  }
}
