import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sme_app_aluno/controllers/messages.controller.dart';

class EAQFilterPage extends StatefulWidget {
  @override
  _EAQFilterPageState createState() => _EAQFilterPageState();
}

class _EAQFilterPageState extends State<EAQFilterPage> {
  MessagesController _messagesController;

  bool turmaCheck = true;
  bool smeCheck = true;
  bool ueCheck = true;

  @override
  void initState() {
    super.initState();
    _messagesController = MessagesController();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenHeight * 10),
      ),
      margin: EdgeInsets.only(top: screenHeight * 4),
      padding: EdgeInsets.only(
          left: screenHeight * 1.5,
          top: screenHeight * 1,
          right: screenHeight * 1,
          bottom: screenHeight * 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          AutoSizeText(
            "Filtro:",
            maxFontSize: 14,
            minFontSize: 12,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xff666666)),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                turmaCheck = !turmaCheck;
              });
              _messagesController.filterItems(turmaCheck, smeCheck, ueCheck);
            },
            child: Chip(
              backgroundColor:
                  turmaCheck ? Color(0xffC5DBA0) : Color(0xffDADADA),
              avatar: turmaCheck
                  ? Icon(
                      FontAwesomeIcons.check,
                      size: screenHeight * 2,
                    )
                  : null,
              label: AutoSizeText(
                "TURMA",
                style: TextStyle(color: Color(0xff42474A)),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                smeCheck = !smeCheck;
              });
              _messagesController.filterItems(turmaCheck, smeCheck, ueCheck);
            },
            child: Chip(
              backgroundColor: smeCheck ? Color(0xffEFA2FC) : Color(0xffDADADA),
              avatar: smeCheck
                  ? Icon(
                      FontAwesomeIcons.check,
                      size: screenHeight * 2,
                    )
                  : null,
              label: AutoSizeText("SME",
                  style: TextStyle(color: Color(0xff42474A))),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                ueCheck = !ueCheck;
              });
              _messagesController.filterItems(turmaCheck, smeCheck, ueCheck);
            },
            child: Chip(
              backgroundColor: ueCheck ? Color(0xffC7C7FF) : Color(0xffDADADA),
              avatar: ueCheck
                  ? Icon(
                      FontAwesomeIcons.check,
                      size: screenHeight * 2,
                    )
                  : null,
              label: AutoSizeText("UE",
                  style: TextStyle(color: Color(0xff42474A))),
            ),
          )
        ],
      ),
    );
  }
}
