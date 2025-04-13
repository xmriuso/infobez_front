import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_web_project/core/theme/app_colors.dart';
import 'package:test_web_project/core/theme/typography.dart';
import 'package:test_web_project/feature/all_courses_page/widgets/course_element_widget.dart';
import 'package:test_web_project/feature/app/routing/route_path.dart';
import 'package:test_web_project/feature/detail_module_page/bloc/detail_module_page_bloc.dart';
import '../bloc/detail_course_page_bloc.dart';
//изн
class DetailCoursePage extends StatefulWidget {
  const DetailCoursePage({super.key});

  @override
  State<DetailCoursePage> createState() => _DetailCoursePage();
}

class _DetailCoursePage extends State<DetailCoursePage> {
  @override
  void initState() {
    super.initState();
  }

  static double itemWidth = 255;

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
          return const Center(child: CircularProgressIndicator());
        }
        if (state is DetailCourseErrorState) {
          return const Center(child: Text('Ошибка загрузки'));
        }
        if (state is AllCoursesPageLoadedState) {
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
                      style: AppTypography.font28RegularZillaSlab.copyWith(
                        fontWeight: FontWeight.w900,
                        color: const Color.fromARGB(255, 184, 57, 137),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(48),
                            color: AppColors.pink100,
                          ),
                          child: GridView.count(
                            crossAxisCount: 3,
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
                                    context.goNamed(RoutePath.detailModulePage);
                                    context
                                        .read<DetailModulePageBloc>()
                                        .add(LoadModulesEvent(module.id!));
                                  },
                                  child: image != null
                                      ? Container(
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
                                        )
                                      : const Text('Загрузка...'),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
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
                                style: AppTypography.font32RegularZillaSlab
                                    .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                ' ',
                                textAlign: TextAlign.center,
                                style: AppTypography.font28RegularZillaSlab
                                    .copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                ' ',
                                textAlign: TextAlign.center,
                                style: AppTypography.font14RegularZillaSlab
                                    .copyWith(
                                  color: Colors.white,
                                  // Column(
                                  //   children: [
                                  //     Expanded(
                                  //       child: Container(
                                  //         decoration: BoxDecoration(
                                  //           borderRadius: BorderRadius.only(
                                  //               topLeft: Radius.circular(10),
                                  //               topRight: Radius.circular(10),
                                  //               bottomLeft: Radius.circular(8),
                                  //               bottomRight: Radius.circular(8)),
                                  //           border: Border.all(
                                  //               color: AppColors.loginGradient3,
                                  //               width: 1.2),
                                  //         ),
                                  //         child: Column(
                                  //           crossAxisAlignment: CrossAxisAlignment.start,
                                  //           children: [
                                  //             Flexible(
                                  //               flex: 1,
                                  //               child: Container(
                                  //                 decoration: BoxDecoration(
                                  //                     borderRadius: BorderRadius.only(
                                  //                         topLeft: Radius.circular(8),
                                  //                         topRight: Radius.circular(8)),
                                  //                     color: AppColors.PINK101),
                                  //                 child: Center(
                                  //                   child: Text(
                                  //                     '${module.title ?? ''}',
                                  //                     style: AppTypography
                                  //                         .font12RegularZillaSlab
                                  //                         .copyWith(color: AppColors.white),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             Flexible(
                                  //               flex: 2,
                                  //               child: Padding(
                                  //                 padding: EdgeInsets.all(16),
                                  //                 child: Column(
                                  //                   crossAxisAlignment:
                                  //                       CrossAxisAlignment.start,
                                  //                   children: [
                                  //                     Text(
                                  //                       'День ${index + 1}',
                                  //                       style: AppTypography
                                  //                           .font12RegularZillaSlab
                                  //                           .copyWith(
                                  //                               color: AppColors.black),
                                  //                     ),
                                  //                     Text(
                                  //                       'День ${index + 1}',
                                  //                       style: AppTypography
                                  //                           .font12RegularZillaSlab
                                  //                           .copyWith(
                                  //                               color: AppColors.black),
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
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
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
