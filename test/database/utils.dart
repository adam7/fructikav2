  import 'package:flutter_test/flutter_test.dart';
  
  _simplify(String string) {
    return string.replaceAll(RegExp(r"\s+"), " ");
  }

  isSqlEqual(final String actual, final String expected) {
    expect(_simplify(actual), equals(_simplify(expected)));
  }