import 'dart:async';
import '../helpers/database-helper.dart';
import '../models/usuario.dart';

class LoginRequest {
  DatabaseHelper con = new DatabaseHelper();
 Future<Usuario> getLogin(String email, String password) {
    var result = con.getUsuarioLogin(email,password);
    return result;
  }
}