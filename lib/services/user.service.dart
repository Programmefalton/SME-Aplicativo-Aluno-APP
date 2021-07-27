import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/models/user/user.dart' as UserModel;
import 'package:sme_app_aluno/services/db.service.dart';
import 'package:sme_app_aluno/utils/db/db_settings.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get_it/get_it.dart';
import 'package:sentry/sentry.dart';

class UserService {
  final dbHelper = DBHelper();

  Future<List<UserModel.User>> all() async {
    try {
      final Database _db = await dbHelper.initDatabase();
      final List<Map<String, dynamic>> maps = await _db.query(TB_USER);
      var users = List.generate(
        maps.length,
        (i) {
          return UserModel.User(
            id: maps[i]['id'],
            nome: maps[i]['nome'],
            cpf: maps[i]['cpf'],
            email: maps[i]['email'],
            token: maps[i]['token'],
            primeiroAcesso: maps[i]['primeiroAcesso'] == 1 ? true : false,
            atualizarDadosCadastrais:
                maps[i]['atualizarDadosCadastrais'] == 1 ? true : false,
            celular: maps[i]['celular'],
          );
        },
      );
      print("--------------------------");
      print("Lista de usuários carregada: $users}");
      print("--------------------------");
      return users;
    } catch (ex) {
      print(ex);
      GetIt.I.get<SentryClient>().captureException(exception: ex);
      return new List<UserModel.User>();
    }
  }

  Future create(UserModel.User model) async {
    final Database _db = await dbHelper.initDatabase();
    try {
      await _db.insert(TB_USER, model.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      print("--------------------------");
      print("Usuário criado com sucesso: ${model.toMap()}");
      print("--------------------------");
    } catch (ex) {
      print("Erro ao criar usuário: $ex");
      return;
    }
  }

  Future<UserModel.User> find(int id) async {
    final Database _db = await dbHelper.initDatabase();
    try {
      final List<Map<String, dynamic>> maps =
          await _db.query(TB_USER, where: "id = ?", whereArgs: [id]);
      UserModel.User user = UserModel.User(
        id: maps[0]['id'],
        nome: maps[0]['nome'],
        cpf: maps[0]['cpf'],
        email: maps[0]['email'],
        token: maps[0]['token'],
        primeiroAcesso: maps[0]['primeiroAcesso'] == 1 ? true : false,
        atualizarDadosCadastrais:
            maps[0]['atualizarDadosCadastrais'] == 1 ? true : false,
        celular: maps[0]['celular'],
      );
      print("--------------------------");
      print("Usuário encontrado com sucesso: ${user.toMap()}");
      print("--------------------------");
      return user;
    } catch (ex) {
      GetIt.I.get<SentryClient>().captureException(exception: ex);
      print("<--------------------------");
      print("Erro ao encontrar usuário: $ex");
      print("<--------------------------");
      return new UserModel.User();
    }
  }

  Future update(UserModel.User model) async {
    try {
      final Database _db = await dbHelper.initDatabase();
      await _db.update(
        TB_USER,
        model.toMap(),
        where: "id = ?",
        whereArgs: [model.id],
      );
      print("--------------------------");
      print("Usuário atualizado com sucesso: ${model.toMap()}");
      print("--------------------------");
    } catch (ex) {
      GetIt.I.get<SentryClient>().captureException(exception: ex);
      print("<--------------------------");
      print("Erro ao atualizar usuário: $ex");
      print("<--------------------------");
      return;
    }
  }

  Future delete(int id) async {
    final Database _db = await dbHelper.initDatabase();
    try {
      await _db.delete(
        TB_USER,
        where: "id = ?",
        whereArgs: [id],
      );
      print("Usuário removido com sucesso: $id");
    } catch (ex) {
      GetIt.I.get<SentryClient>().captureException(exception: ex);
      print("<--------------------------");
      print("Erro ao deletar usuário: $ex");
      print("<--------------------------");
      return;
    }
  }

  Future createMessage(Message model) async {
    final Database _db = await dbHelper.initDatabase();
    try {
      await _db.insert(TB_MESSAGE, model.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      print("--------------------------");
      print("Mensagem criada com sucesso: ${model.toMap()}");
      print("--------------------------");
    } catch (ex) {
      GetIt.I.get<SentryClient>().captureException(exception: ex);
      print("Erro ao criar mensagem: $ex");
      return;
    }
  }
}
