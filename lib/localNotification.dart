import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_notification/newScreen.dart';

class LocalNotification extends StatefulWidget {
  @override
  _LocalNotificationState createState() => _LocalNotificationState();
}

class _LocalNotificationState extends State<LocalNotification> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
    AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
  }

  // ignore: missing_return
  Future onSelectNotification(String payload) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return NewScreen(
        payload: payload,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.deepPurple,
        title: new Text('Flutter notification demo'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(
            Icons.notifications,
            size: 70.0,
            color: Colors.blueAccent,
          ),
          SizedBox(
            height: 15.0,
          ),
          RaisedButton(
            onPressed: showNotification,
            child: new Text(
              'Show Notification',
              style: TextStyle(fontSize: 20),
            ),
          ),
          RaisedButton(
            onPressed: showBigPictureNotification,
            child: new Text(
              'Show Big Picture Notification',
              style: TextStyle(fontSize: 20),
            ),
          ),
          RaisedButton(
            onPressed: showNotificationMediaStyle,
            child: new Text(
              'Show Notification MediaStyle',
              style: TextStyle(fontSize: 20),
            ),
          ),
          RaisedButton(
            onPressed: scheduleNotification,
            child: new Text(
              'Schedule Notification',
              style: TextStyle(fontSize: 20),
            ),
          ),
          RaisedButton(
            onPressed: cancelNotification,
            child: new Text(
              'Clear Notifications',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  showNotification() async {
    var android = new AndroidNotificationDetails(
        'id', 'channel ', 'description',
        priority: Priority.High, importance: Importance.Max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(0, ' Title', ' body ', platform,
        payload: 'Welcome to the Local Notification demo ');
  }

  Future<void> showBigPictureNotification() async {
    var bigPictureStyleInformation = BigPictureStyleInformation(
        DrawableResourceAndroidBitmap('mipmap/ic_launcher'),
        largeIcon: DrawableResourceAndroidBitmap('mipmap/ic_launcher'),
        contentTitle: 'Notification',
        htmlFormatContentTitle: true,
        summaryText: 'summaryText',
        htmlFormatSummaryText: true);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'big text channel id',
        'big text channel name',
        'big text channel description',
        styleInformation: bigPictureStyleInformation);
    var platformChannelSpecifics =
    NotificationDetails(androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.show(
        0, 'big text title', 'silent body', platformChannelSpecifics,
        payload: "big image notifications");
  }

  Future<void> showNotificationMediaStyle() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'media channel id',
      'media channel name',
      'media channel description',
      color: Colors.blue,
      enableLights: true,
      largeIcon: DrawableResourceAndroidBitmap('mipmap/ic_launcher'),
      styleInformation: MediaStyleInformation(),
    );
    var platformChannelSpecifics =
    NotificationDetails(androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.show(
        0, ' title', 'notification body', platformChannelSpecifics,
        payload: "Notification Media Style");
  }

  Future<void> scheduleNotification() async {
    var scheduledNotificationDateTime =
    DateTime.now().add(Duration(seconds: 5));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel description',
      icon: 'mipmap/ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('mipmap/ic_launcher'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'scheduled title',
        'scheduled body',
        scheduledNotificationDateTime,
        platformChannelSpecifics,
        payload: "Schedule Notification");

  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }
}
