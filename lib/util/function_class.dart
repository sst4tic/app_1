import 'package:flutter/material.dart';

class Func {
  showSnackbar(context, String text, bool success) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style:
        TextStyle(color: success ? Colors.green : Colors.red, fontSize: 17),
      ),
      backgroundColor: Colors.black87,
    ));
  }
  String strLimit(String str, int limit) {
    if (str.length <= limit) {
      return str;
    }
    return '${str.substring(0, limit)}...';
  }
}