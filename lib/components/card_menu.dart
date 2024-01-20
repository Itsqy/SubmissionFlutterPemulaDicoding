import 'package:flutter/material.dart';

class CardMenu extends StatelessWidget {
  final Color colorMenu;
  final IconData iconMenu;
  final String screenName;
  const CardMenu({
    super.key,
    required this.colorMenu,
    required this.iconMenu,
    required this.screenName,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, screenName);
        },
        icon: Container(
          width: 50,
          height: 35,
          decoration: BoxDecoration(
            color: colorMenu,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ), // Adjust radius as desired
          ),
          child: Icon(
            iconMenu,
            color: Colors.white,
          ),
        ));
  }
}
