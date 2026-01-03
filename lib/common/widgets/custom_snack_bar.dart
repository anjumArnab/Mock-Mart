import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ToasterMessageType { success, error, info }

void customSnackBar(String message, {ToasterMessageType type = ToasterMessageType.error}) {
  Get.snackbar(
    type == ToasterMessageType.success ? 'Success' : 
    type == ToasterMessageType.info ? 'Info' : 'Error',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: type == ToasterMessageType.success ? Colors.green : 
                     type == ToasterMessageType.info ? Colors.blue : Colors.red,
    colorText: Colors.white,
    duration: const Duration(seconds: 3),
  );
}