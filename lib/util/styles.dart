import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// final darkTheme = ThemeData(
//   primaryColor: Colors.black,
//   accentColor: ColorStyles.accentColor,
//   canvasColor: Colors.white,
//   disabledColor: Colors.white,
//   primaryColorLight: Colors.white,
//   scaffoldBackgroundColor: ColorStyles.bodyColorDark,
//   brightness: Brightness.dark,
//   progressIndicatorTheme: const ProgressIndicatorThemeData(
//     color: Colors.white,
//   ),
//   appBarTheme: AppBarTheme(
//     titleTextStyle: const TextStyle(
//         color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
//     elevation: Platform.isIOS ? 0 : 1,
//     color: ColorStyles.accentColor,
//     iconTheme: const IconThemeData(color: ColorStyles.bodyColor),
//   ),
//   sliderTheme: const SliderThemeData(
//     overlayColor: Colors.transparent,
//   ),
//   textTheme: const TextTheme(
//     bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
//     bodyMedium: TextStyle(fontSize: 12, color: Colors.white),
//     titleMedium: TextStyle(
//         fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
//     // appbar title
//     titleSmall: TextStyle(
//         color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
//   ),
//   radioTheme: RadioThemeData(
//     fillColor: MaterialStateProperty.all(Colors.white),
//   ),
//   fontFamily: 'NotoSans',
//   elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ButtonStyle(
//           backgroundColor:
//               MaterialStateProperty.all<Color>(ColorStyles.primaryColor))),
//   textSelectionTheme: const TextSelectionThemeData(
//     cursorColor: Colors.white,
//   ),
//   inputDecorationTheme: InputDecorationTheme(
//     labelStyle: TextStyle(
//       color: Colors.white,
//       fontSize: 16.sp,
//     ),
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(18),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: const BorderSide(color: Colors.white, width: 1),
//       borderRadius: BorderRadius.circular(18),
//     ),
//     errorBorder: OutlineInputBorder(
//       borderSide: const BorderSide(color: Colors.red, width: 1),
//       borderRadius: BorderRadius.circular(18),
//     ),
//   ),
//   expansionTileTheme: const ExpansionTileThemeData(
//       textColor: Colors.white, iconColor: Colors.grey
//       // collapsedTextColor: Colors.white
//       ),
//   textButtonTheme: TextButtonThemeData(
//     style: ButtonStyle(
//       foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//       textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.bold,
//       )),
//     ),
//   ),
//   tabBarTheme: TabBarTheme(
//     labelColor: Colors.white,
//     unselectedLabelColor: Colors.grey,
//     indicator: BoxDecoration(
//       borderRadius: const BorderRadius.all(
//         Radius.circular(10.0),
//       ),
//       color: Colors.grey[800]!,
//     ),
//     labelStyle: const TextStyle(),
//   ),
// );

final lightTheme = ThemeData(
  primaryColor: Colors.white,
  hintColor: Colors.white,
  canvasColor:ColorStyles.bodyColor,
  disabledColor: ColorStyles.primaryColor,
  primaryColorLight: Colors.black,
  scaffoldBackgroundColor: ColorStyles.bodyColor,
  brightness: Brightness.light,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: ColorStyles.primaryColor,
  ),
  checkboxTheme: CheckboxThemeData(
    side: const BorderSide(color: Colors.white, width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: const TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
    elevation: Platform.isIOS ? 0 : 1,
    color: Colors.white,
    iconTheme: const IconThemeData(color: ColorStyles.primaryColor),
  ),
  sliderTheme: const SliderThemeData(
    overlayColor: Colors.transparent,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.black),
    titleMedium: TextStyle(
        fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
    // appbar title
    titleSmall: TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(ColorStyles.primaryColor),
  ),
  listTileTheme: const ListTileThemeData(
    tileColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
  ),
  fontFamily: 'NotoSans',
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.blue),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      )
  ),
  textSelectionTheme:
      const TextSelectionThemeData(cursorColor: ColorStyles.primaryColor),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: REdgeInsets.symmetric(horizontal: 20.0),
    filled: true,
    fillColor: ColorStyles.bodyColor,
    labelStyle: TextStyle(
      color: Colors.grey,
      fontSize: 12.sp,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    disabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),
  expansionTileTheme: const ExpansionTileThemeData(
      collapsedTextColor: ColorStyles.primaryColor,
      textColor: ColorStyles.primaryColor,
      iconColor: Colors.grey
      // collapsedTextColor: Colors.white
      ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor:
          MaterialStateProperty.all<Color>(ColorStyles.primaryColor),
      textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      )),
    ),
  ),
  // tabBarTheme: const TabBarTheme(
  //   labelColor: Colors.white,
  //   unselectedLabelColor: Colors.grey,
  //   indicator: BoxDecoration(
  //     borderRadius: BorderRadius.all(
  //       Radius.circular(10.0),
  //     ),
  //     color: ColorStyles.primaryColor,
  //   ),
  // ),
  indicatorColor: Colors.black,
);

class TextStyles {
  static const TextStyle dialogContentStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle appBarTitle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
  static const TextStyle headerStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static const TextStyle loginTitle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black);
  static TextStyle headerStyle2 = TextStyle(
      fontSize: 11, fontWeight: FontWeight.w400, color: Colors.grey[600]!);
  static TextStyle bodyStyle = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
  );
  static TextStyle editStyle = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    color: Colors.grey[600],
  );
}

class ColorStyles {
  static const Color accentColor = Color.fromRGBO(34, 34, 34, 1);
  static const Color bodyColorDark = Color.fromRGBO(20, 20, 20, 1);
  static const Color bodyColor = Color.fromRGBO(245, 248, 250, 1);
  static const Color primaryColor = Color.fromRGBO(43, 46, 74, 1);
  static Color lightShimmerBaseColor = Colors.grey[200]!;
  static Color lightShimmerHighlightColor = Colors.grey[100]!;
  static Color darkShimmerBaseColor = Colors.grey[800]!;
  static Color darkShimmerHighlightColor = Colors.grey[700]!;
}

class Decorations {
  static InputDecoration dropdownDecoration = InputDecoration(
    contentPadding: REdgeInsets.symmetric(horizontal: 10, vertical: 5),
    filled: true,
    fillColor: ColorStyles.bodyColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
  );

  static BoxDecoration containerDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    color: Colors.white,
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 5.0,
        offset: Offset(0, 2),
      ),
    ],
  );
}

class GridDelegateClass {
  static SliverGridDelegateWithFixedCrossAxisCount gridDelegate =
      SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 20.w / 13.5.h,
    crossAxisSpacing: 8.8.w,
    mainAxisSpacing: 10.h,
  );
}
