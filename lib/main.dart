import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_web_project/feature/detail_course_page/bloc/detail_course_page_bloc.dart';

import 'core/di/di.dart';
import 'core/services/cache_service_cubit/cache_service_cubit.dart';
import 'core/theme/theme.dart';
import 'feature/all_courses_page/bloc/all_courses_page_bloc.dart';
import 'feature/app/routing/routing.dart';
import 'feature/auth_page/bloc/auth_page_bloc.dart';
import 'feature/favourites_courses_page/bloc/favourites_courses_page_bloc.dart';

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

final router = RoutesInit();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: getIt<AllCoursesPageBloc>(),
        ),
        BlocProvider.value(
          value: getIt<DetailCoursePageBloc>(),
        ),
        BlocProvider.value(
          value: getIt<CacheServiceCubit>()..loadFavourites(),
        ),
        BlocProvider.value(
          value: getIt<FavouritesCoursesPageBloc>(),
        ),
        BlocProvider.value(
          value: getIt<AuthPageBloc>(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router.router,
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
      ),
    );
  }
}
