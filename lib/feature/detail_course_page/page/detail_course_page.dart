import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_web_project/core/theme/app_colors.dart';
import 'package:test_web_project/core/theme/typography.dart';
import 'package:test_web_project/feature/all_courses_page/widgets/course_element_widget.dart';
import 'package:test_web_project/feature/app/routing/route_path.dart';
import '../bloc/detail_course_page_bloc.dart';

//изн
class DetailCoursePage extends StatefulWidget {
  final int courseId;

  const DetailCoursePage({
    super.key,
    required this.courseId,
  });

  @override
  State<DetailCoursePage> createState() => _DetailCoursePage();
}

class _DetailCoursePage extends State<DetailCoursePage> {
  @override
  void initState() {
    super.initState();
    context.read<DetailCoursePageBloc>().add(
          LoadDetailCourseEvent(courseId: widget.courseId),
        );
  }

  static double itemWidth = 400;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocConsumer<DetailCoursePageBloc, DetailCoursePageState>(
      listenWhen: (lastContext, context) {
        return lastContext is! AllCoursesPageLoadedState;
      },
      listener: (context, state) {
        context.read<DetailCoursePageBloc>().add(LoadImagesEvent());
      },
      builder: (context, state) {
        if (state is DetailCourseLoadState) {
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
        if (state is DetailCourseErrorState) {
          return const Center(child: Text('Ошибка загрузки'));
        }
        if (state is AllCoursesPageLoadedState) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new),
                      color: const Color.fromARGB(255, 193, 133, 171),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          state.detailCourse?.title ?? '',
                          style: AppTypography.font28RegularZillaSlab.copyWith(
                            fontWeight: FontWeight.w900,
                            color: const Color.fromARGB(255, 184, 57, 137),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(48),
                      color: AppColors.pink100,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: GridView.count(
                            crossAxisCount: width ~/ itemWidth,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            childAspectRatio: 1.4,
                            children: List.generate(
                              state.modulesByCourseId?.data?.length ?? 0,
                              (index) {
                                final module =
                                    state.modulesByCourseId!.data![index];
                                final image = state.imagesFiles[index];
                                return GestureDetector(
                                  onTap: () {
                                    context.goNamed(
                                      RoutePath.detailModulePage,
                                      pathParameters: {
                                        'moduleId': '$index',
                                        'courseId':
                                            '${int.parse(GoRouterState.of(context).pathParameters['courseId']!)}',
                                      },
                                    );
                                  },
                                  child: image != null
                                      ? Stack(
                                          children: [
                                            Positioned.fill(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: AppColors.PINK101,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.memory(
                                                    image,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 8,
                                                    right: 8,
                                                    bottom: 8,
                                                  ),
                                                  child: Text(
                                                    module.title ?? '',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      : const Text('Загрузка...'),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: AppColors.pink200.withOpacity(0.44),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                      'Описание:',
                                      textAlign: TextAlign.center,
                                      style: AppTypography
                                          .font36RegularZillaSlab
                                          .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      state.detailCourse?.description ?? '',
                                      textAlign: TextAlign.center,
                                      style: AppTypography
                                          .font28RegularZillaSlab
                                          .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
