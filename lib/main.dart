import 'package:booksy_app/bookshelf/bookshelf_screen.dart';
import 'package:booksy_app/categories/categories_screen.dart';
import 'package:booksy_app/home/home_screen.dart';
import 'package:booksy_app/state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("📩 Notificación en segundo plano: ${message.notification?.title}");
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await initNotifications();
  runApp(const BooksyApp());
}

class BooksyApp extends StatelessWidget {
  const BooksyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookshelfBloc(BookshelfState([])),
      child: MaterialApp(
        title: 'Booksy',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            primary: Colors.green,
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
        home: const BottomNavigationWidget(),
      ),
    );
  }
}

Future<void> initNotifications() async {
  var fcmToken = await FirebaseMessaging.instance.getToken();
  debugPrint("🔑 Token FCM: $fcmToken");

  initLocalNotifications();
  initPushNotifications();
 
  
  if (Platform.isAndroid) {
    FirebaseMessaging.instance.requestPermission();
  }

  



  

 

 

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint("📩 Notificación abierta: ${message.notification?.title}");
  });
}

void initPushNotifications() async {
 FirebaseMessaging.onMessage.listen(_onRemoteMessageRecived);
 FirebaseMessaging.onBackgroundMessage(_onBackgroundMessageRecived);
   
}
Future<void> _onBackgroundMessageRecived(RemoteMessage message) async {
   debugPrint(" Notificación recibida en background");
   debugPrint(" Titulo: ${message.notification?.body ?? "Sin body"}");
   debugPrint(" Body:  ${message.notification?.body ?? "Sin body"}");
  

}
void _onRemoteMessageRecived(RemoteMessage message) {
    debugPrint(" Notificación recibida: ${message.notification?.body ?? "Sin body"}");
    _showNotification(message.notification?.title ?? "Sin titulo", message.notification?.body ?? "Sin body");
}

Future<void> initLocalNotifications() async {
  FlutterLocalNotificationsPlugin notifications = FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('libro');

  const InitializationSettings initSettings = InitializationSettings(
    android: androidSettings,
  );

  await notifications.initialize(
    initSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      // Verifica si hay un payload
      if (response.payload != null) {
        print("Notificación apretada con payload: ${response.payload}");
        // Aquí podrías manejar la navegación o mostrar un diálogo en un contexto válido
      }
    },
  );
}

void startReadingReminder(){
  Future.delayed(const Duration(seconds: 4), () {
    _showNotification("Un mensaje de tu amigo booksy", "Recordatorio para leer");
  });
}


Future<void> _showNotification(String title, String body) async {
  FlutterLocalNotificationsPlugin notifications =
    FlutterLocalNotificationsPlugin();
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'default_channel_id',
    'Notificaciones',
    importance: Importance.max,
    priority: Priority.high,
  );

  notifications.show(111, title, body, const NotificationDetails(android: androidDetails),);

}

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  State<StatefulWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _selectedIndex = 0;
  static List<Widget> _sections = [
    const HomeScreen(),
    const CategoriesScreen(),
    BookshelfScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booksy')),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.local_library), label: 'Biblioteca'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_stories), label: 'Mi Estante'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: _sections[_selectedIndex],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
