import 'package:flutter/material.dart';

class OutroServicoModel {
  String cartegoria;
  String titulo;
  String descricao;
  String urlSite;
  String icone;
  bool prioridade;

  OutroServicoModel({
    @required this.cartegoria,
    @required this.titulo,
    @required this.descricao,
    @required this.urlSite,
    @required this.icone,
    @required this.prioridade,
  });

  OutroServicoModel.fromJson(Map<String, dynamic> json) {
    cartegoria = json['cartegoria'] ?? "";
    titulo = json['titulo'] ?? "";
    descricao = json['descricao'] ?? "";
    urlSite = json['urlSite'] ?? "";
    icone = json['icone'] ?? "";
    prioridade = json['prioridade'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cartegoria'] = this.cartegoria;
    data['titulo'] = this.titulo;
    data['descricao'] = this.descricao;
    data['urlSite'] = this.urlSite;
    data['icone'] = this.icone;
    data['prioridade'] = this.prioridade;
    return data;
  }
}
