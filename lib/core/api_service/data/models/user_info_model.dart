import '../../domain/entities/user_info_entity.dart';

class UserInfoModel extends UserInfoEntity {
  @override
  final String? name;
  @override
  final String? email;
  @override
  final int? id;
  @override
  final int? age;
  @override
  final int? sex;
  @override
  final String? role;
  @override
  final DateTime? createdAt;
  @override
  final FeaturedImageModel? featuredImage;

  const UserInfoModel({
    this.name,
    this.email,
    this.id,
    this.age,
    this.sex,
    this.role,
    this.createdAt,
    this.featuredImage,
  }) : super(
          name: name,
          email: email,
          id: id,
          age: age,
          sex: sex,
          role: role,
          createdAt: createdAt,
          featuredImage: featuredImage,
        );

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      id: json['id'] as int?,
      age: json['age'] as int?,
      sex: json['sex'] as int?,
      role: json['role'] as String?,
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
      "name": name,
      "email": email,
      "id": id,
      "age": age,
      "sex": sex,
      "role": role,
      "created_at": createdAt?.toIso8601String(),
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
