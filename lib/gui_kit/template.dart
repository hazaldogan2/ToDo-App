import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class ElevatedButtonTemplate extends StatelessWidget {
  const ElevatedButtonTemplate(
      {Key? key, required this.height, required this.width, required this.child, required this.color, required this.onPressed, required this.boxShadowColor, required this.elevation})
      : super(key: key);
  final double height;
  final double width;
  final Widget child;
  final Color color;
  final Color boxShadowColor;
  final VoidCallback onPressed;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        child: Center(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              elevation: elevation,
              shadowColor: Colors.transparent,
              fixedSize: Size(width, height),
              padding: EdgeInsets.zero,
              //primary: color,
              backgroundColor: color,
            ),
            child: child,
          ),
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: boxShadowColor, offset: const Offset(3, 3), blurRadius: 6, spreadRadius: 0)],
        ));
  }
}

class TextElevatedButtonTemplate extends StatelessWidget {
  const TextElevatedButtonTemplate({
    Key? key,
    required this.height,
    required this.width,
    required this.text,
    required this.textStyle,
    required this.color,
    required this.onPressed,
    required this.boxShadowColor,
    required this.elevation,
    this.child = const SizedBox(width: 0, height: 0),
  }) : super(key: key);

  final double height;
  final double width;
  final String text;
  final TextStyle textStyle;
  final Color color;
  final Color boxShadowColor;
  final VoidCallback onPressed;
  final double elevation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonTemplate(
      height: height,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          child,
          Text(text, style: textStyle),
        ],
      ),
      color: color,
      boxShadowColor: boxShadowColor,
      onPressed: onPressed,
      elevation: elevation,
    );
  }
}
