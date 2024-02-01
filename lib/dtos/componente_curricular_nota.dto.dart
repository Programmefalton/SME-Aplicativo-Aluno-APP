import '../models/index.dart';

class ComponenteCurricularNotaDTO {
  String componenteCurricularNome;
  int componenteCurricularId;
  List<EstudanteNotaConceitoModel>? notasConceitos;

  ComponenteCurricularNotaDTO(
      {
        required this.componenteCurricularNome, required this.componenteCurricularId, required this.notasConceitos,
      }
  );
}
