import 'dart:math';

class Usuario {
  final int? id;
  final String email;
  final String nome;
  final String senha;
  final String cep;
  final String logradouro;
  final String numero;
  final String bairro;
  final String cidade;
  final String estado;
  final String uf;

  Usuario({
    this.id,
    required this.email,
    required this.nome,
    required this.senha,
    required this.cep,
    required this.logradouro,
    required this.numero,
    required this.bairro,
    required this.cidade,
    required this.estado,
    required this.uf,
});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'nome': nome,
      'senha': senha,
      'cep': cep,
      'logradouro': logradouro,
      'numero': numero,
      'bairro': bairro,
      'cidade': cidade,
      'estado': estado,
      'uf': uf,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      email: map['email'],
      nome: map['nome'],
      senha: map['senha'],
      cep: map['cep'],
      logradouro: map['logradouro'],
      numero: map['numero'],
      bairro: map['bairro'],
      cidade: map['cidade'],
      estado: map['estado'],
      uf: map['uf'],
    );
  }

}