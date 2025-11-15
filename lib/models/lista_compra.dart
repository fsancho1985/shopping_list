class ListaCompra {
  final int? id;
  final String nome;
  final DateTime dataCriacao;
  final bool ativa;

  ListaCompra({
    this.id,
    required this.nome,
    required this.dataCriacao,
    this.ativa = true,
});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'data_criacao': dataCriacao.millisecondsSinceEpoch ~/ 1000,
      'ativa': ativa ? 1 : 0,
    };
  }

  factory ListaCompra.fromMap(Map<String, dynamic> map) {
    return ListaCompra(
      id: map['id'],
      nome: map['nome'],
      dataCriacao: DateTime.fromMicrosecondsSinceEpoch(map['data_criacao'] * 1000),
      ativa: map['ativa'] == 1,
    );
  }


}