import 'package:get_it/get_it.dart';
import 'package:sentry/sentry.dart';
import 'package:sqflite/sqflite.dart';

import '../models/message/message.dart';
import '../utils/db/db_settings.dart';
import 'db.service.dart';

class MessageService {
  final dbHelper = DBHelper();

  Future create(Message model) async {
    final Database db = await dbHelper.initDatabase();
    try {
      await db.insert(tbMESSAGE, model.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (ex) {
      GetIt.I.get<SentryClient>().captureException('Erro ao criar mensagem no sqlLite: $ex');
    }
  }

  Future<List<Message>> all() async {
    final Database db = await dbHelper.initDatabase();
    try {
      final List<Map<String, dynamic>> maps = await db.query(tbMESSAGE);
      final messages = List.generate(
        maps.length,
        (i) {
          return Message(
            id: maps[i]['id'],
            titulo: maps[i]['titulo'],
            mensagem: maps[i]['mensagem'],
            categoriaNotificacao: maps[i]['categoriaNotificacao'],
            criadoEm: maps[i]['criadoEm'],
            dataEnvio: maps[i]['dataEnvio'],
            mensagemVisualizada: maps[i]['mensagemVisualizada'] == 1 ? true : false,
            codigoEOL: maps[i]['codigoEOL'],
          );
        },
      );
      return messages;
    } catch (ex) {
      GetIt.I.get<SentryClient>().captureException('MessageService ALL $ex');
      return [];
    }
  }

  Future delete(int id) async {
    final Database db = await dbHelper.initDatabase();
    try {
      await db.delete(
        tbMESSAGE,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (ex) {
      GetIt.I.get<SentryClient>().captureException('Erro ao deletar mensagem: $ex');
    }
  }
}
