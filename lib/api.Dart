import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class API {

  static Future VeLogin(user, password) async {
    String baseUrl = "http://www.tele-tudo.com/operacoes?op=9&user=" + user + "&pass=" + password;
    final response = await http.get(Uri.parse(baseUrl));
    var ret = json.decode(response.body);
    final int erro = (ret["Erro"]) ?? 1;
    if (erro == 0) {
      final int idUser = (ret["id"]) ?? 0;
      final prefer = await SharedPreferences.getInstance();
      await prefer.setInt('ID', idUser);
      return true;
    } else {
      return false;      
    }
  }

}