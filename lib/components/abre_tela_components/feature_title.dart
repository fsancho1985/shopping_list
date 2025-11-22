import 'package:flutter/material.dart';

class FeatureTitle extends StatelessWidget {
  const FeatureTitle({ super.key });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(6.0),
      child: Text(
        'Tudo o que você precisa',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 105, 102, 102),
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }


}