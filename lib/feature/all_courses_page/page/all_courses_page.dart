import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_web_project/feature/all_courses_page/widgets/course_element_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllCoursesPageBloc, AllCoursesPageState>(
      builder: (context, state) {
        return GridView.count(
          crossAxisCount: 4, // Количество колонок (4 в ряд)
          crossAxisSpacing: 30, // Отступы между колонками
          mainAxisSpacing: 30, // Отступы между рядами
          children: List.generate(
            60,
            (index) => CourseElementWidget(
              imageUrl:
                  'https://sun9-56.userapi.com/s/v1/if1/ckE_uGxsdilADkg6PhXSDEz085PkwaybhjnY7-ImthF1P8c1f0Xf05RM0gMzCYykSM1kOeZ4.jpg?quality=96&as=32x18,48x27,72x40,108x61,160x90,240x135,360x202,480x270,540x304,640x360,720x405,1080x607,1280x720,1440x810,1600x900&from=bu&u=IKBz0svfrhEd8FUISYfVekg2XFYJjaBY5zPcDcszsF4&cs=604x340',
            ),
          ),
        );
      },
    );
  }
}
