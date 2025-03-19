import 'package:flutter/material.dart';
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
    return Center(child: Text('12342134231'),);
  }
}
