import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pushnotification/service_notification.dart';

import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final service  = LocalNotificationService();
  await service.intialize();


 var per =  await FirebaseMessaging.instance.requestPermission();

 if(per.authorizationStatus == AuthorizationStatus.authorized){
   print('...........................Notification is initialized!!!!!!!');
 }



  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.getToken().then((value){
    print(value);
  });


  //
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');

      service.showNotification(id: 12, title: message.notification!.title!, body: message.notification!.body!);
    }
  });

 FirebaseMessaging.onBackgroundMessage(backNotification);


 FirebaseMessaging.onMessageOpenedApp.listen((event) {

   print('Got a message  lll whilst in the distroy!');
   print('Message data: ${event.data}');

   if (event.notification != null) {
     print('Message also contained a notification: ${event.notification!.body}');
   }

 });
  runApp(const MyApp());
}

Future<void>  backNotification(RemoteMessage msg) async{
  print('Got a message whilst in the back!');
  print('Message data: ${msg.data}');

  if (msg.notification != null) {
    print('Message also contained a notification: ${msg.notification!.body}');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
