import 'package:flutter/material.dart';

class FavouritesCoursesPage extends StatelessWidget {
  const FavouritesCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Card1();
  }
}
class Card1 extends StatelessWidget {
  const Card1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: Image.network("https://sun9-68.userapi.com/wBdHyW8aO_13zv5iSnlSqhdFloeYTfYRN2jgYg/h73em_Sfv0E.jpg"),);

  }
}