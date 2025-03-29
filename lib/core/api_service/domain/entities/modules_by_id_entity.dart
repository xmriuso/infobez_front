import 'package:equatable/equatable.dart';

class AllLessonsEntity extends Equatable {
  final List<LessonEntity>? data;
  final PaginationEntity? pagination;

  const AllLessonsEntity({
    required this.data,
    required this.pagination,
  });

  @override
  List<Object?> get props => [data, pagination];
}

class LessonEntity extends Equatable {
  final int? id;
  final int? courseId;
  final String? title;
  final String? description;
  final String? videoUrl;
  final DateTime? createdAt;
  final FeaturedImageEntity? featuredImage;

  const LessonEntity({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.createdAt,
    required this.featuredImage,
  });

  @override
  List<Object?> get props => [
        id,
        courseId,
        title,
        description,
        videoUrl,
        createdAt,
        featuredImage,
      ];
}

class FeaturedImageEntity extends Equatable {
  final String? original;
  final String? small;

  const FeaturedImageEntity({
    required this.original,
    required this.small,
  });

  @override
  List<Object?> get props => [original, small];
}

class PaginationEntity extends Equatable {
  final int? currentPage;
  final int? totalPages;
  final int? totalElements;

  const PaginationEntity({
    required this.currentPage,
    required this.totalPages,
    required this.totalElements,
  });

  @override
  List<Object?> get props => [currentPage, totalPages, totalElements];
}
