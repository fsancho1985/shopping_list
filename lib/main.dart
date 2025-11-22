import 'package:app_shopping_list/screens/abre_tela.dart';
import 'package:app_shopping_list/screens/cadastro_tela.dart';
import 'package:app_shopping_list/screens/home_tela.dart';
import 'package:app_shopping_list/screens/login_tela.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/abre',
      routes: {
        '/abre' : (context) => const AbreTela(),
        '/cadastro' : (context) => const CadastroTela(),
        '/login' : (context) => const LoginTela(),
        '/home' : (context) => const HomeTela()
      }
    );
  }
}
