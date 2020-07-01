import 'package:AlunoID/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:AlunoID/models/model.dart';
import 'package:AlunoID/pages/signup.page.dart';
import 'package:AlunoID/sidebar/sidebar_layout.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../helpers/database-helper.dart';
import '../models/usuario.dart';

class LoginPage extends StatefulWidget with NavigationStates {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  DatabaseHelper db = DatabaseHelper();
  List<Usuario> lcolusuarios = List<Usuario>();
//Usuario usuario = Usuario('', '', '', '', '', '', '', '', '', '', '', '', '', '', '');
  Usuario usuario = null;

  @override
  void initState() {
    super.initState();

    Usuario adm = Usuario(
        "richardvepo",
        "richardvepo@gmail.com",
        "123",
        "48999999999",
        "8484848484",
        "4844545121",
        null,
        null,
        '1996-10-15 00:00:00:000',
        '1',
        'São José',
        'SC',
        'Universidade Municipal de São José',
        'Análise e Desenvolvimento de Sistemas',
        'true');

    criarADM(adm);
  }

  Future<Usuario> pegarUsuario(String pstremail, String pstrsenha) {
    return db.getUsuarioLogin(pstremail, pstrsenha);
  }

  criarADM(Usuario pusuario) async {
    Usuario adm = await pegarUsuario(
        pusuario.email.toString(), pusuario.senha.toString());

    if (adm == null) {
      db.insertUsuario(pusuario);
      adm = await pegarUsuario(
          pusuario.email.toString(), pusuario.senha.toString());
      print(adm.email);
      print(adm.senha);
    }
    db.selectbanco();
  }

  // TextEditingController permite recuperar os valores digitados
  final _ctrlLogin = TextEditingController();
  final _ctrlSenha = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 60, left: 40, right: 40),
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                SizedBox(
                  width: 128,
                  height: 128,
                  child: Image.asset("assets/logo1azul.png"),
                ),
                SizedBox(
                  height: 20,
                ),
                _textFormField("E-mail", "Digite o e-mail",
                    controller: _ctrlLogin, validator: _validaLogin),
                SizedBox(
                  height: 10,
                ),
                _textFormField("Senha", "Digite a senha",
                    senha: true,
                    controller: _ctrlSenha,
                    validator: _validaSenha),
                SizedBox(
                  height: 70,
                ),
                Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.3, 1],
                      colors: [
                        Color(0xFF00BFFF),
                        Color(0XFF1E90FF),
                      ],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: SizedBox.expand(
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Container(
                            child: SizedBox(
                              child: Image.asset("assets/pencil.png"),
                              height: 28,
                              width: 28,
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        // _clickButton(context);
                        _realizaLogin(usuario: usuario);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  child: FlatButton(
                    child: Text(
                      "Cadastre-se",
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      _exibesignupPage(usuario: usuario);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  String _validaLogin(String texto) {
    if (texto.isEmpty) {
      return "Digite o Login";
    }
    return null;
  }

  String _validaSenha(String texto) {
    if (texto.isEmpty) {
      return "Digite a Senha";
    }
    return null;
  }

  _textFormField(
    String label,
    String hint, {
    bool senha = false,
    TextEditingController controller,
    FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: senha,
      decoration: InputDecoration(labelText: label),
    );
  }

  _clickButton({BuildContext context}) async {
    bool formOK = _formKey.currentState.validate();

    if (!formOK) {
      return;
    }

    String login = _ctrlLogin.text.trim();
    String senha = _ctrlSenha.text.trim();

    Usuario usuario;

    usuario = await pegarUsuario(login, senha);

    print("login : $login senha: $senha");

    if (usuario != null) {
      String nome = usuario.email;
      String senha1 = usuario.senha;

      print("login : $nome senha: $senha1");
      _navegaHomepage(context);
    }
  }

  _realizaLogin({Usuario usuario}) async {
    bool formOK = _formKey.currentState.validate();

    if (!formOK) {
      return;
    }

    String login = _ctrlLogin.text.trim();
    String senha = _ctrlSenha.text.trim();

    Usuario usuario;

    usuario = await pegarUsuario(login, senha);

    print("login : $login senha: $senha");

    if (usuario != null) {
      String nome = usuario.email;
      String senha1 = usuario.senha;

      print("login : $nome senha: $senha1");

      final usuarioRecebido = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SideBarLayout(usuario: usuario)),
      );
    }
  }

  _navegaHomepage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SideBarLayout()),
    );
  }

  void _exibesignupPage({Usuario usuario}) async {
    final usuarioRecebido = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupPage(usuario: usuario)),
    );

    if (usuarioRecebido != null) {
      await db.insertUsuario(usuarioRecebido);
    }
  }
}
