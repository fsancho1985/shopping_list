import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({ super.key });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 6.0,
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