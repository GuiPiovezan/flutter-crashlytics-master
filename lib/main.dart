import 'dart:async';

import 'package:alura_crashlytics/screens/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {
      FirebaseCrashlytics.instance.setUserIdentifier('123456789');
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    }

    runApp(BytebankApp());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green[900],
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(71, 161, 56, 1),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Color.fromRGBO(71, 161, 56, 1),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Dashboard(),
    );
  }
}
