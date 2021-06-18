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
            color: Colors.white,
          ),
        ),
        Image.asset(
          'assets/images/iconWhite.png',
          width: 50,
        ),
      ],
    );
  }
}
