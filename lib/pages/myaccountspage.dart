import 'dart:io';
import 'package:AlunoID/helpers/database-helper.dart';
import 'package:AlunoID/models/model.dart';
import 'package:AlunoID/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';

class MyAccountsPage extends StatefulWidget with NavigationStates {
  @override
  State<StatefulWidget> createState() => _MyAccountsPage();
}

bool foto = false;

class _MyAccountsPage extends State<MyAccountsPage> {
  @override
  void initState() {
    super.initState();
  }

  DatabaseHelper db = DatabaseHelper();

  final _ctrlEmail = TextEditingController();
  final _ctrlNome = TextEditingController();
  final _ctrlEstado = TextEditingController();
  final _ctrlInstituicao = TextEditingController();
  final _ctrlCurso = TextEditingController();
  final _ctrlSenha = TextEditingController();
  final _ctrlTelefone = TextEditingController();
  final _ctrlCPF = TextEditingController();
  final _ctrlRG = TextEditingController();
  final _ctrlcidade = TextEditingController();

  final _formKeyConta = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      foto = verificarFotoperfil(model);
      return _body(model);
    }));
  }

  _body(MainModel model) {
    return Container(
        padding: EdgeInsets.only(top: 0, left: 70, right: 40),
        color: Colors.white,
        child: Form(
          key: _formKeyConta,
          child: ListView(
            children: <Widget>[
              GestureDetector(
                child: Container(
                    width: 125,
                    height: 110,
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: GFAvatar(
                            minRadius: 50.0,
                            maxRadius: 50.0,
                            backgroundColor: Colors.blueGrey,
                            size: (60.0),
                            backgroundImage: foto
                                ? FileImage(File(model.fotoPerfil))
                                : AssetImage("assets/pessoa.png"),
                            shape: GFAvatarShape.circle))),
                onTap: () {
                  ImagePicker.pickImage(source: ImageSource.gallery)
                      .then((file) {
                    if (file == null) return;
                    setState(() {
                      model.updateFotoPerfil(file.path);
                      atualizarUsuario(model);
                    });
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              _textFormField("Nome", "Digite o nome", model.nome,
                  controller: _ctrlNome),
              SizedBox(
                height: 15,
              ),
              _textFormField("E-mail", "Digite o e-mail", model.email,
                  senha: false, controller: _ctrlEmail),
              SizedBox(
                height: 15,
              ),
              _textFormField("Estado", "Insira a UF", model.uf,
                  senha: false, controller: _ctrlEstado),
              SizedBox(
                height: 15,
              ),
              _textFormField("Cidade", "Insira a cidade", model.cidade,
                  senha: false, controller: _ctrlcidade),
              SizedBox(
                height: 15,
              ),
              _textFormField(
                  "instituição", "Insira a instituição", model.instituicao,
                  senha: false, controller: _ctrlInstituicao),
              SizedBox(
                height: 15,
              ),
              _textFormField("Curso", "Insira o curso", model.curso,
                  senha: false, controller: _ctrlCurso),
              SizedBox(
                height: 15,
              ),
              _textFormField("Senha", "Insira a senha", model.senha,
                  senha: true, controller: _ctrlSenha),
              SizedBox(
                height: 20,
              ),
              GFButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    atualizarUsuario(model);
                  },
                  text: "Salvar"),
            ],
          ),
        ));
  }

//row que contém a coluna  com o nome do usuário
  Widget buildRowNome() => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(children: [
            containertexto(277, 25, 350, 14, 15),
          ])
        ],
      );

  Widget containertexto(double contwidth, double contheight,
      double limiteboxwidth, double textofontsize, double contmargin) {
    return Container(
        width: contwidth,
        height: contheight,
        margin: EdgeInsets.all(contheight),
        child: Align(
            alignment: Alignment.center,
            child: TextFormField(
              decoration: InputDecoration(labelText: "Nome do Usuário"),
            )));
  }

  void _exibeAviso() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(""),
            content: new Text("Dados atualizados com sucesso!"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Fechar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void atualizarUsuario(MainModel model) {
    Usuario _usuario =
        new Usuario("", "", "", "", "", "", "", "", "", "", "", "", "", "", "");

    if (_ctrlNome.text == null || _ctrlNome.text == "")
      _usuario.nome = model.nome;
    else
      _usuario.nome = _ctrlNome.text;

    if (_ctrlEmail.text == null || _ctrlEmail.text == "")
      _usuario.email = model.email;
    else
      _usuario.email = _ctrlEmail.text;

    if (_ctrlSenha.text == null || _ctrlSenha.text == "")
      _usuario.senha = model.senha;
    else
      _usuario.senha = _ctrlSenha.text;

    if (_ctrlTelefone.text == null || _ctrlTelefone.text == "")
      _usuario.telefone = model.telefone;
    else
      _usuario.telefone = _ctrlTelefone.text;

    if (_ctrlCPF.text == null || _ctrlCPF.text == "")
      _usuario.cpf = model.cpf;
    else
      _usuario.cpf = _ctrlCPF.text;

    if (_ctrlRG.text == null || _ctrlRG.text == "")
      _usuario.rg = model.rg;
    else
      _usuario.rg = _ctrlRG.text;

    _usuario.fotoPerfil = model.fotoPerfil;

    _usuario.comprovanteMatricula = model.comprovanteMatricula;

    _usuario.dtnascimento = model.dtnascimento;

    _usuario.perfil = model.perfil;

    if (_ctrlcidade.text == null || _ctrlcidade.text == "")
      _usuario.cidade = model.cidade;
    else
      _usuario.cidade = _ctrlcidade.text;

    if (_ctrlEstado.text == null || _ctrlEstado.text == "")
      _usuario.uf = model.uf;
    else
      _usuario.uf = _ctrlEstado.text;

    if (_ctrlInstituicao.text == null || _ctrlInstituicao.text == "")
      _usuario.instituicao = model.instituicao;
    else
      _usuario.instituicao = _ctrlInstituicao.text;

    if (_ctrlCurso.text == null || _ctrlCurso.text == "")
      _usuario.curso = model.curso;
    else
      _usuario.curso = _ctrlCurso.text;

    _usuario.fotoPerfil = model.fotoPerfil;

    _usuario.ativo = model.ativo;

    _usuario.id = model.id;

    db.updateUsuario(_usuario);

    _exibeAviso();
  }

  _textFormField(
    String label,
    String hint,
    String hinttext, {
    bool senha = false,
    TextEditingController controller,
    FormFieldValidator<String> validator,
  }) {
    return TextFormField(
        controller: controller,
        obscureText: senha,
        decoration: InputDecoration(
          fillColor: Colors.lightBlue[50],
          filled: true,
          labelText: label,
          hintText: hinttext,
          hintStyle: TextStyle(color: Colors.blue, fontSize: 12),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.lightBlue, width: 2.0)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.blue)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.blue, width: 3.0)),
        ));
  }

  bool verificarFotoperfil(MainModel model) {
    if (model.fotoPerfil != null && model.fotoPerfil != "") {
      return true;
    } else {
      return false;
    }
  }
}
