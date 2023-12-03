import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static late NotificationDetails notificationDetails;
  // Variável para receber a mensagem de erro em caso de falha no uso da
  // notificação.
  static var notificationsChannelInitializationError = '';
  // Variável para receber o Future retornado pela
  // função initializeNotificationsChannel
  late Future<bool> futureInitializeNotificationsChannel;

  static Future<bool> initializeNotificationsChannel() async {
    try {
      // Cria o objeto que controla a notificação
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      // Verifica se o usuário libera as notificações
      bool? response = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();

      // Carrega dados inicialização para o Android
      const androidInitializationSettings =
          AndroidInitializationSettings('@drawable/ifsp_logo');

      // Para informar ao plugin
      // configurações de inicialiação de diferentes plataformas
      // Ex: Linux, iOS, Android, etc.
      const initializationSettings =
          InitializationSettings(android: androidInitializationSettings);

      // Inicialização do plugin de notificação
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
      );

      // Dados necessários para se criar um canal de notificações
      // para uma plataforma específica.
      // No caso estamos utilizando o Android.
      const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'ifsp01',
        'IFSP Notificações',
        actions: <AndroidNotificationAction>[],
      );

      // Objeto que carrega os dados específico para a criação do canal
      notificationDetails =
          const NotificationDetails(android: androidPlatformChannelSpecifics);
      return true;
    } catch (error) {
      print(error.toString());
      notificationsChannelInitializationError =
          'Não foi possível inicializar o canal de notificações';
      return false;
    }
  }

  static Future<void> showNotification(
      String notificationTitle, String notificationBody) {
    // Cada notificação pode ter um id próprio. Adicionado aqui para
    // passar como argumento.
    const int idNotification = 0;
    print("Chamando notificação...");
    return flutterLocalNotificationsPlugin.show(
      idNotification,
      notificationTitle,
      notificationBody,
      notificationDetails,
    );
  }
}
