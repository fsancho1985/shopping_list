import 'package:flutter/material.dart';

class SubtitleSection extends StatelessWidget {
  const SubtitleSection({ super.key });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Text(
        'Crie listas de compras e nunca esqueça de nada no supermercado',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 105, 102, 102),
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }


}