import 'dart:async';
import 'dart:io';

import 'package:AlunoID/helpers/database-helper.dart';
import 'package:AlunoID/models/model.dart';
import 'package:AlunoID/models/usuario.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getflutter/getflutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scoped_model/scoped_model.dart';

import '../bloc.navigation_bloc/navigation_bloc.dart';
import '../sidebar/menu_item.dart';

class SideBar extends StatefulWidget {
  final Usuario usuario;
  SideBar({this.usuario});

  @override
  _SideBarState createState() => _SideBarState();
}

Usuario visuausuario;
bool foto = false;

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();

    visuausuario = Usuario.fromMap(widget.usuario.toMap());

    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  DatabaseHelper db = DatabaseHelper();

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      foto = verificarFotoperfil(model);
      _atualizarUsuarioGeral(model);

      return StreamBuilder<bool>(
        initialData: false,
        stream: isSidebarOpenedStream,
        builder: (context, isSideBarOpenedAsync) {
          return AnimatedPositioned(
            duration: _animationDuration,
            top: 0,
            bottom: 0,
            left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
            right: isSideBarOpenedAsync.data ? 0 : screenWidth - 45,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: const Color(0xFF1E90FF),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 100,
                        ),
                        ListTile(
                            title: Text(
                              visuausuario.nome,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800),
                            ),
                            subtitle: Text(
                              visuausuario.email,
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 18,
                              ),
                            ),
                            leading: GFAvatar(
                                minRadius: 30.0,
                                maxRadius: 30.0,
                                backgroundColor: Colors.blueGrey,
                                size: (60.0),
                                backgroundImage: foto
                                    ? FileImage(File(model.fotoPerfil))
                                    : AssetImage("assets/pessoa.png"),
                                shape: GFAvatarShape.circle)),
                        Divider(
                          height: 64,
                          thickness: 0.5,
                          color: Colors.white10.withOpacity(0.3),
                          indent: 32,
                          endIndent: 32,
                        ),
                        MenuItem(
                          icon: Icons.featured_video,
                          title: "Carteira",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.HomePageClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.person,
                          title: "Minha Aconta",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.MyAccountClickedEvent);
                          },
                        ),
                        Divider(
                          height: 64,
                          thickness: 0.5,
                          color: Colors.black.withOpacity(0.3),
                          indent: 32,
                          endIndent: 32,
                        ),
                        MenuItem(
                          icon: Icons.exit_to_app,
                          title: "Sair",
                          onTap: () {
                            model.zerarModel();
                            exit(0);
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.MyExit);
                            dispose();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, -0.9),
                  child: GestureDetector(
                    onTap: () {
                      onIconPressed();
                    },
                    child: ClipPath(
                      clipper: CustomMenuClipper(),
                      child: Container(
                        width: 35,
                        height: 110,
                        color: Color(0xFF1E90FF),
                        alignment: Alignment.centerLeft,
                        child: AnimatedIcon(
                          progress: _animationController.view,
                          icon: AnimatedIcons.menu_close,
                          color: Color(0xFFB0C4DE),
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  bool verificarFotoperfil(MainModel model) {
    if (model.fotoPerfil != null && model.fotoPerfil != "") {
      return true;
    } else {
      return false;
    }
  }

  _atualizarUsuarioGeral(MainModel model) async {
    if (model.id != null) {
      visuausuario = await db.getUsuario(model.id);
    }
    model.updateUsuarioModel(visuausuario);
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.black;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
