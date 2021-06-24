import 'package:flutter/material.dart';

class AppBarTitleWidget extends StatelessWidget {
  final String? monthName;
  final int? day;
  const AppBarTitleWidget({
    Key? key,
    this.monthName,
    this.day,
  }) : super(key: key);

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
            text: '$monthName, $day',
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
