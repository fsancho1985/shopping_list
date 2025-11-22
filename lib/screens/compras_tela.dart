

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/compra.dart';
import '../models/lista_compra.dart';
import '../models/produto.dart';
import '../services/database_service.dart';
import '../services/sessao_service.dart';

class ComprasTela extends StatefulWidget {
  const ComprasTela({super.key});

  @override
  State<ComprasTela> createState() => _ComprasTelaState();
}

class _ComprasTelaState extends State<ComprasTela> {
  List<Produto> produtos = [];
  Map<int, bool> selecionados = {};
  Map<int, TextEditingController> quantidadeControllers = {};
  bool _carregando = true;
  ListaCompra? _listaAtiva;
  List<Compra> _comprasExistentes = []; // Para armazenar compras já existentes

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    try {
      final produtoDao = await DatabaseService.produtoDao;
      final listaCompraDao = await DatabaseService.listaCompraDao;
      final compraDao = await DatabaseService.compraDao;

      final listaAtiva = await listaCompraDao.getListaAtiva();
      final listaProdutos = await produtoDao.getTodosProdutos();

      // Carregar compras existentes se houver lista ativa
      List<Compra> comprasExistentes = [];
      if (listaAtiva != null) {
        comprasExistentes = await compraDao.getComprasBasicasPorLista(
          listaAtiva.id!,
        );
      }

      setState(() {
        produtos = listaProdutos;
        _listaAtiva = listaAtiva;
        _comprasExistentes = comprasExistentes;

        // Inicializar selecionados e controllers
        for (var p in listaProdutos) {
          final id = p.id!;

          // Verificar se o produto já está na lista de compras
          final compraExistente = comprasExistentes.firstWhere(
                (compra) => compra.produtoId == id,
            orElse: () => Compra(produtoId: -1, quantidade: 0, listaId: -1),
          );

          selecionados[id] = compraExistente.produtoId != -1;
          quantidadeControllers[id] = TextEditingController(
            text: compraExistente.produtoId != -1
                ? compraExistente.quantidade.toString()
                : '',
          );
        }

        _carregando = false;
      });
    } catch (e) {
      setState(() => _carregando = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao carregar dados: $e')));
    }
  }

  Future<void> salvarCompras() async {
    if (_listaAtiva == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nenhuma lista ativa encontrada')),
      );
      return;
    }

    try {
      final compraDao = await DatabaseService.compraDao;
      int itensSalvos = 0;
      int itensAtualizados = 0;

      for (var produto in produtos) {
        final id = produto.id!;
        final quantidade =
            double.tryParse(quantidadeControllers[id]!.text) ?? 0;

        // Verificar se o produto já existe nas compras
        final compraExistenteIndex = _comprasExistentes.indexWhere(
              (compra) => compra.produtoId == id,
        );

        if (selecionados[id] == true && quantidade > 0) {
          final compra = Compra(
            produtoId: id,
            quantidade: quantidade,
            listaId: _listaAtiva!.id!,
            comprado: false,
          );

          if (compraExistenteIndex != -1) {
            // Atualizar compra existente usando copyWith
            final compraAtualizada = _comprasExistentes[compraExistenteIndex]
                .copyWith(quantidade: quantidade);
            await compraDao.updateCompra(compraAtualizada);
            itensAtualizados++;
          } else {
            // Inserir nova compra
            await compraDao.insertCompra(compra);
            itensSalvos++;
          }
        } else if (compraExistenteIndex != -1) {
          // Remover compra se foi desmarcada
          await compraDao.deleteCompra(
            _comprasExistentes[compraExistenteIndex].id!,
          );
        }
      }

      String mensagem = '';
      if (itensSalvos > 0 && itensAtualizados > 0) {
        mensagem =
        '$itensSalvos itens salvos e $itensAtualizados itens atualizados na lista "${_listaAtiva!.nome}"!';
      } else if (itensSalvos > 0) {
        mensagem = '$itensSalvos itens salvos na lista "${_listaAtiva!.nome}"!';
      } else if (itensAtualizados > 0) {
        mensagem =
        '$itensAtualizados itens atualizados na lista "${_listaAtiva!.nome}"!';
      } else {
        mensagem = 'Nenhum item salvo na lista "${_listaAtiva!.nome}"!';
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(mensagem)));

      // Navegar para resumo após salvar
      Navigator.pushReplacementNamed(context, '/resumo');
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao salvar compras: $e')));
    }
  }

  @override
  void dispose() {
    // Dispose dos controllers para evitar memory leaks
    for (var controller in quantidadeControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade600,
        foregroundColor: Colors.orange.shade100,
/*
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
*/
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
            //     'compras_tela',
            //     style: TextStyle(fontSize: 6, fontWeight: FontWeight.normal),
            //   ),
            // ),
            SizedBox(height: 8.0),
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
          : produtos.isEmpty
          ? const Center(child: Text('Nenhum produto cadastrado'))
          : Column(
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
              'Selecionar Produtos',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 105, 102, 102),
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (_listaAtiva != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Lista: ${_listaAtiva!.nome}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: produtos.length,
              itemBuilder: (_, index) {
                final p = produtos[index];
                final id = p.id!;
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: ListTile(
                    leading: Checkbox(
                      value: selecionados[id] ?? false,
                      onChanged: (value) {
                        setState(() {
                          selecionados[id] = value!;
                        });
                      },
                    ),
                    title: Text(p.nomeProduto),
                    subtitle: Text('Unidade: ${p.unidade}'),
                    trailing: SizedBox(
                      width: 80,
                      child: TextField(
                        controller: quantidadeControllers[id],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Qtd',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                );
              },
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: salvarCompras,
        label: const Text('Salvar na Lista'),
        icon: const Icon(Icons.save),
      ),
    );
  }
}
