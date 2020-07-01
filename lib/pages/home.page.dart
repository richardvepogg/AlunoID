import 'dart:io';

import 'package:AlunoID/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:AlunoID/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';
import 'package:getflutter/shape/gf_avatar_shape.dart';
import 'package:image_picker/image_picker.dart';
import '../helpers/database-helper.dart';
import 'package:AlunoID/models/model.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget with NavigationStates {
  @override
  _HomePageState createState() => _HomePageState();
}

Usuario homeusuario;
bool comprovante = false;
bool foto = false;

class _HomePageState extends State<HomePage> {
  DatabaseHelper db = DatabaseHelper();

  @override
  void initState() {
    super.initState();
  }

  Future<Usuario> pegarUsuario(int id) {
    return db.getUsuario(id);
  }

  buscarUsuario(int id) async {
    homeusuario = await pegarUsuario(id);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(00000),
        resizeToAvoidBottomPadding: true,
        body: ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
          comprovante = verificarComprovante(model);
          foto = verificarFotoperfil(model);
          return _body(model);
        }));
  }

  _body(MainModel model) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
          child: Column(
              children: [
        buildRowNome(model),
        buildRowFoto(model),
        buildRowNomeinstitui(model),
        buildRowinfo(model),
        comprovante ? buildRowQR(model) : null,
        buildRowBotao(model)
      ].whereType<Widget>().toList())),
    );
  }

//row que contém a coluna  com o nome do usuário
  Widget buildRowBotao(MainModel model) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 30,
          ),
          Column(children: [
            GFButton(
                color: Colors.blueAccent,
                onPressed: () async {
                  await exibeAviso(
                      "Selecione o comprovante de matrícula para \"Validar/Renovar\"");
                  await ImagePicker.pickImage(source: ImageSource.gallery)
                      .then((file) {
                    if (file == null) return;
                    setState(() {
                      model.updateComprovante(file.path);
                      atualizarUsuario(model);
                    });
                    exibeAviso("Carteira de Estudante validada!");
                  });
                },
                text: "Validar/Renovar"),
          ])
        ],
      );

  void atualizarUsuario(MainModel model) {
    Usuario _usuario =
        new Usuario("", "", "", "", "", "", "", "", "", "", "", "", "", "", "");

    _usuario.nome = model.nome;

    _usuario.email = model.email;

    _usuario.senha = model.senha;

    _usuario.telefone = model.telefone;

    _usuario.cpf = model.cpf;

    _usuario.rg = model.rg;

    _usuario.fotoPerfil = model.fotoPerfil;

    _usuario.comprovanteMatricula = model.comprovanteMatricula;

    _usuario.dtnascimento = model.dtnascimento;

    _usuario.perfil = model.perfil;

    _usuario.cidade = model.cidade;

    _usuario.uf = model.uf;

    _usuario.instituicao = model.instituicao;

    _usuario.curso = model.curso;

    _usuario.fotoPerfil = model.fotoPerfil;

    _usuario.ativo = model.ativo;

    _usuario.id = model.id;

    db.updateUsuario(_usuario);
  }

//row que contém a coluna  com o nome do usuário
  Widget buildRowNome(MainModel model) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(children: [
            containertexto(model.nome, 277, 25, 350, 14, 15),
          ])
        ],
      );

  Widget containertexto(String pstrtexto, double contwidth, double contheight,
      double limiteboxwidth, double textofontsize, double contmargin) {
    return LimitedBox(
        maxWidth: limiteboxwidth,
        child: Container(
            width: contwidth,
            height: contheight,
            margin: EdgeInsets.all(contheight),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent, width: 2.0),
              borderRadius: new BorderRadius.circular(10.0),
            ),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  pstrtexto,
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontSize: textofontsize),
                  maxLines: 1,
                  softWrap: false,
                ))));
  }

//linha que contém as colunas UF e A foto do perfil
  Widget buildRowFoto(MainModel model) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [columnUFMunicipio(model), columnFotoPerfil(model)],
      );

//coluna que contém  a uf e o municipio
  Widget columnUFMunicipio(MainModel model) => Column(
        children: [
          Row(
            children: <Widget>[containertexto(model.uf, 180, 22, 200, 14, 0)],
          ),
          Row(
            children: <Widget>[
              containertexto(model.cidade, 180, 22, 200, 14, 0)
            ],
          ),
        ],
      );

//coluna que contém a foto do perfil
  Widget columnFotoPerfil(MainModel model) => Column(
        children: [
          Container(
              width: 125,
              height: 110,
              child: Align(
                  alignment: Alignment.topCenter,
                  child: GFAvatar(
                      size: (55.0),
                      minRadius: 47.0,
                      maxRadius: 47.0,
                      backgroundImage: foto
                          ? FileImage(File(model.fotoPerfil))
                          : AssetImage("assets/pessoa.png"),
                      shape: GFAvatarShape.standard)))
        ],
      );

//row que contém a coluna  com o nome do usuário
  Widget buildRowNomeinstitui(MainModel model) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(children: [
            containertexto(model.instituicao, 277, 25, 350, 14, 15),
          ])
        ],
      );

  Widget buildRowinfo(MainModel model) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(children: [
            containertexto(model.curso, 112, 25, 350, 14, 15),
          ]),
          Column(children: [
            containertexto(model.instituicao, 112, 25, 350, 14, 15),
          ])
        ],
      );

  Widget buildRowQR(MainModel model) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 30,
          ),
          Column(
            children: <Widget>[
              Row(children: [
                containertexto("Código QR", 100, 25, 350, 14, 15),
              ]),
              Row(children: [
                Container(
                    width: 125,
                    height: 110,
                    child: Align(
                        alignment: Alignment.center,
                        child: GFAvatar(
                            size: (55.0),
                            backgroundImage: AssetImage("assets/qr.png"),
                            //backgroundImage: AssetImage("assets/qr.png"),
                            shape: GFAvatarShape.standard)))
              ])
            ],
          )
        ],
      );

  bool verificarComprovante(MainModel model) {
    if (model.comprovanteMatricula != null &&
        model.comprovanteMatricula != "") {
      return true;
    } else {
      return false;
    }
  }

  bool verificarFotoperfil(MainModel model) {
    if (model.fotoPerfil != null && model.fotoPerfil != "") {
      return true;
    } else {
      return false;
    }
  }

  Future<Null> exibeAviso(String texto) async {
    String returnVal = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(""),
            content: new Text(texto),
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
}
