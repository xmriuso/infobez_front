import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_web_project/core/theme/app_colors.dart';
import 'package:test_web_project/core/theme/typography.dart';
import 'package:test_web_project/feature/app/routing/route_path.dart';

import '../bloc/detail_course_page_bloc.dart';

class DetailCoursePage extends StatefulWidget {
  const DetailCoursePage({super.key});

  @override
  State<DetailCoursePage> createState() => _DetailCoursePage();
}

class _DetailCoursePage extends State<DetailCoursePage> {
  static double itemWidth = 120;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocBuilder<DetailCoursePageBloc, DetailCoursePageState>(
      builder: (context, state) {
        if (state is DetailCourseLoadState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is DetailCourseErrorState) {
          return const Center(child: Text('Ошибка загрузки'));
        }
        if (state is AllCoursesPageLoadedState) {
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 245, 248), // общий фон плашки
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color.fromARGB(255, 208, 170, 211)),
                    ),
                    child: Row(
                      children: [
                        // Левая колонка: сетка с модулями
                        Expanded(
                          flex: 3,
                          child: GridView.count(
                            crossAxisCount: 3,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            childAspectRatio: 1.4,
                            children: List.generate(
                              state.modulesByCourseId?.data?.length ?? 9,
                              (index) {
                                final module = state.modulesByCourseId?.data?[index];
                                return GestureDetector(
                                  onTap: () {
                                    context.goNamed(RoutePath.detailModulePage);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color.fromARGB(255, 193, 133, 171),
                                        width: 2.1,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const SizedBox(), // Можно добавить изображение/иконку
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),

                        // Правая колонка: описание
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 193, 133, 171),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '',
                                  textAlign: TextAlign.center,
                                  style: AppTypography.font32RegularMontserrat.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  ' ',
                                  textAlign: TextAlign.center,
                                  style: AppTypography.font28RegularMontserrat.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  ' ',
                                  textAlign: TextAlign.center,
                                  style: AppTypography.font14RegularMontserrat.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Нижняя панель со стрелкой назад и текстом
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
                    Text(
                      "Стройная я 2.0",
                      style: AppTypography.font28RegularMontserrat.copyWith(
                        fontWeight: FontWeight.w900,
                        color: const Color.fromARGB(255, 193, 133, 171),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
