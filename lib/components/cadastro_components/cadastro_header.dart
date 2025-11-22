import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CadastroHeader extends StatelessWidget {
  const CadastroHeader({ super.key });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 6.0,
      ),
      child: const Text(
        'Criar Conta',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Color.fromARGB(255, 105, 102, 102),
        ),
      ),
    );
  }
  
  
}