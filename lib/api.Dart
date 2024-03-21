import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class API {

  static Future<bool> veLogin(String user, String password) async {
    String baseUrl = "https://teletudo.com/api/login";
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({
        'user': user,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      var ret = json.decode(response.body);
      final int erro = ret["Erro"] ?? 1;
      if (erro == 0) {
        final int idUser = ret["id"] ?? 0;
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('ID', idUser);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

static Future<bool> registerUser(String nome, String email, String senha, String telefone, String cnh, String documentoVeiculo, String PIX) async {
  String baseUrl = "https://teletudo.com/api/cadboy";
  final response = await http.post(
    Uri.parse(baseUrl),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: json.encode({
      'nome_completo': nome,
      'email': email,
      'senha': senha,
      'telefone': telefone,
      'cnh': cnh,
      'documento_veiculo': documentoVeiculo,
      'PIX': PIX,
    }),
  );
  if (response.statusCode == 200 || response.statusCode == 201) {
    final ret = json.decode(response.body);
    final int idUser = ret["id"] ?? 0; 
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('ID', idUser);
    return true;
  } else {
    return false;
  }
}

}  


