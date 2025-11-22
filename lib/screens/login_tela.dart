import 'package:app_shopping_list/components/cadastro_components/cadastro_app_bar.dart';
import 'package:app_shopping_list/components/login_components/login_app_bar.dart';
import 'package:app_shopping_list/components/login_components/login_footer.dart';
import 'package:app_shopping_list/components/login_components/login_form.dart';
import 'package:app_shopping_list/components/login_components/login_header.dart';
import 'package:app_shopping_list/services/database_service.dart';
import 'package:app_shopping_list/services/sessao_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginTela extends StatefulWidget {
  const LoginTela({ super.key });

  @override
  State<LoginTela> createState() {
    return _LoginTela();
  }
}
  class _LoginTela extends State<LoginTela> {
    final emailController = TextEditingController();
    final senhaController = TextEditingController();
    bool _carregando = false;

    @override
    void initState() {
      super.initState();
      _verificarSessaoAtiva();
    }

    void _verificarSessaoAtiva() {
      if (SessaoService.estadoLogado) {
        Future.delayed(Duration.zero, () {
          Navigator.pushReplacementNamed(context, '/home');
        });
      }
    }

    Future<void> fazerLogin() async {
      if (_carregando) return;

      final email = emailController.text.trim();
      final senha = senhaController.text;

      if (email.isEmpty || senha.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Preencha e-mail e senha!')));
        return;
      }

      setState(() => _carregando = true);

      try {
        final usuarioDao = await DatabaseService.usuarioDao;
        final usuario = await usuarioDao.getUsuarioPorEmail(email);

        if (usuario != null && usuario.senha == senha) {
          SessaoService.login(usuario);

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Bem Vindo, ${usuario.nome}'),
                  backgroundColor: Colors.green
              )
          );

          Navigator.pushReplacementNamed(context, '/home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('E-mail ou senha inválida!'
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao fazer login: $error'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() => _carregando = false);
      }
    }

    void _irParaCadastro() {
      Navigator.pushNamed(context, '/cadastro');
    }

    void _recuperarSenha() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Recuperar Senha'),
            content: const Text(
              'Entre em contato com o administrador do sistema para recuperar a senha.',
            ),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop, child: const Text('Ok'),),
            ],
          );
        }
      );
    }

    @override
    void dispose() {
      emailController.dispose();
      senhaController.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    if (SessaoService.estadoLogado) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: const LoginAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            LoginHeader(),
            const SizedBox(height: 40),
            Icon(Icons.person, size: 80, color: Colors.green.shade600),
            const SizedBox(height: 20),
            LoginForm(
                emailController: emailController,
                senhaController: senhaController,
                carregando: _carregando,
                onIrParaCadastro: _irParaCadastro,
                onLogin: () => fazerLogin(),
                onRecuperarSenha: _recuperarSenha
            ),
            const SizedBox(height: 60),
            LoginFooter(),
          ],
        ),
      ),
    );
  }


  }


