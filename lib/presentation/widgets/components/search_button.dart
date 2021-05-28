import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/icon.dart';
import '../../cubit/home/home_cubit.dart';
import 'package:sizer/sizer.dart';

class SearchButton extends StatefulWidget {
  const SearchButton({
    Key key,
  }) : super(key: key);

  @override
  _SearchButtonState createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  bool _folded = true;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      width: _folded ? 50 : 50.0.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: CONTAINER_COLOR,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: _folded
                  ? null
                  : Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextField(
                        onSubmitted: (query) => context.read<HomeCubit>()
                          ..searchMovies(query: query),
                        style: GoogleFonts.quicksand(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search Movies...',
                          hintStyle: GoogleFonts.quicksand(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                          border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 600),
            child: IconButton(
              onPressed: () {
                setState(() {
                  _folded = !_folded;
                });
              },
              icon: _folded ? SEARCH_ICON : CLOSE_ICON,
            ),
          )
        ],
      ),
    );
  }
}
