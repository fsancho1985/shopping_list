import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CadastroAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CadastroAppBar({ super.key });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.green.shade600,
      foregroundColor: Colors.orange.shade100,
      title: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: const Text(
              'Lista de Compras',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8)
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);


}