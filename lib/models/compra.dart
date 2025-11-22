class Compra {
  final int? id;
  final int produtoId;
  final double quantidade;
  final bool comprado;
  final String? nomeProduto;
  final String? unidade;
  final int listaId;

  Compra({
    this.id,
    required this.produtoId,
    required this.quantidade,
    this.comprado = false,
    this.nomeProduto,
    this.unidade,
    required this.listaId,
});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'produto_id': produtoId,
      'quantidade': quantidade,
      'comprado': comprado ? 1 : 0,
      'lista_id': listaId,
    };
  }

  factory Compra.fromMap(Map<String, dynamic> map) {
    return Compra(
      id: map['id'],
      produtoId: map['produto_id'],
      quantidade: map['quantidade'],
      comprado: map['comprado'] == 1,
      nomeProduto: map['nome_produto'],
      unidade: map['unidade'],
      listaId: map['lista_id'],
    );
  }

  Compra copyWith({
    int? id,
    int? produtoId,
    double? quantidade,
    bool? comprado,
    String? nomeProduto,
    String? unidade,
    int? listaId,
}) {
    return Compra(
      id: id ?? this.id,
      produtoId: produtoId ?? this.produtoId,
      quantidade: quantidade ?? this.quantidade,
      comprado: comprado ?? this.comprado,
      nomeProduto: nomeProduto ?? this.nomeProduto,
      unidade: unidade ?? this.unidade,
      listaId: listaId ?? this.listaId,
    );
  }
}