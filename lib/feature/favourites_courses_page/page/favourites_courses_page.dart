import 'package:flutter/material.dart';

class FavoritesManager {
  static final List<Map<String, String>> favoriteCourses = [];

  static void toggleFavorite(String title, String description, String imageUrl) {
    final existingIndex = favoriteCourses.indexWhere((course) => course['title'] == title);
    if (existingIndex >= 0) {
      favoriteCourses.removeAt(existingIndex);
    } else {
      favoriteCourses.add({'title': title, 'description': description, 'imageUrl': imageUrl});
    }
  }
}

class FavouritesCoursesPage extends StatefulWidget {
  const FavouritesCoursesPage({super.key});

  @override
  _FavouritesCoursesPageState createState() => _FavouritesCoursesPageState();
}

class _FavouritesCoursesPageState extends State<FavouritesCoursesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: ListView.builder(
        itemCount: FavoritesManager.favoriteCourses.length,
        itemBuilder: (context, index) {
          final course = FavoritesManager.favoriteCourses[index];
          return ListTile(
            leading: Image.network(course['imageUrl']!, width: 50, height: 50, fit: BoxFit.cover),
            title: Text(course['title']!),
            subtitle: Text(course['description']!),
          );
        },
      ),
    );
  }
}