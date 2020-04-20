import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sme_app_aluno/interfaces/authenticate_repository_interface.dart';
import 'package:sme_app_aluno/models/data.dart';
import 'package:sme_app_aluno/utils/api.dart';
import 'package:sme_app_aluno/utils/storage.dart';

class AuthenticateRepository implements IAuthenticateRepository {
  final Storage storage = Storage();

  @override
  Future<Data> loginUser(String cpf, String password) async {
    String userPassword = await storage.readValueStorage("current_password");
    try {
      final response =
          await http.post("${Api.HOST}/Autenticacao?cpf=$cpf&senha=$password");

      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        var data = Data.fromJson(decodeJson);
        if (data.user.cpf.isNotEmpty) {
          addCurrentUserToStorage(
            data.user.nome,
            data.user.cpf,
            data.user.email,
            data.user.token,
            userPassword,
          );
        }
        return data;
      } else {
        var dataError = Data();
        dataError.erros = [response.body];
        return dataError;
      }
    } catch (error, stacktrace) {
      print("Erro ao tentatar se autenticar " + stacktrace.toString());
      return null;
    }
  }

  addCurrentUserToStorage(String name, String cpf, String email, String token,
      String password) async {
    storage.insertString('current_name', name);
    storage.insertString('current_cpf', cpf);
    storage.insertString('current_email', email);
    storage.insertString('token', token);
    storage.insertString('token', password);
  }
}
