import 'dart:convert';

class AllCoursesModel {
  final int id;
  final int creator;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime createdAt;

  AllCoursesModel({
    required this.id,
    required this.creator,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
  });

  /// Фабричный метод для создания объекта из JSON
  factory AllCoursesModel.fromJson(Map<String, dynamic> json) {
    return AllCoursesModel(
      id: json['ID'] as int,
      creator: json['Creator'] as int,
      title: json['Title'] as String,
      description: json['Description'] as String,
      imageUrl: json['Image_URL'] as String,
      createdAt: DateTime.parse(json['Created_at'] as String),
    );
  }

  /// Метод для преобразования объекта в JSON
  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Creator': creator,
      'Title': title,
      'Description': description,
      'Image_URL': imageUrl,
      'Created_at': createdAt.toIso8601String(),
    };
  }

  /// Фабричный метод для создания списка объектов из JSON-массива
  static List<AllCoursesModel> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => AllCoursesModel.fromJson(json)).toList();
  }
}