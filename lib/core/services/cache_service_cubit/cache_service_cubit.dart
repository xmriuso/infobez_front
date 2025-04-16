import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_project/core/services/cache_service_cubit/shared_preferences_paths.dart';

part 'cache_service_state.dart';

@lazySingleton
class CacheServiceCubit extends Cubit<CacheServiceState> {
  CacheServiceCubit()
      : super(
          CacheServiceState(
            favourites: [],
          ),
        );

  Future<void> loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final stringList =
        prefs.getStringList(SharedPreferencesPaths.favoritesKey) ?? [];
    final favouriteCourses = stringList.map(int.parse).toList();
    emit(
      state.copyWith(
        favourites: favouriteCourses,
      ),
    );
  }

  Future<void> setFavourites({
    required int courseId,
  }) async {
    List<int> favouriteCourses = state.favourites;

    if (favouriteCourses.contains(courseId)) {
      favouriteCourses.remove(courseId);
    } else {
      favouriteCourses.add(courseId);
    }

    final prefs = await SharedPreferences.getInstance();
    final stringList = favouriteCourses.map((e) => e.toString()).toList();
    await prefs.setStringList(SharedPreferencesPaths.favoritesKey, stringList);

    emit(
      state.copyWith(
        favourites: favouriteCourses,
      ),
    );
  }
}
