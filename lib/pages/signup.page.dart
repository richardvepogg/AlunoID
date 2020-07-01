import 'package:AlunoID/models/usuario.dart';
import 'package:AlunoID/pages/login.page.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';

class SignupPage extends StatefulWidget {
  final Usuario usuario;
  SignupPage({this.usuario});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _ctrlLogin = TextEditingController();
  final _ctrlNome = TextEditingController();
  final _ctrlEstado = TextEditingController();
  final _ctrlCidade = TextEditingController();
  final _ctrlInstituicao = TextEditingController();
  final _ctrlCurso = TextEditingController();
  final _ctrlSenha = TextEditingController();
  final _formKeyregistrar = GlobalKey<FormState>();

  final _loginFocus = FocusNode();
  final _nomeFocus = FocusNode();
  final _estadoFocus = FocusNode();
  final _cidadeFocus = FocusNode();
  final _instituicaoFocus = FocusNode();
  final _cursoFocus = FocusNode();
  final _senhaFocus = FocusNode();

  bool editado = true;
  Usuario _cadastrausuario;

  @override
  void initState() {
    super.initState();

    if (widget.usuario == null) {
      _cadastrausuario =
          Usuario('', '', '', '', '', '', '', '', '', '', '', '', '', '', '');
    } else {
      _cadastrausuario = Usuario.fromMap(widget.usuario.toMap());

      _ctrlNome.text = _cadastrausuario.nome;
      _ctrlLogin.text = _cadastrausuario.email;
      _ctrlEstado.text = _cadastrausuario.uf;
      _ctrlCidade.text = _cadastrausuario.cidade;
      _ctrlInstituicao.text = _cadastrausuario.instituicao;
      _ctrlCurso.text = _cadastrausuario.curso;
      _ctrlSenha.text = _cadastrausuario.senha;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body());
  }

  _body() {
    return Container(
        padding: EdgeInsets.only(top: 0, left: 70, right: 40),
        color: Colors.white,
        child: Form(
          key: _formKeyregistrar,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: _ctrlNome,
                  focusNode: _nomeFocus,
                  obscureText: false,
                  onChanged: (text) {
                    editado = true;
                    setState(() {
                      _cadastrausuario.nome = text;
                    });
                  },
                  decoration: inputdecoration("Nome", "Digite seu nome")),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                  controller: _ctrlLogin,
                  focusNode: _loginFocus,
                  obscureText: false,
                  onChanged: (text) {
                    editado = true;
                    setState(() {
                      _cadastrausuario.email = text;
                    });
                  },
                  decoration: inputdecoration("E-mail", "Digite seu e-mail")),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                  controller: _ctrlEstado,
                  focusNode: _estadoFocus,
                  obscureText: false,
                  onChanged: (text) {
                    editado = true;
                    setState(() {
                      _cadastrausuario.uf = text;
                    });
                  },
                  decoration: inputdecoration("Estado", "Insira a UF")),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                  controller: _ctrlCidade,
                  focusNode: _cidadeFocus,
                  obscureText: false,
                  onChanged: (text) {
                    editado = true;
                    setState(() {
                      _cadastrausuario.cidade = text;
                    });
                  },
                  decoration:
                      inputdecoration("Município", "Insira oa Município")),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                  controller: _ctrlInstituicao,
                  focusNode: _instituicaoFocus,
                  obscureText: false,
                  onChanged: (text) {
                    editado = true;
                    setState(() {
                      _cadastrausuario.instituicao = text;
                    });
                  },
                  decoration:
                      inputdecoration("Instituição", "Insira a instituição")),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                  controller: _ctrlCurso,
                  focusNode: _cursoFocus,
                  obscureText: false,
                  onChanged: (text) {
                    editado = true;
                    setState(() {
                      _cadastrausuario.curso = text;
                    });
                  },
                  decoration: inputdecoration("Curso", "Insira o curso")),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                  controller: _ctrlSenha,
                  focusNode: _senhaFocus,
                  obscureText: false,
                  onChanged: (text) {
                    editado = true;
                    setState(() {
                      _cadastrausuario.senha = text;
                    });
                  },
                  decoration: inputdecoration("Senha", "Insira a senha")),
              SizedBox(
                height: 20,
              ),
              GFButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    if (_cadastrausuario.email != null &&
                        _cadastrausuario.email.isNotEmpty) {
                      Navigator.pop(context, _cadastrausuario);
                    } else {
                      _exibeAviso("E-mail", "Por favor insira o e-mail");
                      FocusScope.of(context).requestFocus(_loginFocus);
                    }
                    /*
                    if (_cadastrausuario.nome != null &&
                        _cadastrausuario.nome.isNotEmpty) {
                      Navigator.pop(context, _cadastrausuario);
                    } else {
                      _exibeAviso("Nome", "Por favor insira o nome");
                      FocusScope.of(context).requestFocus(_nomeFocus);
                    }
                    if (_cadastrausuario.uf != null &&
                        _cadastrausuario.uf.isNotEmpty) {
                      Navigator.pop(context, _cadastrausuario);
                    } else {
                      _exibeAviso("Estado", "Por favor insira o Estado");
                      FocusScope.of(context).requestFocus(_estadoFocus);
                    }
                    if (_cadastrausuario.cidade != null &&
                        _cadastrausuario.cidade.isNotEmpty) {
                      Navigator.pop(context, _cadastrausuario);
                    } else {
                      _exibeAviso("Município", "Por favor insira o Município");
                      FocusScope.of(context).requestFocus(_cidadeFocus);
                    }
                    if (_cadastrausuario.cidade != null &&
                        _cadastrausuario.cidade.isNotEmpty) {
                      Navigator.pop(context, _cadastrausuario);
                    } else {
                      _exibeAviso(
                          "Instituição", "Por favor insira a instituição");
                      FocusScope.of(context).requestFocus(_instituicaoFocus);
                    }
                    if (_cadastrausuario.curso != null &&
                        _cadastrausuario.curso.isNotEmpty) {
                      Navigator.pop(context, _cadastrausuario);
                    } else {
                      _exibeAviso("Curso", "Por favor insira o curso");
                      FocusScope.of(context).requestFocus(_cursoFocus);
                    }
                    if (_cadastrausuario.senha != null &&
                        _cadastrausuario.senha.isNotEmpty) {
                      Navigator.pop(context, _cadastrausuario);
                    } else {
                      _exibeAviso("Senha", "Por favor insira a senha");
                      FocusScope.of(context).requestFocus(_senhaFocus);
                    }
                    */
                  },
                  text: "Cadastrar"),
              SizedBox(
                height: 5,
              ),
              GFButton(
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  text: "Voltar"),
            ],
          ),
        ));
  }

  void _exibeAviso(String pstrnome, String pstrvalor) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(pstrnome),
            content: new Text(pstrvalor),
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

  inputdecoration(String label, String hinttext) {
    return InputDecoration(
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
    );
  }
}
