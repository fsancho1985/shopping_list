import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({ super.key });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            'Lista de Compras',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        // Align(
        //   alignment: Alignment.topLeft,
        //   child: Text(
        //     'abre_tela',
        //     style: TextStyle(
        //       fontSize: 6,
        //       fontWeight: FontWeight.normal,
        //     ),
        //   ),
        // )
      ],
    );
  }
}