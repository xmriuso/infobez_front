import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_web_project/feature/all_courses_page/widgets/course_element_widget.dart';

import 'bloc/all_courses_page_bloc.dart';

class AllCoursesPage extends StatefulWidget {
  const AllCoursesPage({super.key});

  @override
  State<AllCoursesPage> createState() => _AllCoursesPageState();
}

class _AllCoursesPageState extends State<AllCoursesPage> {
  @override
  void initState() {
    super.initState();
    context.read<AllCoursesPageBloc>().add(LoadAllCoursesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllCoursesPageBloc, AllCoursesPageState>(
      builder: (context, state) {
        return state is AllCoursesPageLoaded
            ? Padding(
                padding: EdgeInsets.all(30),
                child: GridView.count(
                  crossAxisCount: 4, // Количество колонок (4 в ряд)
                  crossAxisSpacing: 30, // Отступы между колонками
                  mainAxisSpacing: 30, // Отступы между рядами
                  children: List.generate(
                    state.allCourses?.length ?? 0,
                    (index) => CourseElementWidget(
                      imageUrl: state.allCourses?[index].imageUrl,
                    ),
                  ),
                ),
              )
            : Center(child: Text('Loading...'));
      },
    );
  }
}
