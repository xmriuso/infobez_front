import 'package:equatable/equatable.dart';

class AllCoursesEntity extends Equatable {
  final List<CourseEntity>? data;
  final PaginationEntity? pagination;

  const AllCoursesEntity({
    required this.data,
    required this.pagination,
  });

  @override
  List<Object?> get props => [data, pagination];
}

class CourseEntity extends Equatable {
  final int? id;
  final int? creatorId;
  final String? title;
  final String? description;
  final FeaturedImageEntity? featuredImage;
  final DateTime? createdAt;

  const CourseEntity({
    required this.id,
    required this.creatorId,
    required this.title,
    required this.description,
    required this.featuredImage,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    creatorId,
    title,
    description,
    featuredImage,
    createdAt,
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
