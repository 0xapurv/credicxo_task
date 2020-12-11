import 'package:flutter/material.dart';

class ApiError extends StatefulWidget {
  @override
  _ApiErrorState createState() => _ApiErrorState();
}

class _ApiErrorState extends State<ApiError> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text("API Error")),
      body: Center(
        child: Text("Response body is empty"),
      ),
    );
  }
}
