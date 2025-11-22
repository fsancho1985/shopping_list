import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/sessao_service.dart';

class HomeTela extends StatefulWidget {
  const HomeTela({super.key});

  @override
  State<HomeTela> createState() => _HomeTelaState();
}

class _HomeTelaState extends State<HomeTela> {
  void _fazerLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sair do Aplicativo'),
          content: const Text('Tem certeza que deseja encerrar a sessão?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                SessaoService.logout();
                Navigator.of(context).pop();
                // Navegar para tela de abertura do app
                Navigator.pushReplacementNamed(context, '/abre');
              },
              child: const Text('Sair', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _verificarSessaoERedirecionar() {
    if (!SessaoService.estadoLogado) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, '/login');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _verificarSessaoERedirecionar();
  }

  @override
  Widget build(BuildContext context) {
    // Verificação adicional durante o build
    if (!SessaoService.estadoLogado) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

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
            //Informações sobre qual tela está em uso (código)
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: Text(
            //     'home_tela',
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
          // Botão de logout
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _fazerLogout,
            tooltip: 'Sair',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Card de Produtos
          Card(
            elevation: 4,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/produtos');
              },
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(Icons.shopping_bag, size: 50, color: Colors.green),
                    SizedBox(height: 10),
                    Text(
                      'Gerenciar Produtos',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Cadastrar e editar produtos',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Card 2 - Fazer Lista de Compras
          Card(
            elevation: 4,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/compras');
              },
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(Icons.shopping_cart, size: 50, color: Colors.blue),
                    SizedBox(height: 10),
                    Text(
                      'Fazer Lista de Compras',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Selecionar produtos para comprar',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Card 3 - Lista atual
          Card(
            elevation: 4,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/resumo');
              },
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(Icons.list_alt, size: 50, color: Colors.orange),
                    SizedBox(height: 10),
                    Text(
                      'Ver Lista Atual',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Visualizar e gerenciar itens da lista',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          //Ajustar esse método, não está funcionando como esperado, na próxima versão
          /*
          // Card 4 - Listas existentes
          Card(
            elevation: 4,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/listas');
              },
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(Icons.list_alt, size: 50, color: Colors.purple),
                    SizedBox(height: 10),
                    Text(
                      'Ver Lista Existentes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Visualizar e gerenciar listas',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
*/
          const SizedBox(height: 50),

          /*
          // Informações adicionais do usuário (desnecessário, por enquanto, precisa de ajustes, na próxima versão)
          if (SessaoService.estaLogado && SessaoService.enderecoUsuario != null)
            Card(
              elevation: 2,
              color: Colors.green.shade50,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Seus Dados',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Localização: ${SessaoService.enderecoUsuario!['cidade']} - ${SessaoService.enderecoUsuario!['uf']}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Endereço: ${SessaoService.enderecoUsuario!['logradouro']}, ${SessaoService.enderecoUsuario!['numero']}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
*/
          const SizedBox(height: 40),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.green.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
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
}
