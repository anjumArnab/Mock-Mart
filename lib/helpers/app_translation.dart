import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppTranslations extends Translations {
  static Map<String, Map<String, String>>? _translations;

  @override
  Map<String, Map<String, String>> get keys => _translations ?? {};

  static Future<void> loadTranslations() async {
    final enJson = await rootBundle.loadString('assets/languages/en.json');
    final bnJson = await rootBundle.loadString('assets/languages/bn.json');

    _translations = {
      'en': Map<String, String>.from(json.decode(enJson)),
      'bn': Map<String, String>.from(json.decode(bnJson)),
    };
  }
}