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
import 'package:test_web_project/core/api_service/api_service.dart' as _i722;
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
    gh.lazySingleton<_i722.ApiService>(() => _i722.ApiService());
    gh.lazySingleton<_i613.AllCoursesPageBloc>(
        () => _i613.AllCoursesPageBloc(gh<_i722.ApiService>()));
    return this;
  }
}
