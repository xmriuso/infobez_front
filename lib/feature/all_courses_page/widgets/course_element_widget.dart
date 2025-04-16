import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test_web_project/core/di/di.dart';
import 'package:test_web_project/core/theme/typography.dart';
import 'package:test_web_project/feature/favourites_courses_page/page/favourites_courses_page.dart';

import '../../../core/services/cache_service_cubit/cache_service_cubit.dart';

class CourseElementWidget extends StatefulWidget {
  final int? courseId;
  final String title;
  final String description;
  final Uint8List? imageUrl;
  final Function()? onTap;

  const CourseElementWidget({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.courseId,
    this.onTap,
  });

  @override
  _CourseElementWidgetState createState() => _CourseElementWidgetState();
}

class _CourseElementWidgetState extends State<CourseElementWidget> {
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CacheServiceCubit, CacheServiceState>(
      builder: (context, state) {
        final isFavourite = widget.courseId != null
            ? getIt
                .get<CacheServiceCubit>()
                .state
                .favourites
                .contains(widget.courseId)
            : false;

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
                        // loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        //   if (loadingProgress == null) {
                        //     return child;
                        //   } else {
                        //     return Shimmer.fromColors(
                        //       baseColor: Colors.pink,
                        //       highlightColor: Colors.blue,
                        //       child: AspectRatio(
                        //         aspectRatio: 1,
                        //         child: Container(color: Colors.grey),
                        //       ),
                        //     );
                        //   }
                        // },
                      )
                    : SizedBox(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: Icon(
                              isFavourite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavourite ? Colors.red : Colors.white,
                              size: 24,
                            ),
                            onPressed: () {
                              if (widget.courseId != null) {
                                getIt
                                    .get<CacheServiceCubit>()
                                    .setFavourites(courseId: widget.courseId!);
                              }
                            }),
                      ],
                    ),
                  ),
                  Expanded(flex: 2, child: SizedBox()),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.purple, Colors.pink],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.fill,
                            child: Text("Выполнено 0 из 5",
                                style: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(height: 4),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: widget.onTap,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Начать"),
                                  Icon(Icons.arrow_forward, size: 16)
                                ],
                              ),
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
      },
    );
  }
}
