import 'package:flutter/material.dart';

class LogoSection extends StatelessWidget {
  const LogoSection({ super.key });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 24.0),
      child: Image(
        image: AssetImage('assets/logo.jpg'),
        width: 400,
        height: 300,
        fit: BoxFit.contain,
      ),
    );
  }


}