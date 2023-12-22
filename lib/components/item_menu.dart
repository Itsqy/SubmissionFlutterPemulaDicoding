import 'package:flutter/material.dart';

Widget itemMenu(String name, String imgItem) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Image(
          image: AssetImage(imgItem),
          fit: BoxFit.contain,
          height: 75,
          width: 75,
        ),
        Text(name),
      ],
    ),
  );
}
