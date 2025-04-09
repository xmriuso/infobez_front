import 'package:flutter/material.dart';

class DetailModulePage extends StatefulWidget {
  const DetailModulePage({super.key});

  @override
  State<DetailModulePage> createState() => _DetailModulePageState();
}

class _DetailModulePageState extends State<DetailModulePage> {
  int currentVideoIndex = 0;

  final List<String> videoUrls = [
    'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
    'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
    'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
  ];

  final List<String> descriptions = [
    "Описание видео 1: полезные практики для расслабления",
    "Описание видео 2: дыхательные упражнения",
    "Описание видео 3: медитация перед сном",
  ];

  void _nextVideo() {
    setState(() {
      currentVideoIndex = (currentVideoIndex + 1) % videoUrls.length;
    });
  }

  void _previousVideo() {
    setState(() {
      currentVideoIndex =
          (currentVideoIndex - 1 + videoUrls.length) % videoUrls.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Верхняя часть: Блок с видео (4/5 экрана)
          Expanded(
            flex: 4, // Занимает 4/5 экрана
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 245, 248), // Нежно-розовый
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    left: 10,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new),
                      onPressed: _previousVideo,
                    ),
                  ),
                  Positioned(
                    right: 10,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: _nextVideo,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Средняя часть: Блок с описанием (1/5 экрана)
          Expanded(
            flex: 1, // Занимает 1/5 экрана
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 193, 133, 171), // Темно-розовый
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Text(
                  descriptions[currentVideoIndex],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),

          // Нижняя часть: Кнопка "назад"
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  color: const Color.fromARGB(255, 193, 133, 171),
                  onPressed: () {
                    Navigator.pop(context); // Возвращение на предыдущий экран
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}