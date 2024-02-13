import 'package:email_validator/email_validator.dart';
import 'package:intl/intl.dart';

class ValidatorsUtil {
  static String? telefone(String value) {
    if (value.isEmpty) {
      return 'O telefone deve ser informado';
    }
    final checarInicial = value.split(' ');
    if (checarInicial.length > 1) {
      if (checarInicial[1].substring(0, 1) != '9') {
        return 'O telefone deve iniciar com o dígito 9';
      }
    }

    value = value.replaceAll('(', '');
    value = value.replaceAll(')', '');
    value = value.replaceAll(' ', '');
    value = value.replaceAll('-', '');
    final RegExp regExp = RegExp(
      r'([0-9])\1{8}',
      caseSensitive: false,
      multiLine: false,
    );

    if (regExp.hasMatch(value) || value.length < 11) {
      return 'O telefone está incorreto';
    }
    return null;
  }

  static String? nome(String value, String nomeCampo) {
    RegExp regExp = RegExp(
      r'(\w)\1\1',
      caseSensitive: false,
      multiLine: false,
    );

    if (regExp.hasMatch(value)) {
      return '$nomeCampo não pode conter caracteres repetidos';
    }

    if (value.isEmpty) {
      return '$nomeCampo deve ser informado';
    }

    regExp = RegExp(
      r"[$&+,:;=?@#|'<>.^*()%!-]",
      caseSensitive: false,
      multiLine: false,
    );

    if (regExp.hasMatch(value)) {
      return '$nomeCampo não pode conter caracteres especiais';
    }

    regExp = RegExp(
      r'[0-9]',
      caseSensitive: false,
      multiLine: false,
    );

    if (regExp.hasMatch(value)) {
      return '$nomeCampo não pode conter números';
    }

    if (value.contains('.') || value.contains('@') || value.contains('.')) value = value.replaceAll('.', '');
    final nomeValidador = value.split(' ');
    if (nomeValidador.isNotEmpty) {
      for (var i = 0; i < nomeValidador.length; i++) {
        if (nomeValidador[i].length == 1 && nomeValidador[i].toLowerCase() != 'e') {
          return '$nomeCampo não pode ser abreviado';
        }
      }
    }
    return null;
  }

  static String? dataNascimento(String value) {
    if (value.isEmpty) {
      return 'Data de nascimento deve ser informada';
    }

    final dataSeparada = value.split('/');

    if (!dataValida(value)) {
      return 'Data de nascimento com formato inválido';
    }

    if (DateTime.tryParse('${dataSeparada[2]}${dataSeparada[1]}${dataSeparada[0]}') == null) {
      return 'Data de nascimento com formato inválido';
    }

    final data = DateFormat('dd/MM/yyyy').parse(value);

    if (data.isBefore(DateTime.parse('19300101'))) {
      return 'Data inválida';
    }

    if (data.isAfter(DateTime.now())) {
      return 'Data não pode ser superior a data atual';
    }

    return null;
  }

  static String? email(String value) {
    if (value.isEmpty) {
      return 'O e-mail deve ser informado';
    }

    if (!EmailValidator.validate(value)) {
      return 'E-mail inválido';
    }

    return null;
  }

  static bool dataValida(String dataString) {
    final dataPartes = dataString.split('/');
    final dia = int.parse(dataPartes[0]);
    final mes = int.parse(dataPartes[1]);
    final ano = int.parse(dataPartes[2]);

    if (ano < 1000 || ano > 3000 || mes == 0 || mes > 12) return false;

    final monthLength = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    if (ano % 400 == 0 || (ano % 100 != 0 && ano % 4 == 0)) monthLength[1] = 29;

    return dia > 0 && dia <= monthLength[mes - 1];
  }
}
