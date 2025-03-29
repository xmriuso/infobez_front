import 'package:equatable/equatable.dart';

class DetailCourseEntity extends Equatable {
  final int? id;
  final int? creatorId;
  final String? title;
  final String? description;
  final DateTime? createdAt;
  final FeaturedImageEntity? featuredImage;

  const DetailCourseEntity({
    required this.id,
    required this.creatorId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.featuredImage,
  });

  @override
  List<Object?> get props => [
        id,
        creatorId,
        title,
        description,
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
