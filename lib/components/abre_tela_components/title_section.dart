import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({ super.key });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: 'Organize suas compras de forma',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: ' inteligente',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade400
            ),
          )
        ]
      ),
      textAlign: TextAlign.justify,
    );
  }


}