import 'package:get_it/get_it.dart';

import '../controllers/index.dart';
import '../repositories/index.dart';
import '../services/index.dart';
import '../stores/index.dart';

class DependenciasIoC {
  GetIt getIt = GetIt.instance;

  void registrarServicos() {
    getIt.registerSingleton<ApiService>(ApiService());
  }

  void registrarStores() {
    getIt.registerSingleton<UsuarioStore>(UsuarioStore());
    getIt.registerSingleton<EstudanteStore>(EstudanteStore());
  }

  void registrarRepositories() {
    getIt.registerSingleton<UsuarioRepository>(UsuarioRepository());
    getIt.registerSingleton<EstudanteRepository>(EstudanteRepository());
  }

  void registrarControllers() {
    getIt.registerSingleton<AutenticacaoController>(AutenticacaoController());
    getIt.registerSingleton<UsuarioController>(UsuarioController());
    getIt.registerSingleton<EstudanteController>(EstudanteController());
    getIt.registerSingleton<EstudanteNotasController>(EstudanteNotasController());
    getIt.registerSingleton<EstudanteFrequenciaController>(EstudanteFrequenciaController());
  }
}
