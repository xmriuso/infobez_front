import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_web_project/core/theme/app_colors.dart';
import 'package:test_web_project/core/theme/typography.dart';
import 'package:test_web_project/feature/all_courses_page/widgets/course_element_widget.dart';
import 'package:test_web_project/feature/app/routing/route_path.dart';

import '../bloc/detail_course_page_bloc.dart';

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

  final String imageUrl =
      'https://s3-alpha-sig.figma.com/img/ca11/c290/2cf71701d78d4f88eb015cd8634a5fdc?Expires=1743379200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=ljyvnHzSl2K9RX-OF~6NPqMsZQffisZsfgLEs3JPuBi2IIOUc51JKhV8A-4Dd6o77uGyeJhvmvgrovktu1Q4d9fmk7ofI7U~r9me4yBLu9PNATG7s2phnX~bCiwmeEjwgIEWmxwOWsq-zL7liTZkth-XUC9kYW2ylef~ETslgWwTR1qwispjSM4coelj8sOsh9pzqKk6gGTMAGC1QP3Ahv3CNxEqHdYRQydAg4ghlzNP1hOFbP5XE~gqBGaFgd6A5VDXgjIXN6kb2R22iotgXARh9y7rzP9XGYYjNltzPu-RMZnYwT263DtVJYeuPt-hB6fYcjS9b9kqLMZHimVmhw__';

  final String title = 'Курс';

  final String description = 'Описание курса';

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
          return Text('Загрузка');
        }
        if (state is DetailCourseErrorState) {
          return Text('Ошибка');
        }
        if (state is AllCoursesPageLoadedState) {
          return Column(
            children: [
              Text(
                "Стройная  2.0",
                style: AppTypography.font28RegularUnbounded.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                  child: Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(48),
                        color: AppColors.pink100),
                    child: GridView.count(
                      childAspectRatio: 121 / 80,
                      crossAxisCount: width ~/ itemWidth,
                      crossAxisSpacing: 44,
                      mainAxisSpacing: 62,
                      children: List.generate(
                        state.modulesByCourseId?.data?.length ?? 0,
                        (index) {
                          //Todo: вынести в отдельный виджет
                          final module = state.modulesByCourseId!.data![index];
                          final image = state.imagesFiles[index];
                          return GestureDetector(
                            onTap: () {
                              context.goNamed(RoutePath.detailModulePage);
                            },
                            child: image != null
                                ? Image.memory(
                                    image,
                                    fit: BoxFit.cover,
                                  )
                                : Text('Загрузка...'),
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
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return SizedBox();
      },
    );
  }
}
