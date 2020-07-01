import 'dart:async';
import 'dart:io';
import 'package:AlunoID/models/usuario.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String usuarioTable = 'usuario';
  String colId = 'id';
  String colNome = 'nome';
  String colEmail = 'email';
  String colSenha = 'senha';
  String colTelefone = 'telefone';
  String colCPF = 'cpf';
  String colRG = 'rg';
  String colfotoPerfil = 'fotoPerfil';
  String colComprovanteMatricula = 'comprovanteMatricula';
  String colDTnascimento = 'dtnascimento';
  String colPerfil = 'perfil';
  String colAtivo = 'ativo';
  String colCidade = 'cidade';
  String colUF = 'uf';
  String colInstituicao = 'instituicao';
  String colCurso = 'curso';

  //contrutor nomeado para criar instâcnia da classe
  DatabaseHelper._createInstace();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      //executando somente uma vez
      _databaseHelper = DatabaseHelper._createInstace();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'estupassDB2.db';

    var usuariosDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    //var usuariosDatabase = await openDatabase(path,version:1, onCreate: _createDb, onOpen: _abrirDb);

    return usuariosDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $usuarioTable ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colNome TEXT, $colEmail TEXT, $colSenha TEXT, $colTelefone TEXT, $colCPF TEXT, $colRG TEXT, $colfotoPerfil TEXT, $colComprovanteMatricula TEXT, $colDTnascimento TEXT, $colPerfil TEXT, $colAtivo TEXT,$colCidade  TEXT, $colUF TEXT, $colInstituicao TEXT, $colCurso TEXT)');
  }

/*
  void _abrirDb(Database db) async{
    await db.execute("DROP TABLE IF EXISTS usuario");
    await db.execute('CREATE TABLE $usuarioTable ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colNome TEXT, $colEmail TEXT, $colSenha TEXT, $colTelefone TEXT, $colCPF TEXT, $colRG TEXT, $colfotoPerfil TEXT, $colComprovanteMatricula TEXT, $colDTnascimento TEXT, $colPerfil TEXT, $colAtivo TEXT,$colCidade  TEXT, $colUF TEXT, $colInstituicao TEXT, $colCurso TEXT)');
}
*/

  void deletarbanco() async {
    Database db = await this.database;
    await db.execute("DROP TABLE IF EXISTS usuario");
  }

  void selectbanco() async {
    Database db = await this.database;
    var result = await db.rawQuery("select * from usuario");
    print(result.toString());
  }

  Future<int> insertUsuario(Usuario usuario) async {
    Database db = await this.database;

    var resultado = await db.insert((usuarioTable), usuario.toMap());
    return resultado;
  }

  Future<Usuario> getUsuario(int id) async {
    Database db = await this.database;

    List<Map> maps = await db.query(usuarioTable,
        columns: [
          colId,
          colNome,
          colEmail,
          colSenha,
          colTelefone,
          colCPF,
          colRG,
          colfotoPerfil,
          colComprovanteMatricula,
          colDTnascimento,
          colPerfil,
          colAtivo,
          colCidade,
          colUF,
          colInstituicao,
          colCurso
        ],
        where: "$colId = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Usuario.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<Usuario> getUsuarioLogin(String pstremail, String pstrsenha) async {
    Database db = await this.database;

    List<Map> maps = await db.rawQuery(
        "SELECT * FROM  $usuarioTable  WHERE $colEmail = '$pstremail' and $colSenha = '$pstrsenha'");

    if (maps.length > 0) {
      return Usuario.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Usuario>> getUsuarios() async {
    Database db = await this.database;

    var resultado = await db.query(usuarioTable);

    List<Usuario> lista = resultado.isNotEmpty
        ? resultado.map((c) => Usuario.fromMap(c)).toList()
        : [];

    return lista;
  }

  Future<int> updateUsuario(Usuario usuario) async {
    var db = await this.database;

    var resultado = await db.update(usuarioTable, usuario.toMap(),
        where: '$colId = ?', whereArgs: [usuario.id]);

    return resultado;
  }

  Future<int> deleteUsuario(int id) async {
    var db = await this.database;

    int resultado =
        await db.delete(usuarioTable, where: '$colId = ?', whereArgs: [id]);

    return resultado;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $usuarioTable');

    int resultado = Sqflite.firstIntValue(x);
    return resultado;
  }

  Future close() async {
    Database db = await this.database;
    db.close();
  }
}
