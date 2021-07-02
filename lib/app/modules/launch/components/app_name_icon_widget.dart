import 'package:flutter/material.dart';

class AppNameIconWidget extends StatelessWidget {
  const AppNameIconWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'TOD',
          style: TextStyle(
            fontSize: 70,
            color: Color(0xFF212121),
          ),
        ),
        SizedBox(width: 3),
        Image.asset(
          'assets/images/icon.png',
          width: 55,
        ),
      ],
    );
  }
}
