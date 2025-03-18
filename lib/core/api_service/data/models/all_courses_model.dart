import '../../domain/entities/all_courses_entity.dart';

class AllCoursesModel extends AllCoursesEntity {
  @override
  final List<CourseModel>? data;
  @override
  final PaginationModel? pagination;

  const AllCoursesModel({
    required this.data,
    required this.pagination,
  }) : super(
          data: data,
          pagination: pagination,
        );

  /// Фабричный метод для создания объекта из JSON
  factory AllCoursesModel.fromJson(Map<String, dynamic> json) {
    return AllCoursesModel(
      data: (json['data'] as List<dynamic>)
          .map((item) => CourseModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      pagination:
          PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }

  /// Метод для преобразования объекта в JSON
  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((course) => course.toJson()).toList(),
      'pagination': pagination?.toJson(),
    };
  }
}

class CourseModel extends CourseEntity {
  @override
  final FeaturedImageModel? featuredImage;

  const CourseModel({
    super.id,
    super.creatorId,
    super.title,
    super.description,
    this.featuredImage,
    super.createdAt,
  }) : super(
          featuredImage: featuredImage,
        );

  /// Фабричный метод для создания объекта из JSON
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as int?,
      creatorId: json['creatorId'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      featuredImage: FeaturedImageModel.fromJson(
          json['featuredImage'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  /// Метод для преобразования объекта в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creatorId': creatorId,
      'title': title,
      'description': description,
      'featuredImage': featuredImage?.toJson(),
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}

class FeaturedImageModel extends FeaturedImageEntity {
  const FeaturedImageModel({
    super.original,
    super.small,
  });

  /// Фабричный метод для создания объекта из JSON
  factory FeaturedImageModel.fromJson(Map<String, dynamic> json) {
    return FeaturedImageModel(
      original: json['original'] as String?,
      small: json['small'] as String?,
    );
  }

  /// Метод для преобразования объекта в JSON
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

  /// Фабричный метод для создания объекта из JSON
  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['currentPage'] as int?,
      totalPages: json['totalPages'] as int?,
      totalElements: json['totalElements'] as int?,
    );
  }

  /// Метод для преобразования объекта в JSON
  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'totalPages': totalPages,
      'totalElements': totalElements,
    };
  }
}
