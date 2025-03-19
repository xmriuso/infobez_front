import 'package:flutter/material.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_web_project/feature/all_courses_page/widgets/course_element_widget.dart';
import 'package:test_web_project/feature/all_courses_page/widgets/course_element_widget1.dart';
import 'package:test_web_project/feature/all_courses_page/widgets/course_element_widget2.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllCoursesPageBloc, AllCoursesPageState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0), // Отступы слева и справа для всей страницы
          child: GridView.count(
            crossAxisCount: 4, // Количество колонок (4 в ряд)
            crossAxisSpacing: 20, // Отступы между колонками
            mainAxisSpacing: 30, // Отступы между рядами
            children: List.generate(
              3,
              (index) {
                final imageUrl = [
                  'https://s3-alpha-sig.figma.com/img/dc74/8edd/3fd2beaa0bdb4230ca842308835f8cfb?Expires=1743379200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=fQ-e8SA9WvZhhwQE8zkrqofBW3AYmFCrOg89OYBFUm39XPXH9RlcJtV3TX7owRH982icC5tMiw12qCJqEnvoLQ2Vy~Z~6pwVN-MOj3xfds2pWdGrEcinkb0b5JudgDpZoOcuN5yRYhrvGRfbe0ntHnYviEnc5Lxm0XumqDFzhCAWlIUkCrhGiykVz576AZKgVcjtjTFMlnrc5KlpwEtnTrD2HC2ETqyENtjMAVyqzv3XK6GTqlrk4NTok-yT-9VxpVM9iEFPVAyVcAbNPqSIzqbrhctxA5Fi04gOSbWcsfH7b06mZFwZ0WLc0n4JC6O4W11LOy9TTiREbUtRv3bWTQ__',
                  'https://s3-alpha-sig.figma.com/img/b80f/605b/7409f614ea9efc6e65578591b7996fce?Expires=1743379200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=HpJH5R6QM02JCJFBQeWYYvbOQr5Zvdc3ecwCbXdkYWzXL7KfpP6eehsc5ZgBB5sjJnzvLJSZV6b5rvjFys7YYJN7LXtgIpD~50P1xfz9p5eIrWu97gQRhjhWk50I8vBsNaPtcrk8IyTWfjaer2k4Fz1AWvA~HUwAwHrJePwUZ5oMAIdwG~5grsyk-w8Vly5i8eDVCEB2RnsUIrL9qU9Zo0HSJRYCvfMLNErYRaVWy93e1LyHT-Y89xnjY7~s-7EvQPR5FZxd7Lxl9r36NSNAEO~xXuYqmsFivGo-DAnxQWACE56YZPdPLNOrkwYEHsnYLp-pOyc8g2F3NrTp6Ne-9A__',
                  'https://s3-alpha-sig.figma.com/img/ca11/c290/2cf71701d78d4f88eb015cd8634a5fdc?Expires=1743379200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=ljyvnHzSl2K9RX-OF~6NPqMsZQffisZsfgLEs3JPuBi2IIOUc51JKhV8A-4Dd6o77uGyeJhvmvgrovktu1Q4d9fmk7ofI7U~r9me4yBLu9PNATG7s2phnX~bCiwmeEjwgIEWmxwOWsq-zL7liTZkth-XUC9kYW2ylef~ETslgWwTR1qwispjSM4coelj8sOsh9pzqKk6gGTMAGC1QP3Ahv3CNxEqHdYRQydAg4ghlzNP1hOFbP5XE~gqBGaFgd6A5VDXgjIXN6kb2R22iotgXARh9y7rzP9XGYYjNltzPu-RMZnYwT263DtVJYeuPt-hB6fYcjS9b9kqLMZHimVmhw__',
                ][index];

                final title = [
                  'Курс 1',
                  'Курс 2',
                  'Курс 3',
                ][index];

                final description = [
                  'Описание курса 1',
                  'Описание курса 2',
                  'Описание курса 3',
                ][index];

                return Padding(
                  padding: const EdgeInsets.only(top: 20), // Отступ сверху для каждого курса
                  child: Builder(
                    builder: (context) {
                      switch (index) {
                        case 0:
                          return CourseElementWidget(
                            imageUrl: imageUrl,
                            title: title,
                            description: description,
                          );
                        case 1:
                          return CourseElementWidget1(
                            imageUrl: imageUrl,
                            title: title,
                            description: description,
                          );
                        case 2:
                          return CourseElementWidget2(
                            imageUrl: imageUrl,
                            title: title,
                            description: description,
                          );
                        default:
                          return SizedBox.shrink();
                      }
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
