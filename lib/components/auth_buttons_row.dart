import 'package:app_shopping_list/components/auth_button.dart';
import 'package:flutter/material.dart';

class AuthButtonsRow extends StatelessWidget {
  const AuthButtonsRow({ super.key });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: AuthButton(
                label: 'Fazer login',
                backgroundColor: Colors.green.shade200,
                foregroundColor: Colors.grey.shade800,
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
          ),
          const SizedBox(width: 2),
          Expanded(
              child: AuthButton(
                label: 'Criar conta',
                backgroundColor: Colors.red.shade200,
                foregroundColor: Colors.grey.shade800,
                onPressed: () {
                  Navigator.pushNamed(context, '/cadastro');
                }
              )
          )
        ],
      ),
    );
  }


}