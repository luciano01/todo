import 'package:flutter/material.dart';

class FabWidget extends StatelessWidget {
  final void Function()? onPressed;
  final bool mini;
  final IconData iconData;
  const FabWidget({
    Key? key,
    required this.onPressed,
    required this.mini,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: mini,
      child: Icon(iconData),
      onPressed: onPressed,
    );
  }
}
