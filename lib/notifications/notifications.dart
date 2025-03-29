import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin notifications =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications(BuildContext context) async {
  // Configuración para Android
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('libro');

  // Configuración general de inicialización
  final InitializationSettings initSettings = InitializationSettings(
    android: androidSettings,
  );

  // Inicializar notificaciones con el callback al tocar la notificación
  await notifications.initialize(
    initSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      // Mostrar un diálogo al tocar la notificación
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Notificación tocada"),
          content: Text(response.payload ?? "Sin datos"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok!'),
            ),
          ],
        ),
      );
    },
  );
}

void startReadingReminder() {
  // Programar un recordatorio después de 4 segundos
  Future.delayed(const Duration(seconds: 4), _showNotification);
}

Future<void> _showNotification() async {
  const AndroidNotificationDetails androidSpecifics = AndroidNotificationDetails(
    'channel_id',
    'Recordatorio de lectura',
    channelDescription: 'Notificación para recordar leer',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidSpecifics);

  await notifications.show(
    111, // ID único de la notificación
    "Mensaje de Booksy",
    "Recuerda leer 15 páginas de tu libro",
    notificationDetails,
    payload: "20",
  );
}
