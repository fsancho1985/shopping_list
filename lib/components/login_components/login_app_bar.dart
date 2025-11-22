import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LoginAppBar({ super.key });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.green.shade600,
      foregroundColor: Colors.orange.shade100,
      title: Stack(
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text('Lista de Compras', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);


}