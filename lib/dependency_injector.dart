import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:themovie/presentation/cubit/movie_cubit.dart';
import 'data/datasources/movie_remote_data_source.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'domain/repositories/movie_repository.dart';
import 'domain/usecases/get_specific_movie.dart';
import 'domain/usecases/search_movies.dart';

final sl = GetIt.instance;

Future<void> init() {
  sl.registerFactory(
    () => MovieCubit(
      getMovie: sl(),
      searchMovies: sl(),
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

  sl.registerFactory<MovieRepository>(
    () => MovieRepositoryImpl(
      sl(),
    ),
  );

  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(
      sl(),
    ),
  );

  sl.registerLazySingleton(() => http.Client());
}
