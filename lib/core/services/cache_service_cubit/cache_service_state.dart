part of 'cache_service_cubit.dart';

class CacheServiceState{
  final List<int> favourites;

  CacheServiceState({
    required this.favourites,
  });

  CacheServiceState copyWith({
    List<int>? favourites,
  }) {
    return CacheServiceState(
      favourites: favourites ?? this.favourites,
    );
  }
}
