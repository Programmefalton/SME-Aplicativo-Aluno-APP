import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:sme_app_aluno/models/outros_servicos/outro_servico.model.dart';
import 'package:sme_app_aluno/ui/views/outros_servicos_lista.view.dart';
import 'package:url_launcher/url_launcher.dart';

class EAResumoOutrosServicosCard extends StatelessWidget {
  //final List<OutroServicoModel> outroservico;

  //EAResumoOutrosServicosCard({@required this.outroservico});
  EAResumoOutrosServicosCard();

  @override
  Widget build(BuildContext context) {
    final List<OutroServicoModel> outrosServico = [];

    outrosServico.add(OutroServicoModel(
      cartegoria: 'Alimentação',
      titulo: 'Prato Aberto',
      descricao:
          'Um Jeito fácil para todo mundo se nutir de informação sobre o que é servido na escola',
      urlSite: 'https://pratoaberto.sme.prefeitura.sp.gov.br/',
      icone: 'assets/images/prato_aberto.png',
      prioridade: true,
    ));
    outrosServico.add(
      OutroServicoModel(
        cartegoria: 'Material e Uniforme',
        titulo: 'Material Escolar',
        descricao: 'Crédito para compra do material escolar no aplicativo',
        urlSite: 'https://portalmaterialescolar.sme.prefeitura.sp.gov.br/',
        icone: 'assets/images/material_escolar.png',
        prioridade: true,
      ),
    );
    outrosServico.add(
      OutroServicoModel(
        cartegoria: 'Material e Uniforme',
        titulo: 'Uniformes',
        descricao:
            'Use o crédito para comprar o uniforme escolar em um fornecedor cadastrado',
        urlSite: 'https://portaldeuniformes.sme.prefeitura.sp.gov.br/',
        icone: 'assets/images/uniformes.png',
        prioridade: true,
      ),
    );
    outrosServico.add(
      OutroServicoModel(
        cartegoria: 'Solicitações e Informações',
        titulo: 'Voltas às aulas',
        descricao: 'Veja todos os detalhes sobre a volta às aulas',
        urlSite: 'https://educacao.sme.prefeitura.sp.gov.br/ano-letivo-2022/',
        icone: 'assets/images/voltas_aulas.png',
        prioridade: true,
      ),
    );
    outrosServico.add(
      OutroServicoModel(
        cartegoria: 'Solicitações e Informações',
        titulo: 'Escola aberta',
        descricao:
            'É possível consultar os dados de escolas ou gerais, de toda a Rede Municipal de Educação.',
        urlSite: 'https://escolaaberta.sme.prefeitura.sp.gov.br/',
        icone: 'assets/images/escola_aberta.png',
        prioridade: true,
      ),
    );
    outrosServico.add(
      OutroServicoModel(
        cartegoria: 'Solicitações e Informações',
        titulo: 'NAAPA',
        descricao:
            'Conheça o trabalho do Núcleo de Apoio e Acompanhamento para Aprendizegem(NAAPA).',
        urlSite: 'https://turmadonaapa.sme.prefeitura.sp.gov.br/',
        icone: 'assets/images/naapa.png',
        prioridade: true,
      ),
    );
    outrosServico.add(
      OutroServicoModel(
        cartegoria: 'Solicitações e Informações',
        titulo: 'SIC - Serviço de informações ao cidadão',
        descricao:
            'O SIC recebe e registra pedidos de acesso à informação feitos por cidadõas.',
        urlSite: 'http://esic.prefeitura.sp.gov.br/',
        icone: 'assets/images/sic.png',
        prioridade: false,
      ),
    );
    outrosServico.add(
      OutroServicoModel(
        cartegoria: 'Solicitações e Informações',
        titulo: 'Solicitação de vaga',
        descricao:
            'Preencha o formúlario online, para efetuar solicitações de vagas disponíveis.',
        urlSite: 'https://vaganacreche.sme.prefeitura.sp.gov.br/',
        icone: 'assets/images/solicitacao_vaga.png',
        prioridade: false,
      ),
    );
    final List<OutroServicoModel> linksPrioridades =
        outrosServico.where((x) => x.prioridade == true).toList();
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: screenHeight * 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(screenHeight * 2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(1, 2),
            blurRadius: 2,
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: screenHeight * 2,
                bottom: screenHeight * 2,
                left: screenHeight * 2.5,
                right: screenHeight * 2.5),
            decoration: BoxDecoration(
                color: Color(0xffEFB330),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenHeight * 2),
                    topRight: Radius.circular(screenHeight * 2))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      height: screenHeight * 3,
                      width: screenHeight * 3,
                      margin: EdgeInsets.only(right: screenHeight * 1),
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.alignJustify,
                          size: screenHeight * 3,
                        ),
                      ),
                    ),
                    AutoSizeText(
                      "OUTROS SERVIÇOS",
                      maxFontSize: 18,
                      minFontSize: 16,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ],
            ),
          ),
          //Inicio Novo Widget
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OutrosLinksInfoWidget(
                  screenHeight: screenHeight,
                  outroServicoModel: linksPrioridades[0]),
              OutrosLinksInfoWidget(
                  screenHeight: screenHeight,
                  outroServicoModel: linksPrioridades[1]),
              OutrosLinksInfoWidget(
                  screenHeight: screenHeight,
                  outroServicoModel: linksPrioridades[2]),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OutrosLinksInfoWidget(
                  screenHeight: screenHeight,
                  outroServicoModel: linksPrioridades[3]),
              OutrosLinksInfoWidget(
                  screenHeight: screenHeight,
                  outroServicoModel: linksPrioridades[4]),
              OutrosLinksInfoWidget(
                  screenHeight: screenHeight,
                  outroServicoModel: linksPrioridades[5]),
            ],
          ),
          //Fim Novo Widget
          Container(
            padding: EdgeInsets.only(
                left: screenHeight * 2.5,
                top: screenHeight * 2.5,
                right: screenHeight * 2.5,
                bottom: screenHeight * 1.5),
            child: Container(
              height: screenHeight * 6,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffC65D00), width: 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(screenHeight * 3),
                ),
              ),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OutrosServicosLista(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AutoSizeText(
                      "MAIS INFORMAÇÕES",
                      maxFontSize: 16,
                      minFontSize: 14,
                      style: TextStyle(
                          color: Color(0xffC65D00),
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: screenHeight * 3,
                    ),
                    Icon(
                      FontAwesomeIcons.chevronRight,
                      color: Color(0xffffd037),
                      size: screenHeight * 3,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OutrosLinksInfoWidget extends StatelessWidget {
  final double screenHeight;
  final OutroServicoModel outroServicoModel;
  const OutrosLinksInfoWidget(
      {Key key, @required this.screenHeight, @required this.outroServicoModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            child: Container(
              margin: EdgeInsets.only(
                right: screenHeight * 2.5,
                left: screenHeight * 2.5,
                top: screenHeight * 0.5,
              ),
              child: ClipOval(
                child: Image.asset(
                  outroServicoModel.icone,
                  width: screenHeight * 8,
                  height: screenHeight * 8,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onTap: () => launch(outroServicoModel.urlSite),
          ),
          AutoSizeText(
            outroServicoModel.titulo,
            maxFontSize: 12,
            minFontSize: 10,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
