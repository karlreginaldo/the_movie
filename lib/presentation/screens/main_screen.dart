import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/home/home_cubit.dart';
import 'favorites_screen.dart';
import 'search_screen.dart';
import '../widgets/components/custom_display_error.dart';
import '../widgets/components/linear_progress.dart';
import '../widgets/header.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

Duration myDuration = Duration(milliseconds: 200);

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
                child: Header(),
              ),
              SizedBox(
                height: 25,
              ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeInitial) {
                    return AnimatedContainer(
                      duration: myDuration,
                      child: HomeScreen(),
                    );
                  } else if (state is Favorites) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: AnimatedContainer(
                        duration: myDuration,
                        child: FavoritesScreen(),
                      ),
                    );
                  } else if (state is SearchLoading) {
                    return LinearProgress();
                  } else if (state is MovieLoaded) {
                    return AnimatedContainer(
                      duration: myDuration,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SearchScreen(state.movie),
                      ),
                    );
                  } else if (state is SearchEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomDisplayError(
                        title: 'Empty',
                        message: state.message,
                      ),
                    );
                  } else if (state is SearchError) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomDisplayError(
                        title: 'Server Error',
                        message: state.message,
                      ),
                    );
                  }

                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
