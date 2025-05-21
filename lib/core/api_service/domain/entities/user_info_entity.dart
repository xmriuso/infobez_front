import 'package:equatable/equatable.dart';

class UserInfoEntity extends Equatable {
  final String? name;
  final String? email;
  final int? id;
  final int? age;
  final int? sex;
  final String? role;
  final DateTime? createdAt;
  final FeaturedImageEntity? featuredImage;

  const UserInfoEntity({
    required this.name,
    required this.email,
    required this.id,
    required this.age,
    required this.sex,
    required this.role,
    required this.createdAt,
    required this.featuredImage,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        id,
        age,
        sex,
        role,
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
