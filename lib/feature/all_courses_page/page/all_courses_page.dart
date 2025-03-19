import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_web_project/feature/all_courses_page/widgets/course_element_widget.dart';
import 'package:test_web_project/feature/app/routing/route_path.dart';

import '../bloc/all_courses_page_bloc.dart';

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

  final String imageUrl =
      'https://i.pinimg.com/originals/e7/10/3c/e7103c871cb38f0d5bf00027ea43871d.jpg';

  final String title = 'Курс';

  final String description = 'Описание курса';

  static double itemWidth = 250;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllCoursesPageBloc, AllCoursesPageState>(
      builder: (context, state) {
        final width = MediaQuery.of(context).size.width;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: GridView.count(
            crossAxisCount: width ~/ itemWidth,
            crossAxisSpacing: 20,
            mainAxisSpacing: 30,
            children: List.generate(
              60,
              (index) {
                return SizedBox(
                  height: 200,
                  child: CourseElementWidget(
                    imageUrl: imageUrl,
                    title: '$title ${index + 1}',
                    description: '$description ${index + 1}',
                    onTap: () {
                      context.goNamed(RoutePath.detailCoursePage);
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
