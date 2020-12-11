import 'package:flutter/material.dart';

class TransparentHolder extends StatelessWidget {
  final String label;
  final double size;

  TransparentHolder({this.label = '', this.size = 25});

  @override
  Widget build(BuildContext context) {
    return new Container(
      //alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: new Text(
        label.trim(),
        style: TextStyle(
            fontSize: size, color: Colors.white,
            fontFamily: "Quicksand"
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
