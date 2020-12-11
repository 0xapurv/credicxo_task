
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final String imgUrl;
  Background({this.imgUrl = 'assets/bg.png'});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Image.asset(imgUrl, fit: BoxFit.cover,),
    );
  }

}
