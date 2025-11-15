class Produto {
  final int? id;
  final String nomeProduto;
  final String unidade;

  Produto({
    this.id,
    required this.nomeProduto,
    required this.unidade,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomeproduto': nomeProduto,
      'unidade': unidade,
    };
  }

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['id'],
      nomeProduto: map['nomeproduto'],
      unidade: map['unidade'],
    );
  }
}