import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fructika/database/repository.dart';
import 'package:fructika/database/sql_repository.dart';
import 'package:fructika/startup_route.dart';
import 'package:fructika/utilities/shared_preferences_helper.dart';
import 'package:fructika/utilities/theme_data.dart';
import 'package:provider/provider.dart';
import 'package:sentry/sentry.dart';

final sentry = SentryClient(
    dsn: "https://040088bb63c94de7925ac3d1edac4576@sentry.io/1729976");

bool get isInDebugMode {
  bool inDebugMode = false;
  // assert only runs when the app is being debugged - sneaky
  assert(inDebugMode = true);
  return inDebugMode;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<PreferencesHelper>.value(value: SharedPreferencesHelper()),
          Provider<SentryClient>.value(value: sentry),
          Provider<Repository>.value(value: SqlRepository(initDB()))
        ],
        child: MaterialApp(
            theme: buildFructikaTheme(),
            title: 'Fructika',
            home: StartupRoute()));
  }
}

void main() async {
  bool isInDebugMode = false;

  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  runZoned<Future<Null>>(() async {
    runApp(MyApp());
  }, onError: (error, stackTrace) async {
    if (!isInDebugMode) {
      await sentry.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    }
  });
}
