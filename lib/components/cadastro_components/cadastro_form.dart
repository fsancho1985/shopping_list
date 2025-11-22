import 'package:app_shopping_list/components/cadastro_components/cep_field_auto_busca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cadastro_text_field.dart';

class CadastroForm extends StatelessWidget {
  final TextEditingController nomeController;
  final TextEditingController emailController;
  final TextEditingController senhaController;
  final TextEditingController cepController;
  final TextEditingController logradouroController;
  final TextEditingController numeroController;
  final TextEditingController bairroController;
  final TextEditingController cidadeController;
  final TextEditingController estadoController;
  final TextEditingController ufController;
  final bool carregando;
  final VoidCallback onBuscarEndereco;
  final VoidCallback onCadastrar;

  const CadastroForm({
    super.key,
    required this.nomeController,
    required this.emailController,
    required this.senhaController,
    required this.cepController,
    required this.logradouroController,
    required this.numeroController,
    required this.bairroController,
    required this.cidadeController,
    required this.estadoController,
    required this.ufController,
    required this.carregando,
    required this.onBuscarEndereco,
    required this.onCadastrar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CadastroTextField(
          controller: nomeController,
          label: 'Nome',
          hint: 'Digite seu nome',
        ),
        const SizedBox(height: 8),
        CadastroTextField(
          controller: emailController,
          label: 'E-mail',
          hint: 'Digite seu e-mail',
          keyboartType: TextInputType.emailAddress
        ),
        const SizedBox(height: 8),
        CadastroTextField(
          controller: senhaController,
          label: 'Senha',
          hint: 'Digite a sua senha',
          obscureText: true,
        ),
        const SizedBox(height: 8),
        CepFieldAutoBusca(cepController: cepController, onBuscar: onBuscarEndereco),
        const SizedBox(height: 8),
        CadastroTextField(controller: logradouroController, label: 'Rua', keyboartType: TextInputType.text),
        const SizedBox(height: 8),
        CadastroTextField(
          controller: numeroController,
          label: 'Número',
          keyboartType: TextInputType.number,
        ),
        const SizedBox(height: 8),
        CadastroTextField(
          controller: bairroController,
          label: 'Bairro'
        ),
        const SizedBox(height: 8),
        CadastroTextField(controller: cidadeController, label: 'Cidade'),
        const SizedBox(height: 8),
        CadastroTextField(controller: estadoController, label: 'Estado'),
        const SizedBox(height: 8),
        CadastroTextField(controller: ufController, label: 'uf'),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: carregando ? null : onCadastrar,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange.shade200,
            foregroundColor: Colors.grey.shade800,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            textStyle: const TextStyle(fontSize: 16),
          ),
          child: carregando ? const CircularProgressIndicator() : const Text('Cadastrar'),
        ),
      ],
    );
  }
}