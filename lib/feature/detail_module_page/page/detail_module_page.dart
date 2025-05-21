import 'dart:ui' as ui;
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_web_project/core/api_service/domain/entities/modules_by_id_entity.dart';
import 'package:test_web_project/core/di/di.dart';
import 'package:test_web_project/core/theme/app_colors.dart';

import '../../../core/theme/typography.dart';
import '../../detail_course_page/bloc/detail_course_page_bloc.dart';

class DetailModulePage extends StatefulWidget {
  final int moduleId;

  const DetailModulePage({
    super.key,
    required this.moduleId,
  });

  @override
  State<DetailModulePage> createState() => _DetailModulePageState();
}

class _DetailModulePageState extends State<DetailModulePage> {
  // @override
  // void initState() {
  //   super.initState();
  //   if (getIt<DetailCoursePageBloc>().state is AllCoursesPageInitial) {
  //     final courseId = int.tryParse(
  //         GoRouterState.of(context).pathParameters['courseId'] ?? '');
  //     if (courseId != null) {
  //       context.read<DetailCoursePageBloc>().add(
  //             LoadDetailCourseEvent(
  //               courseId: courseId,
  //               moduleIndex: widget.moduleId,
  //             ),
  //           );
  //     }
  //   }
  // }
  bool _isInitialized = false;
  int moduleIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _isInitialized = true;

      moduleIndex = widget.moduleId;
      final pathParams = GoRouterState.of(context).pathParameters;
      final courseId = int.tryParse(pathParams['courseId'] ?? '');

      if (courseId != null) {
        context.read<DetailCoursePageBloc>().add(
              LoadDetailCourseEvent(
                courseId: courseId,
              ),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailCoursePageBloc, DetailCoursePageState>(
        // buildWhen: (lastState, state) {
        //   final lastStateS = lastState ;
        //   final stateS = state;
        //   if (lastStateS.selectedModuleIndex != stateS.selectedModuleIndex) {
        //     return true;
        //   }
        //   return false;
        // },
        builder: (context, state) {
          if (state is AllCoursesPageLoadedState) {
            final arrowBackIsAvailable = moduleIndex > 0;
            final arrowNextIsAvailable =
                moduleIndex < (state.modulesByCourseId!.data!.length - 1);

            return ListView(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  decoration: BoxDecoration(
                    color: AppColors.pink100,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Column(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: VideoWidget(
                            url: state
                                .modulesByCourseId?.data?[moduleIndex].videoUrl,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: arrowBackIsAvailable
                                  ? () {
                                      setState(() {
                                        moduleIndex--;
                                      });
                                    }
                                  : null,
                              child: Icon(
                                Icons.arrow_back,
                                color: arrowBackIsAvailable
                                    ? AppColors.black
                                    : AppColors.gray,
                              ),
                            ),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: arrowNextIsAvailable
                                  ? () {
                                      setState(() {
                                        moduleIndex++;
                                      });
                                    }
                                  : null,
                              child: Icon(
                                Icons.arrow_forward,
                                color: arrowNextIsAvailable
                                    ? AppColors.black
                                    : AppColors.gray,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  decoration: BoxDecoration(
                    color: AppColors.pink100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    state.modulesByCourseId!.data![moduleIndex].description ??
                        '',
                    style: AppTypography.font32RegularZillaSlab.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                )
                // Блок с видео-плеером
                // Expanded(
                //   flex: 4,
                //   child: Container(
                //     width: double.infinity,
                //     margin: const EdgeInsets.all(20),
                //     padding: const EdgeInsets.all(20),
                //     decoration: BoxDecoration(
                //       color: const Color.fromARGB(255, 255, 245, 248),
                //       borderRadius: BorderRadius.circular(24),
                //     ),
                //     child: Stack(
                //       alignment: Alignment.center,
                //       children: [
                //         Container(
                //           width: double.infinity,
                //           height: double.infinity,
                //           decoration: BoxDecoration(
                //             color: Colors.grey.shade300,
                //             borderRadius: BorderRadius.circular(20),
                //           ),
                //           child: const Icon(
                //             Icons.play_arrow,
                //             size: 80,
                //             color: Colors.white,
                //           ),
                //         ),
                //         Positioned(
                //           left: 10,
                //           child: IconButton(
                //             icon: const Icon(Icons.arrow_back_ios_new),
                //             onPressed: _previousVideo,
                //           ),
                //         ),
                //         Positioned(
                //           right: 10,
                //           child: IconButton(
                //             icon: const Icon(Icons.arrow_forward_ios),
                //             onPressed: _nextVideo,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class VideoWidget extends StatelessWidget {
  final String? url;

  const VideoWidget({required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    final videoId = _extractVideoId(url);
    if (videoId != null) {
      final String viewType = 'youtube-video-${UniqueKey()}'; // 🔥 ключ всегда новый

      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(
        viewType,
            (int viewId) {
          final iframe = IFrameElement()
            ..width = '100%'
            ..height = '100%'
            ..src = 'https://www.youtube.com/embed/$videoId?autoplay=1'
            ..style.border = 'none'
            ..style.pointerEvents = 'auto'
            ..style.overflow = 'auto';
          return iframe;
        },
      );

      return HtmlElementView(
        key: ValueKey(videoId), // 👈 ключ чтобы Flutter знал, что это другой виджет
        viewType: viewType,
      );
    } else {
      return const Text('Ошибка загрузки видео');
    }
  }

  String? _extractVideoId(String? url) {
    if (url == null) return null;
    final RegExp regExp = RegExp(r'(?<=v=)[^&]*');
    final match = regExp.firstMatch(url);
    return match?.group(0);
  }
}
