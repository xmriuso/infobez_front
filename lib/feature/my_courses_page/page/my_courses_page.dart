import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../app/routing/route_path.dart';
import '../bloc/my_courses_page_bloc.dart';
import 'dart:typed_data';

class MyCoursesPage extends StatefulWidget {
  const MyCoursesPage({super.key});

  @override
  State<MyCoursesPage> createState() => _MyCoursesPage();
}

class _MyCoursesPage extends State<MyCoursesPage> {
  static double itemWidth = 250;

  @override
  void initState() {
    super.initState();
    context.read<MyCoursesPageBloc>().add(
          LoadMyCoursesEvent(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: BlocConsumer<MyCoursesPageBloc, MyCoursesPageState>(
        listenWhen: (lastContext, context) {
          return lastContext is! AllCoursesPageLoadedState;
        },
        listener: (context, state) {
          context.read<MyCoursesPageBloc>().add(LoadImagesEvent());
        },
        builder: (context, state) {
          final width = MediaQuery.of(context).size.width;

          if (state is AllCoursesPageLoadedState) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: GridView.count(
                crossAxisCount: width ~/ itemWidth,
                crossAxisSpacing: 20,
                mainAxisSpacing: 30,
                children: List.generate(
                  (state.myCourses?.length ?? 0) + 1,
                  (index) {
                    final course = index == (state.myCourses?.length ?? 0)
                        ? null
                        : state.myCourses![index];

                    return GestureDetector(
                      onTap: () {
                        context.goNamed(
                          RoutePath.createCoursePage,
                          pathParameters: {
                            'courseId': index == (state.myCourses?.length ?? 0)
                                ? '0'
                                : '${state.myCourses?[index]?.id ?? '0'}',
                          },
                        );
                      },
                      child: index == (state.myCourses?.length ?? 0)
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.pink,
                                  width: 1.2,
                                ),
                              ),
                              height: 200,
                              child: Icon(
                                Icons.add,
                                color: Colors.pink,
                                size: 100,
                              ),
                            )
                          : SizedBox(
                              height: 200,
                              child: CourseElementWidget(
                                imageUrl: state.imagesFiles[index],
                                title: course?.title ?? '',
                                description: '',
                                onTap: () {},
                              ),
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

class CourseElementWidget extends StatefulWidget {
  final String title;
  final String description;
  final Uint8List? imageUrl;
  final Function()? onTap;

  const CourseElementWidget({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.onTap,
  });

  @override
  _CourseElementWidgetState createState() => _CourseElementWidgetState();
}

class _CourseElementWidgetState extends State<CourseElementWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: widget.imageUrl != null
                ? Image.memory(
                    widget.imageUrl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : SizedBox(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 3, child: SizedBox()),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.purple, Colors.pink],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Text(
                              textAlign: TextAlign.center,
                              widget.title,
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
