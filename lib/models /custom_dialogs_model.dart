import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/services.dart';


class CustomAlertDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget> actions;

  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoAlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: content,
      actions: actions,
    )
        : AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: content,
      actions: actions,
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String placeholder;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.inputFormatters,
    this.keyboardType,
    required this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
      controller: controller,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      placeholder: placeholder,
    )
        : TextField(
      controller: controller,
      inputFormatters: inputFormatters ?? [],
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        hintText: placeholder,
      ),
    );
  }
}

class CustomDialogAction extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomDialogAction({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoDialogAction(
      onPressed: onPressed,
      child: Text(text),
    )
        : TextButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}