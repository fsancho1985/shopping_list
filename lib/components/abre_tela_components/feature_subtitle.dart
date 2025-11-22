import 'package:flutter/material.dart';

class FeatureSubtitle extends StatelessWidget {
  const FeatureSubtitle({ super.key });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(6.0),
      child: Text(
        'Recursos pensados para facilitar sua vida',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Color.fromARGB(255, 105, 102, 102),
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }


}