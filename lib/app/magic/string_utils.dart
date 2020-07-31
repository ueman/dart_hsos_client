import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:osca_dart/app/magic/base64_converter/base64.dart';

class StringUtils {
  static String toCustomBase64(String input) {
    final bytes = utf8.encode(input);
    final base64Str = customBase64.encode(bytes);
    return base64Str;
  }

  static String toCustomBase64FromIntList(List<int> input) {
    final base64Str = customBase64.encode(input);
    return base64Str;
  }

  static List<int> toIntArray(String input) {
    return utf8.encode(input);
    //return input.codeUnits.toList();
  }

  static String convertToString(List<int> intArray) {
    return utf8.decode(intArray);
    //return intArray.map((char) => String.fromCharCode(char)).join();
    //return String.fromCharCodes(intArray);
  }

  static String toMd5(String input) {
    return md5.convert(utf8.encode(input)).toString().toUpperCase();
  }
}
