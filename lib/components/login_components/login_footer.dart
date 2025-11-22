import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({ super.key });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green.shade300,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 6.0
      ),
      child: const Text(
        '©Copyright - 2025 DSM - PDM Dev - Direitos reservados',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10,
          color: Color.fromARGB(255, 105, 102, 102),
        ),
      ),
    );
  }
  
  
}