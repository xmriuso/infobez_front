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
import 'package:test_web_project/core/api_service/data/api/service/api_service.dart'
    as _i982;
import 'package:test_web_project/core/api_service/data/repository/project_repository_impl.dart'
    as _i540;
import 'package:test_web_project/core/api_service/domain/repository/project_repository.dart'
    as _i774;
import 'package:test_web_project/core/api_service/domain/usecases/project_usecase.dart'
    as _i815;
import 'package:test_web_project/feature/all_courses_page/bloc/all_courses_page_bloc.dart'
    as _i613;

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
    gh.lazySingleton<_i982.ApiService>(() => _i982.ApiService());
    gh.lazySingleton<_i774.ProjectRepository>(
        () => _i540.ProjectRepositoryImpl(apiService: gh<_i982.ApiService>()));
    gh.lazySingleton<_i815.ProjectUseCase>(() =>
        _i815.ProjectUseCase(projectRepository: gh<_i774.ProjectRepository>()));
    gh.lazySingleton<_i613.AllCoursesPageBloc>(
        () => _i613.AllCoursesPageBloc(gh<_i815.ProjectUseCase>()));
    return this;
  }
}
