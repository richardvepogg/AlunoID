import 'package:AlunoID/models/model.dart';
import 'package:AlunoID/pages/login.page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

//class MyApp extends StatefulWidget {

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => new _MyApp();
}

class _MyApp extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final MainModel _model = MainModel();
    return ScopedModel<MainModel>(
        model: _model,
        child: MaterialApp(
          title: 'Passe do Estudante',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
          ),
          home: LoginPage(),
        ));
  }
}
