import '../models/usuario.dart';

class SessaoService {
  static Usuario? _usuarioLogado;

  static bool get estadoLogado => _usuarioLogado != null;
  static Usuario? get usuarioLogado => _usuarioLogado;
  static String? get nomeUsuario => _usuarioLogado?.nome;
  static String? get emailUsuario => _usuarioLogado?.email;
  static int? get idUsuario => _usuarioLogado?.id;

  static void login(Usuario usuario) {
    _usuarioLogado = usuario;
  }

  static void logout() {
    _usuarioLogado = null;
  }

  static void atualizarUsuario(Usuario usuarioAtualizado) {
    if (_usuarioLogado != null && _usuarioLogado!.id == usuarioAtualizado.id) {
      _usuarioLogado = usuarioAtualizado;
    }
  }
}