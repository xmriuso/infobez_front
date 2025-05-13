import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../all_courses_page/widgets/course_element_widget.dart';
import '../../app/routing/route_path.dart';
import '../../detail_course_page/bloc/detail_course_page_bloc.dart';
import '../bloc/favourites_courses_page_bloc.dart';

class FavoritesManager {
  static final List<Map<String, String>> favoriteCourses = [];

  static void toggleFavorite(
      String title, String description, String imageUrl) {
    // final existingIndex = favoriteCourses.indexWhere((course) => course['title'] == title);
    // if (existingIndex >= 0) {
    //   favoriteCourses.removeAt(existingIndex);
    // } else {
    //   favoriteCourses.add({'title': title, 'description': description, 'imageUrl': imageUrl});
    // }
  }
}

class FavouritesCoursesPage extends StatefulWidget {
  const FavouritesCoursesPage({super.key});

  @override
  _FavouritesCoursesPageState createState() => _FavouritesCoursesPageState();
}

class _FavouritesCoursesPageState extends State<FavouritesCoursesPage> {
  static double itemWidth = 250;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: BlocConsumer<FavouritesCoursesPageBloc, FavouritesCoursesPageState>(
        listenWhen: (lastContext, context) {
          // if (lastContext is FavouritesCoursesLoadedState &&
          //     context is FavouritesCoursesLoadedState) {
          //   if (lastContext.favouriteCourses != context.favouriteCourses)
          //     return true;
          // }
          return lastContext is! FavouritesCoursesLoadedState;
        },
        listener: (context, state) {
          context
              .read<FavouritesCoursesPageBloc>()
              .add(LoadFavouriteCoursesImagesEvent());
        },
        builder: (context, state) {
          final width = MediaQuery.of(context).size.width;

          if (state is FavouritesCoursesLoadedState) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: GridView.count(
                crossAxisCount: width ~/ itemWidth,
                crossAxisSpacing: 20,
                mainAxisSpacing: 30,
                children: List.generate(
                  state.favouriteCourses.length,
                  (index) {
                    final course = state.favouriteCourses[index];
                    return SizedBox(
                      height: 200,
                      child: CourseElementWidget(
                        courseId: course.id,
                        imageUrl: state.imagesFiles[index],
                        title: '',
                        description: '',
                        onTap: () {
                          if (state.favouriteCourses[index].id != null) {
                            context.goNamed(
                              RoutePath.favouriteDetailCoursePage,
                              pathParameters: {
                                'courseId':
                                    '${state.favouriteCourses[index].id!}',
                              },
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
