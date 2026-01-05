import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbarWithoutTitle(String message, {Color? color}) {
  Get.rawSnackbar(
    snackPosition: SnackPosition.TOP,
    backgroundColor: color ?? Colors.green,
    borderRadius: 12,
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    messageText: Text(
      message,
      style: TextStyle(color: Colors.white, fontSize: 14),
      textAlign: TextAlign.start,
    ),
  );
}
