import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_web_project/feature/app/routing/route_path.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _gradientController;
  late Animation<double> _fadeAnimation;
  late Animation<Alignment> _alignmentAnimation1;
  late Animation<Alignment> _alignmentAnimation2;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _onAnimationEnd();
      }
    });

    // Градиентная анимация
    _gradientController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _alignmentAnimation1 = TweenSequence<Alignment>([
      TweenSequenceItem(
          tween: Tween(begin: Alignment.topLeft, end: Alignment.bottomRight),
          weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: Alignment.bottomRight, end: Alignment.topLeft),
          weight: 1),
    ]).animate(_gradientController);

    _alignmentAnimation2 = TweenSequence<Alignment>([
      TweenSequenceItem(
          tween: Tween(begin: Alignment.bottomLeft, end: Alignment.topRight),
          weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: Alignment.topRight, end: Alignment.bottomLeft),
          weight: 1),
    ]).animate(_gradientController);
  }

  void _onAnimationEnd() {
    context.go(RoutePath.authPage);
  }

  @override
  void dispose() {
    _controller.dispose();
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Фоновая анимация градиента
          AnimatedBuilder(
            animation: _gradientController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: _alignmentAnimation1.value,
                    end: _alignmentAnimation2.value,
                    colors: const [
                      Color.fromARGB(255, 252, 230, 132),
                      Color.fromARGB(255, 245, 135, 226),
                      Color.fromARGB(255, 169, 101, 247),
                    ],
                  ),
                ),
              );
            },
          ),

          // Текст поверх анимации
          Center(
            child: AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: const Text(
                    "Добро пожаловать в фитнес-мир!",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(blurRadius: 10, color: Colors.black38, offset: Offset(2, 2))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
