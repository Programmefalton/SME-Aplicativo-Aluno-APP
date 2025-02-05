import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sentry/sentry.dart';

import '../../controllers/autenticacao.controller.dart';
import '../../controllers/messages/messages.controller.dart';
import '../../models/message/message.dart';
import '../../screens/firstAccess/first_access.dart';
import '../../screens/messages/view_message_notification.dart';
import '../../screens/not_internet/not_internet.dart';
import '../../stores/usuario.store.dart';
import '../../utils/conection.dart';
import '../../utils/navigator.dart';
import '../index.dart';

class FluxoInicialView extends StatefulWidget {
  const FluxoInicialView({super.key});

  @override
  FluxoInicialViewState createState() => FluxoInicialViewState();
}

class FluxoInicialViewState extends State<FluxoInicialView> {
  UsuarioStore usuarioStore = GetIt.I.get<UsuarioStore>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final Stream<RemoteMessage> _firebaseonMessage = FirebaseMessaging.onMessage;
  final Stream<RemoteMessage> _firebaseonOnMessageOpenedApp = FirebaseMessaging.onMessageOpenedApp;

  final autenticacaoController = GetIt.I.get<AutenticacaoController>();
  final MessagesController _messagesController = MessagesController();

  @override
  void initState() {
    super.initState();
    initPushNotificationHandlers();
    usuarioStore.carregarUsuario();
  }

  @override
  void dispose() {
    usuarioStore.limparUsuario();
    super.dispose();
  }

  Future<void> initPushNotificationHandlers() async {
    try {
      _firebaseMessaging.requestPermission();
      _firebaseMessaging.getToken().then((print));
      _firebaseMessaging.subscribeToTopic('AppAluno');
      _firebaseMessaging.getInitialMessage().then((message) async {
        if (message != null) {
          await navigateToMessageView(message.data);
        }
      });
      _firebaseonMessage.listen((RemoteMessage message) async {
        await popUpNotification(message.data);
      });
      _firebaseonOnMessageOpenedApp.listen((event) async {
        await navigateToMessageView(event.data);
      });
      FirebaseMessaging.onBackgroundMessage(
        (message) async {
          await navigateToMessageView(message.data);
        },
      );
    } catch (ex) {
      GetIt.I.get<SentryClient>().captureException('initPushNotificationHandlers $ex');
    }
  }

  Future<void> popUpNotification(Map<String, dynamic> message) async {
    AwesomeDialog(
      context: context,
      headerAnimationLoop: true,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: "NOTIFICAÇÃO - ${message["categoriaNotificacao"]}",
      desc: 'Você acaba de receber uma \n mensagem.',
      btnOkOnPress: () {
        navigateToMessageView(message);
      },
      btnOkText: 'VISUALIZAR',
    ).show();
  }

  Future<void> navigateToMessageView(Map<String, dynamic> message) async {
    final Message message0 = Message(
      id: int.parse(message['Id']),
      titulo: message['Titulo'],
      mensagem: message['Mensagem'],
      criadoEm: message['CriadoEm'],
      codigoEOL: message['CodigoEOL'] != null ? int.parse(message['CodigoEOL']) : 0,
      categoriaNotificacao: message['categoriaNotificacao'],
      dataEnvio: message['DataEnvio'] ?? DateTime.now().toIso8601String(),
      alteradoEm: message['AlteradoEm'] ?? '',
      mensagemVisualizada: message['MensagemVisualizada'] ?? false,
    );

    await _messagesController.loadById(message0.id, usuarioStore.usuario!.id);
    message0.mensagem = _messagesController.message!.mensagem;
    if (mounted) {
      Nav.push(
        context,
        ViewMessageNotification(
          message: message0,
          userId: usuarioStore.usuario!.id,
        ),
      );
    }
  }

  Widget fluxoLogin() {
    if (usuarioStore.usuario!.primeiroAcesso) {
      return FirstAccess(
        id: usuarioStore.usuario!.id,
        cpf: usuarioStore.usuario!.cpf,
      );
    } else if (usuarioStore.usuario!.atualizarDadosCadastrais) {
      return const AtualizacaoCadastralView();
    } else {
      return const EstudanteListaView();
    }
  }

  @override
  Widget build(BuildContext context) {
    final connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.offline) {
      return const NotInteernet();
    } else {
      return Observer(
        builder: (context) => usuarioStore.usuario?.id == null
            ? const LoginView(
                notice: null,
              )
            : (usuarioStore.usuario?.primeiroAcesso != false
                ? const LoginView(
                    notice: null,
                  )
                : fluxoLogin()),
      );
    }
  }
}
