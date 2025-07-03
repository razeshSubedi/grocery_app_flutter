import 'package:flutter/material.dart';

class AppLoadingIndicator extends StatelessWidget {
  final Color backgroundColor;
  final Color indicatorColor;

  const AppLoadingIndicator({
    super.key,
    this.backgroundColor = Colors.white,
    this.indicatorColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: CircularProgressIndicator(
          color: indicatorColor,
        ),
      ),
    );
  }
}
