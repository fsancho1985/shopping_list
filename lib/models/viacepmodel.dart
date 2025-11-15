import 'dart:convert';
import 'dart:math';

ViaCepModel viaCepModelFromJson(String str) => ViaCepModel.fromJson(json.decode(str));

String viaCepModelToJson(ViaCepModel dados) => json.encode(dados.toJson());

class ViaCepModel {
  String cep;
  String logradouro;
  String localidade;
  String bairro;
  String estado;
  String uf;

  ViaCepModel({
    required this.cep,
    required this.logradouro,
    required this.localidade,
    required this.bairro,
    required this.estado,
    required this.uf,
  });

  factory ViaCepModel.fromJson(Map<String, dynamic> json) => ViaCepModel(
    cep: json['cep'],
    logradouro: json['logradouro'],
    localidade: json['localidade'],
    bairro: json['bairro'],
    estado: json['estado'],
    uf: json['uf'],
  );

  Map<String, dynamic> toJson() => {
    'cep': cep,
    'logradouro': logradouro,
    'localidade': localidade,
    'bairro': bairro,
    'estado': estado,
    'uf': uf,
  };
}