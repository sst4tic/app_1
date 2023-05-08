import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSize searchModel(context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(45),
    child: Padding(
      padding: REdgeInsets.only(
        left: 11,
        right: 11,
        bottom: 10,
      ),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          readOnly: true,
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
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
        ),
      ),
    ),
  );
}