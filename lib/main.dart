import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:rebora/presentation/common/data_singleton.dart';
import 'package:rebora/presentation/common/const.dart';
import 'package:rebora/presentation/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';


late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  showFlutterNotification(message);
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var initialzationSettingsAndroid =
  const AndroidInitializationSettings('launcher_icon');

  var initialzationSettingsIOS = const DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  var initializationSettings = InitializationSettings(
      android: initialzationSettingsAndroid, iOS: initialzationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  var pushToken = await FirebaseMessaging.instance.getToken();
  pushToken = (pushToken == null) ? "" : pushToken;

  await setupFlutterNotifications();

  KakaoSdk.init(
    nativeAppKey: '52b1b73ba5ee03e9b0372ebfadce350f',
    javaScriptAppKey: '0ac5b7b5fdc4c7d5b0ee02fcef37876a',
  );

  DataSingleton();
  SharedPreferences.getInstance().then((instance) {
    instance.setString(AppConst.PUSH_TOKEN, pushToken!);

    var token = instance.getString(AppConst.LOGIN_TOKEN)??"";
    var nickName = instance.getString(AppConst.NICKNAME)??"";
    var profile = instance.getString(AppConst.PROFILE_IMAGE)??"";
    DataSingleton.token = token;
    DataSingleton.nickName = nickName;
    DataSingleton.profile = profile;
    DataSingleton.pushToken = pushToken!;

    runApp(MyApp(token: token));
  });
}

class MyApp extends StatefulWidget {

  String token = "";
  MyApp({super.key, required this.token});

  @override
  State<StatefulWidget> createState() => _MyAppState(token: this.token);
  //
  // @override
  // Widget build(BuildContext context) {
  //   return GetMaterialApp(
  //     enableLog: false,
  //     initialRoute: (token == "")?AppPages.LOGIN:AppPages.HOME,
  //     getPages: AppPages.routes,
  //   );
  // }
}
class _MyAppState extends State<MyApp> {
  String token = "";
  _MyAppState({required this.token});

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await setupFlutterNotifications();
      showFlutterNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //initialRoute: (token == "")?AppPages.LOGIN:AppPages.HOME,
    return GetMaterialApp(
      enableLog: false,
      initialRoute:AppPages.HOME,
      getPages: AppPages.routes,
    );
  }
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launcher_icon',
        ),
      ),
    );
  }
}
