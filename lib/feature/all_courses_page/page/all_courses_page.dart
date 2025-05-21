import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_web_project/feature/all_courses_page/widgets/course_element_widget.dart';
import 'package:test_web_project/feature/app/routing/route_path.dart';
import 'package:test_web_project/feature/detail_course_page/bloc/detail_course_page_bloc.dart';

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
      'https://s3-alpha-sig.figma.com/img/dc74/8edd/3fd2beaa0bdb4230ca842308835f8cfb?Expires=1743379200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=fQ-e8SA9WvZhhwQE8zkrqofBW3AYmFCrOg89OYBFUm39XPXH9RlcJtV3TX7owRH982icC5tMiw12qCJqEnvoLQ2Vy~Z~6pwVN-MOj3xfds2pWdGrEcinkb0b5JudgDpZoOcuN5yRYhrvGRfbe0ntHnYviEnc5Lxm0XumqDFzhCAWlIUkCrhGiykVz576AZKgVcjtjTFMlnrc5KlpwEtnTrD2HC2ETqyENtjMAVyqzv3XK6GTqlrk4NTok-yT-9VxpVM9iEFPVAyVcAbNPqSIzqbrhctxA5Fi04gOSbWcsfH7b06mZFwZ0WLc0n4JC6O4W11LOy9TTiREbUtRv3bWTQ__';

  final String title = 'Курс';

  final String description = 'Описание курса';

  static double itemWidth = 250;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllCoursesPageBloc, AllCoursesPageState>(
      listenWhen: (lastContext, context) {
        return lastContext is! AllCoursesPageLoaded;
      },
      listener: (context, state) {
        context.read<AllCoursesPageBloc>().add(LoadAllCoursesImagesEvent());
      },
      builder: (context, state) {
        final width = MediaQuery.of(context).size.width;
        if (state is AllCoursesPageLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: GridView.count(
              crossAxisCount: width ~/ itemWidth,
              crossAxisSpacing: 20,
              mainAxisSpacing: 30,
              children: List.generate(
                state.allCourses?.data?.length ?? 0,
                (index) {
                  return SizedBox(
                    height: 200,
                    child: CourseElementWidget(
                      courseId: state.allCourses!.data![index].id,
                      imageUrl: state.imagesFiles[index],
                      title: state.allCourses!.data![index].title ?? '',
                      description: '$description ${index + 1}',
                      onTap: () {
                        if (state.allCourses!.data![index].id != null) {
                          context.goNamed(
                            RoutePath.detailCoursePage,
                            pathParameters: {
                              'courseId':
                                  '${state.allCourses!.data![index].id!}',
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
        if (state is AllCoursesLoadPage) {
          return const Center(
            child: SizedBox(
              height: 80,
              width: 80,
              child: CircularProgressIndicator(
                color: Colors.pink,
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
