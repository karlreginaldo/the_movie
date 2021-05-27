import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  const CircularProgress({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
      ),
    );
  }
}
