import 'dart:convert';
import 'package:AlunoID/models/usuario.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model {
  int _id;
  String _nome;
  String _email;
  String _senha;
  String _telefone;
  String _cpf;
  String _rg;
  String _fotoPerfil;
  String _comprovanteMatricula;
  String _dtnascimento;
  String _perfil;
  String _cidade;
  String _uf;
  String _ativo;
  String _instituicao;
  String _curso;

  int get id {
    return _id;
  }

  String get nome {
    return _nome;
  }

  String get email {
    return _email;
  }

  String get senha {
    return _senha;
  }

  String get telefone {
    return _telefone;
  }

  String get cpf {
    return _cpf;
  }

  String get rg {
    return _rg;
  }

  String get fotoPerfil {
    return _fotoPerfil;
  }

  String get comprovanteMatricula {
    return _comprovanteMatricula;
  }

  String get dtnascimento {
    return _dtnascimento;
  }

  String get perfil {
    return _perfil;
  }

  String get cidade {
    return _cidade;
  }

  String get uf {
    return _uf;
  }

  String get ativo {
    return _ativo;
  }

  String get instituicao {
    return _instituicao;
  }

  String get curso {
    return _curso;
  }

  void updateUsuarioModel(Usuario usuario) {
    _id = usuario.id;
    _nome = usuario.nome;
    _email = usuario.email;
    _senha = usuario.senha;
    _telefone = usuario.telefone;
    _cpf = usuario.cpf;
    _rg = usuario.rg;
    _fotoPerfil = usuario.fotoPerfil;
    _comprovanteMatricula = usuario.comprovanteMatricula;
    _dtnascimento = usuario.dtnascimento;
    _perfil = usuario.perfil;
    _cidade = usuario.cidade;
    _uf = usuario.uf;
    _ativo = usuario.ativo;
    _instituicao = usuario.instituicao;
    _curso = usuario.curso;
    notifyListeners();
  }

  void zerarModel() {
    _id = null;
    _nome = null;
    _email = null;
    _senha = null;
    _telefone = null;
    _cpf = null;
    _rg = null;
    _fotoPerfil = null;
    _comprovanteMatricula = null;
    _dtnascimento = null;
    _perfil = null;
    _cidade = null;
    _uf = null;
    _ativo = null;
    _instituicao = null;
    _curso = null;
    notifyListeners();
  }

  void updateFotoPerfil(String fotoperfil) {
    _fotoPerfil = fotoperfil;
    notifyListeners();
  }

  void updateComprovante(String comprovante) {
    _comprovanteMatricula = comprovante;
    notifyListeners();
  }

  Image imageFromBase64String(String base64String) {
    if (base64String == null || base64String == '')
      return null;
    else
      return Image.memory(base64Decode(base64String));
  }

  void updateImagem2(String fotoperfil) {
    _fotoPerfil = fotoperfil;
  }
}
