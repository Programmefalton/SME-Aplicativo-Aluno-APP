import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:provider/provider.dart';
import 'package:sme_app_aluno/controllers/messages.controller.dart';
import 'package:sme_app_aluno/models/student/student.dart';
import 'package:sme_app_aluno/screens/widgets/cards/index.dart';
import 'package:sme_app_aluno/screens/drawer_menu/drawer_menu.dart';
import 'package:sme_app_aluno/screens/widgets/tag/tag_custom.dart';

class Dashboard extends StatefulWidget {
  final Student student;
  final String groupSchool;
  final String token;

  Dashboard(
      {@required this.student,
      @required this.groupSchool,
      @required this.token});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  MessagesController _messagesController;

  @override
  void initState() {
    super.initState();
    _messagesController = MessagesController();
    _messagesController.loadMessages(token: widget.token);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        title: Text("Resumo do Estudante"),
        backgroundColor: Color(0xffEEC25E),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(screenHeight * 2.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: screenHeight * 2.5,
              ),
              TagCustom(
                  text: widget.groupSchool ?? "Não informado",
                  color: Color(0xffEEC25E),
                  textColor: Color(0xffD06D12)),
              CardResumeStudent(
                student: widget.student,
              ),
              Observer(builder: (context) {
                if (_messagesController.messages != null &&
                    _messagesController.messages.isNotEmpty) {
                  return Visibility(
                      visible: _messagesController.isLoading,
                      child: GFLoader(
                        type: GFLoaderType.square,
                        loaderColorOne: Color(0xffDE9524),
                        loaderColorTwo: Color(0xffC65D00),
                        loaderColorThree: Color(0xffC65D00),
                        size: GFSize.LARGE,
                      ),
                      replacement: CardRecentMessage(
                        message: _messagesController.messages.first,
                        countMessages: _messagesController.messages.length,
                        token: widget.token,
                      ));
                } else {
                  return CardRecentMessage();
                }
              }),
              CardAlert(
                title: "ALERTA DE NOTAS",
                icon: Icon(
                  FontAwesomeIcons.envelopeOpen,
                  color: Color(0xffFFD037),
                  size: screenHeight * 6,
                ),
                text:
                    "Em breve você visualizará alertas de notas neste espaço. Aguarde as próximas atualizações do aplicativo.",
              ),
              CardAlert(
                title: "ALERTA DE FREQUÊNCIA",
                icon: Icon(
                  FontAwesomeIcons.envelopeOpen,
                  color: Color(0xffFFD037),
                  size: screenHeight * 6,
                ),
                text:
                    "Em breve você visualizará alertas de frequência neste espaço. Aguarde as próximas atualizações do aplicativo.",
              )
            ],
          ),
        ),
      ),
      drawer: DrawerMenu(
        student: widget.student,
      ),
    );
  }
}
