
import 'package:flutter/services.dart';
import 'package:fructika/database/repository.dart';
import 'package:fructika/utilities/shared_preferences_helper.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';


class MockPreferencesHelper extends Mock implements PreferencesHelper {}
class MockRepository extends Mock implements Repository {}
class MockDatabase extends Mock implements Database {}
class MockBatch extends Mock implements Batch {}
class MockAssetBundle extends Mock implements CachingAssetBundle {}
