import 'package:flutter/material.dart';

class AppBarTitleWidget extends StatelessWidget {
  final String? today;
  const AppBarTitleWidget({Key? key, this.today}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Today ',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
        children: [
          TextSpan(
            text: today,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
