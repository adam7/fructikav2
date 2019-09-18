import 'package:flutter/material.dart';
import 'package:fructika/database/sql_database_provider.dart';
import 'package:fructika/search_route.dart';
import 'package:fructika/shared_preferences_helper.dart';
import 'package:fructika/theme_data.dart';
import 'package:sentry/sentry.dart';

var sentry = SentryClient(dsn: "https://040088bb63c94de7925ac3d1edac4576@sentry.io/1729976");

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: buildFructikaTheme(),
        title: 'Fructika',
        home: SearchRoute(SqlDatabaseProvider.db, SharedPreferencesHelper()));
  }
}

void main() async {
  try {
    runApp(MyApp());
  } catch (error, stackTrace) {
    await sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
  }
}