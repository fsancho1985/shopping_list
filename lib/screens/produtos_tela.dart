

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/produto.dart';
import '../services/database_service.dart';
import '../services/sessao_service.dart';

class ProdutosTela extends StatefulWidget {
  const ProdutosTela({super.key});

  @override
  State<ProdutosTela> createState() => _ProdutosTelaState();
}

class _ProdutosTelaState extends State<ProdutosTela> {
  List<Produto> produtos = [];
  final nomeController = TextEditingController();
  final unidadeController = TextEditingController();
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    carregarProdutos();
  }

  Future<void> carregarProdutos() async {
    try {
      final produtoDao = await DatabaseService.produtoDao;
      final lista = await produtoDao.getTodosProdutos();
      setState(() {
        produtos = lista;
        _carregando = false;
      });
    } catch (e) {
      setState(() => _carregando = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao carregar produtos: $e')));
    }
  }

  Future<void> salvarProduto({Produto? produto}) async {
    try {
      final produtoDao = await DatabaseService.produtoDao;

      final novo = Produto(
        id: produto?.id,
        nome_Produto: nomeController.text.trim(),
        unidade: unidadeController.text.trim(),
      );

      if (produto == null) {
        await produtoDao.insertProduto(novo);
      } else {
        await produtoDao.updateProduto(novo);
      }

      nomeController.clear();
      unidadeController.clear();
      carregarProdutos();
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Produto ${produto == null ? 'cadastrado' : 'atualizado'} com sucesso!',
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao salvar produto: $e')));
    }
  }

  void abrirFormulario({Produto? produto}) {
    if (produto != null) {
      nomeController.text = produto.nome_Produto;
      unidadeController.text = produto.unidade;
    } else {
      nomeController.clear();
      unidadeController.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(produto == null ? 'Novo Produto' : 'Editar Produto'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome do Produto'),
            ),
            TextField(
              controller: unidadeController,
              decoration: const InputDecoration(
                labelText: 'Unidade (ex: kg, un, litro)',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => salvarProduto(produto: produto),
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  Future<void> excluirProduto(int id) async {
    try {
      final produtoDao = await DatabaseService.produtoDao;
      await produtoDao.deleteProduto(id);
      await carregarProdutos();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produto excluído com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao excluir produto: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade600,
        foregroundColor: Colors.orange.shade100,

        title: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Lista de Compras',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            //Informações sobre qual tela está em uso (código)
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: Text(
            //     'produtos_tela',
            //     style: TextStyle(fontSize: 6, fontWeight: FontWeight.normal),
            //   ),
            // ),
            SizedBox(height: 8),
          ],
        ),

        actions: [
          // Informações do usuário logado
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Icon(Icons.person, color: Colors.orange.shade100, size: 18),
                const SizedBox(width: 6),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      SessaoService.nomeUsuario ?? 'Usuário',
                      style: TextStyle(
                        color: Colors.orange.shade100,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    /*
                    Text(
                      SessaoService.emailUsuario ?? '',
                      style: TextStyle(
                        color: Colors.orange.shade100,
                        fontSize: 9,
                      ),
                    ),
*/
                  ],
                ),
              ],
            ),
          ),
          /*
          // Botão de logout
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _fazerLogout,
            tooltip: 'Sair',
          ),
*/
        ],
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        padding: const EdgeInsets.all(8),
        children: [
          const SizedBox(height: 8),
          Container(
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
              'Produtos',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 105, 102, 102),
              ),
            ),
          ),
          const SizedBox(height: 16),

          //Área de Produtos
          if (produtos.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Nenhum produto cadastrado\nClique no + para adicionar',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          else
            ...produtos.map(
                  (p) => Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: ListTile(
                  title: Text(p.nome_Produto),
                  subtitle: Text('Unidade: ${p.unidade}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => abrirFormulario(produto: p),
                        tooltip: 'Editar',
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => excluirProduto(p.id!),
                        tooltip: 'Excluir',
                      ),
                    ],
                  ),
                ),
              ),
            ),

          const SizedBox(height: 40),
          Container(
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => abrirFormulario(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
