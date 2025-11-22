import 'package:app_shopping_list/components/login_components/login_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController senhaController;
  final bool carregando;
  final VoidCallback onIrParaCadastro;
  final VoidCallback onRecuperarSenha;
  final VoidCallback onLogin;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.senhaController,
    required this.carregando,
    required this.onIrParaCadastro,
    required this.onLogin,
    required this.onRecuperarSenha,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoginTextField(
          controller: emailController,
          label: 'E-mail',
          hint: 'Digite seu e=-mail',
          prefixIcon: Icons.email,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        LoginTextField(
          controller: senhaController,
          label: 'Senha',
          hint: 'Digite a sua senha',
          prefixIcon: Icons.lock,
          obscureText: true,
          onSubmitted: (_) => onLogin(),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
              onPressed: onRecuperarSenha,
              child: Text('Esqueceu a senha?',
                style: TextStyle(fontSize: 12),
            ),
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
              onPressed: carregando ? null : onLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade200,
                foregroundColor: Colors.grey.shade800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
                ),
              ),
              child: carregando ?
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ) : const Text('Entrar', style: TextStyle(fontSize: 16)),
          ),
        ),
        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade400)),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'ou',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey.shade400),)
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: onIrParaCadastro,
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              side: BorderSide(color: Colors.green.shade600),
            ),
            child: Text(
              'Criar nova conta',
              style: TextStyle(
                fontSize: 16,
                color: Colors.green.shade600
              ),
            )
          ),
        )
      ],
    );
  }


}