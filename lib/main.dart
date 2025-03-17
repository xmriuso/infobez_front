import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/di.dart';
import 'core/theme/theme.dart';
import 'feature/all_courses_page/bloc/all_courses_page_bloc.dart';
import 'feature/app/routing/routing.dart';

void main() {
  setupDependencies();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final _router = RoutesInit();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: getIt<AllCoursesPageBloc>(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _router.router,
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
      ),
    );
  }
}
