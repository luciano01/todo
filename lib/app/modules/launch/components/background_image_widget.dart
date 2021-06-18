import 'package:flutter/material.dart';

class BackgroundImageWidget extends StatelessWidget {
  const BackgroundImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/iconBlue900.png',
      width: 313,
      color: Color.fromRGBO(000, 000, 000, 0.05),
    );
  }
}
