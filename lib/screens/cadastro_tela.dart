

import 'package:app_shopping_list/services/apiservices.dart';
import 'package:app_shopping_list/services/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../components/cadastro_components/cadastro_app_bar.dart';
import '../components/cadastro_components/cadastro_form.dart';
import '../components/cadastro_components/cadastro_header.dart';
import '../models/usuario.dart';

class CadastroTela extends StatefulWidget {
  const CadastroTela({ super.key });

  @override
  State<CadastroTela> createState() {
    return _CadastroTela();
  }

  }
  class _CadastroTela extends State<CadastroTela> {
    final cepController = TextEditingController();
    final nomeController = TextEditingController();
    final emailController = TextEditingController();
    final senhaController = TextEditingController();
    final logradouroController = TextEditingController();
    final numeroController = TextEditingController();
    final bairroController = TextEditingController();
    final cidadeController = TextEditingController();
    final estadoController = TextEditingController();
    final ufController = TextEditingController();

    bool _carregando = false;

    Future<void> buscarEndereco() async {
      final cep = cepController.text.replaceAll(RegExp(r'\D'), '');
      if (cep.length != 8) return;

      try {
        final dados = await ApiServices.getDadosPorCep(cep: cep);

        setState(() {
          logradouroController.text = dados.logradouro;
          bairroController.text = dados.bairro;
          cidadeController.text = dados.localidade;
          estadoController.text = dados.estado;
          ufController.text = dados.uf;
        });
      } catch (error) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          SnackBar(content: Text('Erro ao buscar endereço: $error')),
        );
      }
    }

    Future<void> cadastrarUsuario() async {
      if(_carregando) return;

      setState(() {
        _carregando = true;
      });

      try {
        final usuarioDao = await DatabaseService.usuarioDao;

        final usuarioExistente = await usuarioDao.getUsuarioPorEmail(emailController.text);

        if (usuarioExistente != null) {
          ScaffoldMessenger.of(
              context
          ).showSnackBar(
            const SnackBar(content: Text('E-mail já cadastrado!'))
          );
          return;
        }

        final usuario = Usuario(
          nome: nomeController.text,
          email: emailController.text,
          senha: senhaController.text,
          cep: cepController.text,
          logradouro: logradouroController.text,
          numero: numeroController.text,
          bairro: bairroController.text,
          cidade: cidadeController.text,
          estado: estadoController.text,
          uf: ufController.text
        );

        await usuarioDao.insertUsuario(usuario);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cadastro realizado com sucesso!'))
        );

        Navigator.pop(context);
      } catch (error) {
        ScaffoldMessenger.of(
          context
        ).showSnackBar(SnackBar(content: Text('Erro ao cadastrar: $error')));
      } finally {
        setState(() {
          _carregando = false;
        });
      }
    }

    @override
    void dispose() {
      cepController.dispose();
      nomeController.dispose();
      emailController.dispose();
      senhaController.dispose();
      logradouroController.dispose();
      numeroController.dispose();
      bairroController.dispose();
      cidadeController.dispose();
      estadoController.dispose();
      ufController.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CadastroAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            const CadastroHeader(),
            const SizedBox(height: 16),
            CadastroForm(
              nomeController: nomeController,
              emailController: emailController,
              senhaController: senhaController,
              cepController: cepController,
              logradouroController: logradouroController,
              numeroController: numeroController,
              bairroController: bairroController,
              cidadeController: cidadeController,
              estadoController: estadoController,
              ufController: ufController,
              carregando: _carregando,
              onBuscarEndereco: () { buscarEndereco(); },
              onCadastrar: () { cadastrarUsuario(); },
            ),
            // const SizedBox(height: 40),
            // const CadastroFooter(),
          ],
        ),
      )
    );
  }

  }


