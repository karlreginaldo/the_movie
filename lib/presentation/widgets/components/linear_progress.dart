import 'package:flutter/material.dart';
import '../../../core/constant/color.dart';

class LinearProgress extends StatelessWidget {
  const LinearProgress({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Colors.green,
      valueColor: AlwaysStoppedAnimation<Color>(SCAFFOLD_COLOR),
    );
  }
}
