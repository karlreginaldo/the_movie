import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themovie/dependency_injector.dart';
import 'package:themovie/presentation/cubit/movie_cubit.dart';
import 'package:themovie/presentation/screens/main_screen.dart';
import 'package:themovie/dependency_injector.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<MovieCubit>(
        create: (context) => sl<MovieCubit>(),
        child: MainScreen(),
      ),
    );
  }
}
