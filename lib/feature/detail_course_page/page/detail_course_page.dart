import 'package:flutter/material.dart';
import 'package:test_web_project/core/theme/app_colors.dart';
import 'package:test_web_project/core/theme/typography.dart';
import 'package:test_web_project/feature/all_courses_page/widgets/course_element_widget.dart';

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

  @override
  Widget build(BuildContext context) {
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
                crossAxisCount: 6,
                crossAxisSpacing: 44,
                mainAxisSpacing: 62,
                children: List.generate(
                  60,
                  (index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                        border: Border.all(
                            color: AppColors.loginGradient3, width: 1.2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8)),
                                  color: AppColors.loginGradient3),
                              child: Center(
                                child: Text(
                                  'День ${index + 1}',
                                  style: AppTypography.font12RegularZillaSlab
                                      .copyWith(color: AppColors.white),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'День ${index + 1}',
                                    style: AppTypography.font12RegularZillaSlab
                                        .copyWith(color: AppColors.black),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    'День ${index + 1}',
                                    style: AppTypography.font12RegularZillaSlab
                                        .copyWith(color: AppColors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
}
