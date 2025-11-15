import 'dart:convert';

import 'package:app_shopping_list/models/viacepmodel.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<ViaCepModel> getDadosPorCep({String cep = ""}) async {
    String endpoint = "https://viacep.com.br/ws/$cep/json/";
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      return ViaCepModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Falha na conexão com a API");
    }
  }
}