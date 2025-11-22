

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/compra.dart';
import '../models/lista_compra.dart';
import '../models/produto.dart';
import '../services/database_service.dart';
import '../services/sessao_service.dart';

class ResumoTela extends StatefulWidget {
  const ResumoTela({super.key});

  @override
  State<ResumoTela> createState() => _ResumoTelaState();
}

class _ResumoTelaState extends State<ResumoTela> {
  List<Compra> compras = [];
  Map<int, Produto> produtosMap = {};
  bool _carregando = true;
  bool _mostrarComprados = false;
  // ignore: unused_field
  ListaCompra? _listaAtiva;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    try {
      final compraDao = await DatabaseService.compraDao;
      final produtoDao = await DatabaseService.produtoDao;
      final listaCompraDao = await DatabaseService.listaCompraDao;

      final listaAtiva = await listaCompraDao.getListaAtiva();

      if (listaAtiva != null) {
        final listaCompras = await compraDao.getComprasPorLista(listaAtiva.id!);
        final listaProdutos = await produtoDao.getTodosProdutos();

        final mapaProdutos = {for (var p in listaProdutos) p.id!: p};

        setState(() {
          compras = listaCompras;
          produtosMap = mapaProdutos;
          _listaAtiva = listaAtiva;
          _carregando = false;
        });
      } else {
        setState(() {
          _carregando = false;
          compras = [];
          produtosMap = {};
        });
      }
    } catch (e) {
      setState(() => _carregando = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao carregar dados: $e')));
    }
  }

  Future<void> marcarComoComprado(int id) async {
    try {
      final compraDao = await DatabaseService.compraDao;
      await compraDao.marcarComoComprado(id);
      await carregarDados();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao marcar como comprado: $e')),
      );
    }
  }

  //-começo-----------
  /*
  Future<void> _atualizarStatusCompra(int id, bool comprado) async {
    try {
      final compraDao = await DatabaseService.compraDao;

      if (comprado) {
        await compraDao.marcarComoComprado(id);
      } else {
        await compraDao.marcarComoPendente(
          id,
        );
      }

      await carregarDados();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao atualizar status: $e')));
    }
  }
*/
  Future<void> marcarComoPendente(int id) async {
    try {
      final compraDao = await DatabaseService.compraDao;
      await compraDao.marcarComoPendente(id);
      await carregarDados();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao desmarcar como comprado: $e')),
      );
    }
  }

  //-fim-----------------------------
  Future<void> _excluirCompra(int id) async {
    try {
      final compraDao = await DatabaseService.compraDao;
      await compraDao.deleteCompra(id);
      await carregarDados();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Item removido da lista')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao excluir item: $e')));
    }
  }

  //Filtrar compras pendentes
  List<Compra> get comprasPendentes {
    return compras.where((compra) => !compra.comprado).toList();
  }

  //Filtrar compras finalizadas
  List<Compra> get comprasFinalizadas {
    return compras.where((compra) => compra.comprado).toList();
  }

  //Limpar itens comprados
  Future<void> _limparItensComprados() async {
    try {
      final compraDao = await DatabaseService.compraDao;
      for (var compra in comprasFinalizadas) {
        await compraDao.deleteCompra(compra.id!);
      }
      await carregarDados();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Itens comprados removidos')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao limpar itens: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final comprasParaMostrar = _mostrarComprados ? compras : comprasPendentes;
    final itensComprados = comprasFinalizadas.length;

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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            /*
            if (_listaAtiva != null)
              Text(
                'Lista: ${_listaAtiva!.nome}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
*/
            //Informações sobre qual tela está em uso (código)
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: Text(
            //     'resumo_tela',
            //     style: TextStyle(fontSize: 8, fontWeight: FontWeight.normal),
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
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          if (compras.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.grey[100],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatCard(
                        'Pendentes',
                        comprasPendentes.length,
                        Colors.orange,
                      ),
                      const SizedBox(width: 15),
                      _buildStatCard(
                        'Comprados',
                        itensComprados,
                        Colors.green,
                      ),
                      const SizedBox(width: 15),
                      _buildStatCard(
                        'Total',
                        compras.length,
                        Colors.blue,
                      ),
                      const SizedBox(width: 20),

                      if (itensComprados > 0)
                        IconButton(
                          icon: Icon(
                            _mostrarComprados
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey[600],
                          ),
                          onPressed: () {
                            setState(() {
                              _mostrarComprados = !_mostrarComprados;
                            });
                          },
                          tooltip: _mostrarComprados
                              ? 'Ocultar Comprados'
                              : 'Mostrar Comprados',
                        ),

                      // IconButton(
                      //   icon: Icon(
                      //     Icons.refresh,
                      //     color: Colors.grey[600],
                      //   ),
                      //   onPressed: carregarDados,
                      //   tooltip: 'Atualizar',
                      // ),
                    ],
                  ),
                ),
              ),
            ),

          if (itensComprados > 0 && _mostrarComprados)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.cleaning_services),
                label: const Text('Limpar Itens Comprados'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: _limparItensComprados,
              ),
            ),

          Expanded(
            child: comprasParaMostrar.isEmpty
                ? const Center(
              child: Text(
                'Nenhum item na lista de compras\nVá para "Compras" para adicionar itens',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            )
                : ListView.builder(
              itemCount: comprasParaMostrar.length,
              itemBuilder: (_, index) {
                final c = comprasParaMostrar[index];
                final produto = produtosMap[c.produtoId];
                final nome =
                    produto?.nome_Produto ??
                        'Produto não encontrado';
                final unidade = produto?.unidade ?? '';
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  color: c.comprado ? Colors.grey[100] : null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: c.comprado,
                          onChanged: (value) {
                            if (value == true) {
                              marcarComoComprado(c.id!);
                            } else {
                              marcarComoPendente(c.id!);
                            }
                          },
                        ),

                        Expanded(
                          child: Text(
                            '$nome ->  ${c.quantidade.toInt()} $unidade',
                            style: TextStyle(
                              decoration: c.comprado
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: c.comprado
                                  ? Colors.grey[600]
                                  : Colors.black,
                              fontWeight: c.comprado
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        c.comprado
                            ? const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.0,
                          ),
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                        )
                            : IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () =>
                              _excluirCompra(c.id!),
                        ),
                      ],
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
    );
  }

  //Widget para estatísticas
  Widget _buildStatCard(String title, int count, Color color) {
    return Column(
      children: [
        Text(
          '$count',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(title, style: const TextStyle(fontSize: 11.0, color: Colors.grey)),
      ],
    );
  }
}
