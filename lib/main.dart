import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:sizer/sizer.dart';
import 'core/constant/color.dart';
import 'dependency_injector.dart';
import 'presentation/cubit/favorite/favorite_cubit.dart';
import 'presentation/cubit/home/home_cubit.dart';
import 'presentation/screens/main_screen.dart';
import 'dependency_injector.dart' as di;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'presentation/cubit/genre/genre_cubit.dart';
import 'presentation/cubit/popular/popular_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox('favorites');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: SCAFFOLD_COLOR,
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<HomeCubit>(),
          ),
          BlocProvider(
            create: (context) => sl<PopularCubit>()..getPopularMovies(),
          ),
          BlocProvider(
            create: (context) => sl<GenreCubit>()..chooseGenre(genreID: 27),
          ),
          BlocProvider(
            create: (context) => sl<FavoriteCubit>()..getFavorites(),
          ),
        ],
        child: LayoutBuilder(
          builder: (context, constraints) {
            return OrientationBuilder(
              builder: (context, orientation) {
                SizerUtil()
                    .init(constraints, orientation); //initialize SizerUtil
                return MainScreen();
              },
            );
          },
        ),
      ),
    );
  }
}
