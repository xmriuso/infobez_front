import 'package:flutter/material.dart';
import 'package:test_web_project/core/theme/typography.dart';

class CourseElementWidget extends StatelessWidget {
  final String? imageUrl;

  const CourseElementWidget({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: imageUrl != null
                ? Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  )
                : SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
