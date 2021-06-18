import 'package:auto_size_text/auto_size_text.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:sme_app_aluno/screens/change_password/change_password.dart';
import 'package:sme_app_aluno/screens/widgets/view_data/view.data.dart';
import 'package:sme_app_aluno/stores/index.dart';
import 'package:sme_app_aluno/ui/views/index.dart';
import 'package:sme_app_aluno/ui/widgets/ea_botao.widget.dart';
import 'package:sme_app_aluno/utils/colors.util.dart';

class MeusDadosView extends StatefulWidget {
  @override
  _MeusDadosViewState createState() => _MeusDadosViewState();
}

class _MeusDadosViewState extends State<MeusDadosView> {
  final usuarioStore = GetIt.I.get<UsuarioStore>();

  TextEditingController _emailCtrl = new TextEditingController();
  TextEditingController _nomeMaeCtrl = new TextEditingController();
  MaskedTextController _dataNascimentoCtrl =
      new MaskedTextController(mask: '00/00/0000');
  MaskedTextController _cpfCtrl =
      new MaskedTextController(mask: '000.000.000-00');

  MaskedTextController _telefoneCtrl =
      new MaskedTextController(mask: '(00) 00000-0000');

  @override
  void initState() {
    super.initState();

    _dataNascimentoCtrl.text = usuarioStore.usuario.dataNascimento != null
        ? DateFormat("dd/MM/yyyy").format(usuarioStore.usuario.dataNascimento)
        : "";

    _cpfCtrl.text =
        usuarioStore.usuario.cpf.isNotEmpty ? usuarioStore.usuario.cpf : "";
    _telefoneCtrl.text = usuarioStore.usuario.celular.isNotEmpty
        ? usuarioStore.usuario.celular
        : "";
    _emailCtrl.text = usuarioStore.usuario.email;
    _nomeMaeCtrl.text = usuarioStore.usuario.nomeMae;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        title: Text("Dados do responsável"),
        backgroundColor: Color(0xffEEC25E),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(screenHeight * 2.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              AutoSizeText(
                "Dados do responsável",
                maxFontSize: 18,
                minFontSize: 16,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorsUtil.laranja02,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: screenHeight * 2),
                decoration: BoxDecoration(
                  color: ColorsUtil.campoDesabilitado,
                ),
                child: TextFormField(
                  initialValue: usuarioStore.usuario.nome,
                  style: TextStyle(
                      color: Color(0xff333333), fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    labelText: 'Nome completo',
                    labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                    errorStyle: TextStyle(fontWeight: FontWeight.w700),
                    // hintText: "Data de nascimento do aluno",
                    border: InputBorder.none,
                  ),
                  enabled: false,
                ),
              ),
              SizedBox(
                height: screenHeight * 1,
              ),
              Container(
                padding: EdgeInsets.only(left: screenHeight * 2),
                decoration: BoxDecoration(
                  color: ColorsUtil.campoDesabilitado,
                ),
                child: TextFormField(
                  controller: _cpfCtrl,
                  enabled: false,
                  style: TextStyle(
                      color: Color(0xff333333), fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    labelText: 'CPF do responsável',
                    labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                    errorStyle: TextStyle(fontWeight: FontWeight.w700),
                    // hintText: "Data de nascimento do aluno",
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(
                height: screenHeight * 1,
              ),
              Container(
                padding: EdgeInsets.only(left: screenHeight * 2),
                decoration: BoxDecoration(
                  color: ColorsUtil.campoDesabilitado,
                ),
                child: TextFormField(
                  controller: _dataNascimentoCtrl,
                  enabled: false,
                  style: TextStyle(
                      color: Color(0xff333333), fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    labelText: 'Data de nascimento',
                    labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                    errorStyle: TextStyle(fontWeight: FontWeight.w700),
                    // hintText: "Data de nascimento do aluno",
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(
                height: screenHeight * 1,
              ),
              Container(
                padding: EdgeInsets.only(left: screenHeight * 2),
                decoration: BoxDecoration(
                  color: ColorsUtil.campoDesabilitado,
                ),
                child: TextFormField(
                  controller: _nomeMaeCtrl,
                  enabled: false,
                  style: TextStyle(
                      color: Color(0xff333333), fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    labelText: 'Nome da mãe',
                    labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                    errorStyle: TextStyle(fontWeight: FontWeight.w700),
                    // hintText: "Data de nascimento do aluno",
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(
                height: screenHeight * 1,
              ),
              Container(
                padding: EdgeInsets.only(left: screenHeight * 2),
                decoration: BoxDecoration(
                  color: ColorsUtil.campoDesabilitado,
                ),
                child: TextFormField(
                  controller: _emailCtrl,
                  enabled: false,
                  style: TextStyle(
                      color: Color(0xff333333), fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                    errorStyle: TextStyle(fontWeight: FontWeight.w700),
                    // hintText: "Data de nascimento do aluno",
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(
                height: screenHeight * 1,
              ),
              Container(
                padding: EdgeInsets.only(left: screenHeight * 2),
                decoration: BoxDecoration(
                  color: ColorsUtil.campoDesabilitado,
                ),
                child: TextFormField(
                  controller: _telefoneCtrl,
                  enabled: false,
                  style: TextStyle(
                      color: Color(0xff333333), fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    labelText: 'Telefone',
                    labelStyle: TextStyle(color: Color(0xff8e8e8e)),
                    errorStyle: TextStyle(fontWeight: FontWeight.w700),
                    // hintText: "Data de nascimento do aluno",
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(
                height: screenHeight * 3,
              ),
              EABotaoWidget(
                text: "EDITAR DADOS",
                icon: FontAwesomeIcons.edit,
                iconColor: Color(0xffffd037),
                btnColor: Color(0xffd06d12),
                enabled: true,
                onPress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => MeusDadosEditarView()));
                },
              ),
              Divider(
                height: 0.5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: screenHeight * 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ViewData(
                      label: "Senha",
                      text: "******",
                    ),
                    SizedBox(
                      height: screenHeight * 3,
                    ),
                    EABotaoWidget(
                      text: "ALTERAR SENHA",
                      icon: FontAwesomeIcons.chevronRight,
                      iconColor: Color(0xffffd037),
                      btnColor: Color(0xffd06d12),
                      enabled: true,
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangePassword(
                                    cpf: usuarioStore.usuario.cpf,
                                    id: usuarioStore.usuario.id)));
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
