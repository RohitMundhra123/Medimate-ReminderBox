import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class User {
  static String? id;
  static String? email;
  static String? name;
  static String? gender;
  static List<dynamic>? medicine = [];
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static List<dynamic>? medicineTime = [];

  static Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'name': name,
      'medicine': medicine,
      'gender': gender,
      'medicineTime': medicineTime
    };
  }

  static int updateData(Map<String, dynamic> updatedData) {
    updatedData.forEach((key, value) {
      if (toJson().containsKey(key)) {
        switch (key) {
          case '_id':
            id = value;
            break;
          case 'medicine':
            medicine = value;
            for (var med in value) {
              if (med['time'] != null) {
                medicineTime!.addAll(List<String>.from(med['time']));
              }
            }
            break;
          case 'email':
            email = value;
            break;
          case 'name':
            name = value;
            break;
          case 'gender':
            gender = value;
            break;
        }
      }
    });
    User.scheduleNotifications();
    saveCandidateDataToSharedPref();
    return 200;
  }

  static Future<void> saveCandidateDataToSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('candidateData', jsonEncode(toJson()));
  }

  static void reset() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('candidateData');
  }

  static Future<bool> loadCandidateDataFromSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? candidateData = prefs.getString('candidateData');
    if (candidateData != null) {
      Map<String, dynamic> candidateDataMap =
          Map<String, dynamic>.from(json.decode(candidateData));
      updateData(candidateDataMap);
      return true;
    }
    return false;
  }

  static void initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static void scheduleNotifications() {
    flutterLocalNotificationsPlugin.cancelAll();

    for (var time in medicineTime!) {
      _scheduleNotification(time);
    }
  }

  static void _scheduleNotification(String time) async {
    var now = tz.TZDateTime.now(tz.local);
    var scheduledTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      int.parse(time.split("T")[1].split(":")[0]),
      int.parse(time.split(":")[1]),
      int.parse(time.split(":")[2].split(".")[0]),
    );

    if (scheduledTime.isAfter(now)) {
      var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'medicine_channel_id',
        'medicine_channel_name',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
      );
      var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
      );

      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Medicine Reminder',
        'It\'s time to take your medicine!',
        scheduledTime,
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }
}
