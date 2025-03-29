import 'package:test_web_project/core/api_service/domain/entities/modules_by_id_entity.dart';

class AllLessonsModel extends AllLessonsEntity {
  @override
  final List<LessonModel>? data;
  @override
  final PaginationModel? pagination;

  const AllLessonsModel({
    required this.data,
    required this.pagination,
  }) : super(
          data: data,
          pagination: pagination,
        );

  factory AllLessonsModel.fromJson(Map<String, dynamic> json) {
    return AllLessonsModel(
      data: (json['data'] as List<dynamic>)
          .map((item) => LessonModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      pagination: PaginationModel.fromJson(
          json['pagination'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((lesson) => lesson.toJson()).toList(),
      'pagination': pagination?.toJson(),
    };
  }
}

class LessonModel extends LessonEntity {
  @override
  final int? id;
  @override
  final int? courseId;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? videoUrl;
  @override
  final DateTime? createdAt;
  @override
  final FeaturedImageModel? featuredImage;

  const LessonModel({
    this.id,
    this.courseId,
    this.title,
    this.description,
    this.videoUrl,
    this.createdAt,
    this.featuredImage,
  }) : super(
          id: id,
          courseId: courseId,
          title: title,
          description: description,
          videoUrl: videoUrl,
          createdAt: createdAt,
          featuredImage: featuredImage,
        );

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] as int?,
      courseId: json['course_id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      videoUrl: json['video_URL'] as String?,
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
      'course_id': courseId,
      'title': title,
      'description': description,
      'video_URL': videoUrl,
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

class PaginationModel extends PaginationEntity {
  const PaginationModel({
    super.currentPage,
    super.totalPages,
    super.totalElements,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['current_page'] as int?,
      totalPages: json['total_pages'] as int?,
      totalElements: json['total_elements'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'total_pages': totalPages,
      'total_elements': totalElements,
    };
  }
}
