import 'package:flutter/material.dart';
import 'package:simple/Reusable/color.dart';

/// A utility class for consistent text styles throughout the application.
/// Uses "Poppins" font family.
class MyTextStyle {
  static TextStyle f55(Color color,
      {FontWeight? weight,
        FontStyle? fontStyle,
        Color? decorationColor,
        TextDecoration? textDecoration}) {
    return TextStyle(
      fontFamily: "Times New Roman",
      color: color,
      fontSize: 48,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: weight ?? FontWeight.w600,
      decoration: textDecoration,
      decorationColor: decorationColor,
    );
  }
  static TextStyle f48(Color color,
      {FontWeight? weight,
        FontStyle? fontStyle,
        Color? decorationColor,
        TextDecoration? textDecoration}) {
    return TextStyle(
      fontFamily: "Times New Roman",
      color: color,
      fontSize: 48,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: weight ?? FontWeight.w600,
      decoration: textDecoration,
      decorationColor: decorationColor,
    );
  }

  static TextStyle f38(Color color,
      {FontWeight? weight,
        FontStyle? fontStyle,
        Color? decorationColor, // Changed to Color? for consistency
        TextDecoration? textDecoration}) {
    return TextStyle(
      fontFamily: "Times New Roman",
      color: color,
      fontSize: 38,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: weight ?? FontWeight.w600,
      decoration: textDecoration,
      decorationColor: decorationColor,
    );
  }

  static TextStyle f36(Color color,
      {FontWeight? weight,
        FontStyle? fontStyle,
        Color? decorationColor,
        TextDecoration? textDecoration
      }) {
    return TextStyle(
      fontFamily: "Times New Roman",
      color: color,
      fontSize: 36,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: weight ?? FontWeight.w600,
      decoration: textDecoration,
      decorationColor: decorationColor,
    );
  }
  

  static TextStyle f32(
      Color color, {
        FontWeight? weight,
        FontStyle? fontStyle,
      }) {
    return TextStyle(
      fontFamily: "Times New Roman",
      color: color,
      fontSize: 32,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: weight ?? FontWeight.w600,
    );
  }

  static TextStyle f30(
      Color color, {
        FontWeight? weight,
        FontStyle? fontStyle,
      }) {
    return TextStyle(
      fontFamily: "Times New Roman",
      color: color,
      fontSize: 30, // Corrected from 32
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: weight ?? FontWeight.w600,
    );
  }

  static TextStyle f28(
      Color color, {
        FontWeight? weight,
        FontStyle? fontStyle,
      }) {
    return TextStyle(
      fontFamily: "Times New Roman",
      color: color,
      fontSize: 28, // Corrected from 32
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: weight ?? FontWeight.w600,
    );
  }

  static TextStyle f26(
      Color color, {
        FontWeight? weight,
        FontStyle? fontStyle,
      }) {
    return TextStyle(
      fontFamily: "Times New Roman",
      color: color,
      fontSize: 26, // Corrected from 24
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: weight ?? FontWeight.w600,
    );
  }

  static TextStyle f24(
      Color color, {
        FontWeight? weight,
        FontStyle? fontStyle,
      }) {
    return TextStyle(
      fontFamily: "Times New Roman",
      color: color,
      fontSize: 24, // Corrected from 24 (was correct)
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: weight ?? FontWeight.w600,
    );
  }

  static TextStyle f22(Color color,
      {FontWeight? weight,
        FontStyle? fontStyle,
        Color? decorationColor,
        TextDecoration? textDecoration}) {
    return TextStyle(
      fontFamily: "Times New Roman",
      color: color,
      fontSize: 22,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: weight ?? FontWeight.w600,
      decoration: textDecoration,
      decorationColor: decorationColor,
    );
  }

  static TextStyle f20(
      Color color, {
        FontWeight? weight,
        FontStyle? fontStyle,
      }) {
    return TextStyle(
      fontFamily: "Times New Roman",
      color: color,
      fontSize: 20,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: weight ?? FontWeight.bold,
    );
  }

  static TextStyle f18(Color color,
      {FontWeight? weight,
        FontStyle? fontStyle,
        Color? decorationColor,
        TextDecoration? textDecoration}) {
    return TextStyle(
      fontFamily: "Times New Roman",
      color: color,
      fontSize: 18,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: weight ?? FontWeight.w500,
      decoration: textDecoration,
      decorationColor: decorationColor,
    );
  }

  static TextStyle f17(
      Color color, {
        FontWeight? weight,
        FontStyle? fontStyle,
      }) {
    return TextStyle(
      fontFamily: "Times New Roman",
      color: color,
      fontSize: 17,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: weight ?? FontWeight.w500,
    );
  }

  static TextStyle f58(
      Color color, {
        FontWeight? weight,
        FontStyle? fontStyle,
        double? height,
      }) {
    return TextStyle(
      fontFamily: "Times New Roman",
      color: color,
      fontSize: 58,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: weight ?? FontWeight.w500,
    );
  }
  static TextStyle f16(
      Color color, {
        FontWeight? weight,
        FontStyle? fontStyle,
        double? height,
      }) {
    return TextStyle(
      fontFamily: "Times New Roman",
      color: color,
      fontSize: 16,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: weight ?? FontWeight.w500,

    );
  }

  static TextStyle f15(Color color,
      {FontWeight? weight,
        FontStyle? fontStyle,
        Color? decorationColor,
        TextDecoration? textDecoration}) {
    return TextStyle(
      fontFamily: "Times New Roman",
      color: color,
      fontSize: 15,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: weight ?? FontWeight.w500,
      decoration: textDecoration,
      decorationColor: decorationColor,
    );
  }

  static TextStyle f14(
      Color color, {
        FontWeight? weight,
        FontStyle? fontStyle,
        Color? decorationColor,
        TextDecoration? textDecoration,
      }) {
    return TextStyle(
      fontFamily: "Times New Roman",
      color: color,
      fontSize: 14,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: weight ?? FontWeight.w500,
      decoration: textDecoration,
      decorationColor: decorationColor,
    );
  }

  static TextStyle f13(
      Color color, {
        FontWeight? weight,
        FontStyle? fontStyle,
      }) {
    return TextStyle(
      fontFamily: "Times New Roman",
      color: color,
      fontSize: 13,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: weight ?? FontWeight.w500,
    );
  }

  static TextStyle f12(Color color,
      {FontWeight? weight,
        FontStyle? fontStyle,
        Color? decorationColor,
        TextDecoration? textDecoration}) {
    return TextStyle(
      fontFamily: "Times New Roman",
      color: color,
      fontSize: 12,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: weight ?? FontWeight.w500,
      decoration: textDecoration,
      decorationColor: decorationColor,
    );
  }

  static TextStyle f10(Color color,
      {FontWeight? weight,
        FontStyle? fontStyle,
        Color? decorationColor,
        TextDecoration? textDecoration}) {
    return TextStyle(
      fontFamily: "Times New Roman",
      color: color,
      fontSize: 10,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: weight ?? FontWeight.w500,
      decoration: textDecoration,
      decorationColor: decorationColor,
    );
  }

  static TextStyle f8(
      Color color, {
        FontWeight? weight,
        FontStyle? fontStyle,
      }) {
    return TextStyle(
      fontFamily: "Times New Roman",
      color: color,
      fontSize: 8,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: weight ?? FontWeight.w500,
    );
  }
}


/// A custom default button widget, leveraging [MyTextStyle].
/// Renamed from DefaultButton to avoid potential conflicts and for clarity.
class AppDefaultButton extends StatelessWidget {
  const AppDefaultButton({
    super.key,
    this.height,
    this.width,
    this.fontSize, // kept for flexibility but MyTextStyle f14 is used by default
    required this.buttonText,
    this.decoration, // kept for flexibility but current BoxDecoration is hardcoded
    this.onTap, // Added onTap callback
  });

  final double? height;
  final double? width;
  final double? fontSize;
  final String buttonText;
  final BoxDecoration? decoration;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: decoration ??
            BoxDecoration(
              color: appPrimaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
        child: Center(
          child: Text(
            buttonText,
            style: MyTextStyle.f14(
              whiteColor,
              weight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

/// Predefined common application text styles for quick use.
class AppTextStyle {
  static TextStyle boldWhite16 = MyTextStyle.f16(
    whiteColor,
    weight: FontWeight.w700,
  );

  static TextStyle boldBlack18 = MyTextStyle.f18(
    blackColor,
    weight: FontWeight.w700,
  );

  static TextStyle mediumBlack14 = MyTextStyle.f14(
    blackColor,
    weight: FontWeight.w500,
  );

}
