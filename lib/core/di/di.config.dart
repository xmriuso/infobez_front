// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:test_web_project/core/api_client/api_client.dart' as _i53;
import 'package:test_web_project/core/api_service/data/api/service/api_service.dart'
    as _i982;
import 'package:test_web_project/core/api_service/data/repository/project_repository_impl.dart'
    as _i540;
import 'package:test_web_project/core/api_service/domain/repository/project_repository.dart'
    as _i774;
import 'package:test_web_project/core/api_service/domain/usecases/project_usecase.dart'
    as _i815;
import 'package:test_web_project/core/services/cache_service_cubit/cache_service_cubit.dart'
    as _i838;
import 'package:test_web_project/feature/all_courses_page/bloc/all_courses_page_bloc.dart'
    as _i613;
import 'package:test_web_project/feature/auth_page/bloc/auth_page_bloc.dart'
    as _i557;
import 'package:test_web_project/feature/create_course_page/bloc/create_course_page_bloc.dart'
    as _i872;
import 'package:test_web_project/feature/create_module_page/bloc/create_module_page_bloc.dart'
    as _i700;
import 'package:test_web_project/feature/detail_course_page/bloc/detail_course_page_bloc.dart'
    as _i602;
import 'package:test_web_project/feature/favourites_courses_page/bloc/favourites_courses_page_bloc.dart'
    as _i311;
import 'package:test_web_project/feature/my_courses_page/bloc/my_courses_page_bloc.dart'
    as _i134;
import 'package:test_web_project/feature/profile_page/bloc/profile_page_bloc.dart'
    as _i475;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i53.ApiClient>(() => _i53.ApiClient());
    gh.lazySingleton<_i838.CacheServiceCubit>(() => _i838.CacheServiceCubit());
    gh.lazySingleton<_i982.ApiService>(
        () => _i982.ApiService(gh<_i53.ApiClient>()));
    gh.lazySingleton<_i774.ProjectRepository>(
        () => _i540.ProjectRepositoryImpl(apiService: gh<_i982.ApiService>()));
    gh.lazySingleton<_i815.ProjectUseCase>(() =>
        _i815.ProjectUseCase(projectRepository: gh<_i774.ProjectRepository>()));
    gh.lazySingleton<_i613.AllCoursesPageBloc>(
        () => _i613.AllCoursesPageBloc(gh<_i815.ProjectUseCase>()));
    gh.lazySingleton<_i557.AuthPageBloc>(
        () => _i557.AuthPageBloc(gh<_i815.ProjectUseCase>()));
    gh.lazySingleton<_i872.CreateCoursePageBloc>(
        () => _i872.CreateCoursePageBloc(gh<_i815.ProjectUseCase>()));
    gh.lazySingleton<_i700.CreateModulePageBloc>(
        () => _i700.CreateModulePageBloc(gh<_i815.ProjectUseCase>()));
    gh.lazySingleton<_i602.DetailCoursePageBloc>(
        () => _i602.DetailCoursePageBloc(gh<_i815.ProjectUseCase>()));
    gh.lazySingleton<_i311.FavouritesCoursesPageBloc>(
        () => _i311.FavouritesCoursesPageBloc(gh<_i815.ProjectUseCase>()));
    gh.lazySingleton<_i134.MyCoursesPageBloc>(
        () => _i134.MyCoursesPageBloc(gh<_i815.ProjectUseCase>()));
    gh.lazySingleton<_i475.ProfilePageBloc>(
        () => _i475.ProfilePageBloc(gh<_i815.ProjectUseCase>()));
    return this;
  }
}
