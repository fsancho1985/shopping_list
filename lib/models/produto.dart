class Produto {
  final int? id;
  final String nome_Produto;
  final String unidade;

  Produto({
    this.id,
    required this.nome_Produto,
    required this.unidade,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome_produto': nome_Produto,
      'unidade': unidade,
    };
  }

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['id'],
      nome_Produto: map['nome_produto'],
      unidade: map['unidade'],
    );
  }
}