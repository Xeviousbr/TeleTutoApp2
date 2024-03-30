import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class API {

  static Future<bool> veLogin(String user, String password, double lat, double lon) async {
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
        'lat': lat, 
        'lon': lon, 
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

static Future<bool> registerUser(String nome, String email, String senha, String telefone, String cnh, String placa, String PIX) async {
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
      'placa': placa,
      'PIX': PIX
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

static Future<void> sendHeartbeat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userid = prefs.getInt('ID');
    double lat = 0.0; 
    double lon = 0.0; 
    if (userid != null) {
      String baseUrl = "https://teletudo.com/api/heartbeat";
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'userid': userid,
          'lat': lat,
          'lon': lon,
        }),
      );
      if (response.statusCode == 200) {
        print('Heartbeat enviado com sucesso');
      } else {
        print('Erro ao enviar heartbeat');
      }
    }
 }

}  


