import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'data/datasources/movie_local_data_source.dart';
import 'domain/usecases/del_favorite.dart';
import 'domain/usecases/get_favorites.dart';
import 'presentation/cubit/favorite/favorite_cubit.dart';
import 'presentation/cubit/home/home_cubit.dart';
import 'presentation/cubit/movie/movie_details_cubit.dart';
import 'presentation/cubit/popular/popular_cubit.dart';
import 'data/datasources/movie_remote_data_source.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'domain/repositories/movie_repository.dart';
import 'domain/usecases/add_favorite.dart';
import 'domain/usecases/choose_genre.dart';
import 'domain/usecases/get_initial_popular_movies.dart';
import 'domain/usecases/get_specific_movie.dart';
import 'domain/usecases/search_movies.dart';
import 'presentation/cubit/genre/genre_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubit
  sl.registerFactory(
    () => HomeCubit(
      sl(),
    ),
  );

  sl.registerFactory(
    () => PopularCubit(
      sl(),
    ),
  );

  sl.registerFactory(
    () => MovieDetailsCubit(
      sl(),
    ),
  );
  sl.registerFactory(
    () => GenreCubit(
      sl(),
    ),
  );

  sl.registerFactory(
    () => FavoriteCubit(
      addFavorite: sl(),
      delFavorite: sl(),
      getFavorites: sl(),
    ),
  );

  // Usecase
  sl.registerLazySingleton(
    () => AddFavorite(
      sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetFavorites(
      sl(),
    ),
  );
  sl.registerLazySingleton(
    () => DelFavorite(
      sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetSpecificMovie(
      sl(),
    ),
  );

  sl.registerLazySingleton(
    () => SearchMovies(
      sl(),
    ),
  );

  sl.registerLazySingleton(
    () => ChooseGenre(
      sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetInitialPopularMovies(
      sl(),
    ),
  );

  // Repository
  sl.registerFactory<MovieRepository>(
    () => MovieRepositoryImpl(sl(), sl()),
  );

  // Remote
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(
      sl(),
    ),
  );

  // Local
  sl.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(),
  );

  sl.registerLazySingleton(() => http.Client());
}
