import 'package:flutter/material.dart';

PreferredSize searchModel({required BuildContext context, required Function(String) onSubmitted}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(50.0),
    child:
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Поиск',
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          filled: true,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          contentPadding: const EdgeInsets.all(8),
          enabledBorder:  const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        onSubmitted: (value) => onSubmitted(value),
      ),
    ),
  );
}