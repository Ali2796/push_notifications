import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('notification'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(onPressed: () async{
          sendNotification();
        }, child:const  Text('send')),
      ),
    );
  }

  void sendNotification()  async{


    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    var response = await http.post(url,headers: {
      'Content-Type' : 'application/json',
      'Authorization' : 'key=AAAAeJ1iqEM:APA91bHD7XaYWgQrt_zWi95Vfx_WIJ1yyh3usAgvXTvUTtmNCcZPX0y8GNi7YyKFmA1umpUoSJTifreBYlaTTWHyxDBQt0vysa7SemVBzy1KZvacSu9s1EWZr56d7-osDe4L_PQoERnh'
    }, body: jsonEncode({
      "priority" : "high",
      'to' : 'cFC2nUM5Te-AsDtwjLo-0R:APA91bGbuQxYJfMU_FPBpe5cCQQplO2qfsG2Ce7tGOUjzAqsZUkfwve-stg154alxzV9beNnMrFz5Jt48cLbfazpVieVGPBi3YCozT3xBJBvo7CAb93BHZkxDOblKcl8rzmk0tuZ135W',
      "notification" :
      {
        "body" : "my notification is sending",
        "title" : "this is the title",
        "android_channel_id" :  "channelId"

      }
    }));



    print(response.statusCode);
  }
}

