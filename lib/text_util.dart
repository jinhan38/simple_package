import 'package:flutter/material.dart';

class TextUtil {
  static Widget get17Bold(
    BuildContext context,
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Color color = Colors.black,
    int? maxLines,
    bool softWrap = true,
    TextOverflow? overflow,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return Text(
      text,
      style: style ?? getTitleLargeStyle(context, color, fontWeight),
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
      overflow: overflow,
      textHeightBehavior: const TextHeightBehavior(applyHeightToLastDescent: false),
    );
  }

  static Widget get14w600(
    BuildContext context,
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Color color = Colors.black,
    int? maxLines,
    bool softWrap = true,
    TextOverflow? overflow,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return Text(
      text,
      style: style ?? getTitleMediumStyle(context, color, fontWeight),
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
      overflow: overflow,
      textHeightBehavior: const TextHeightBehavior(applyHeightToLastDescent: false),
    );
  }

  static Widget get12w500(
    BuildContext context,
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Color color = Colors.black,
    int? maxLines,
    bool softWrap = true,
    TextOverflow? overflow,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return Text(
      text,
      style: style ?? getTitleSmallStyle(context, color, fontWeight),
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
      overflow: overflow,
      textHeightBehavior: const TextHeightBehavior(applyHeightToLastDescent: false),
    );
  }

  static Widget get12Normal(
    BuildContext context,
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Color color = Colors.black,
    int? maxLines,
    bool softWrap = true,
    TextOverflow? overflow,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return Text(
      text,
      style: style ?? getBodyLargeStyle(context, color, fontWeight),
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
      overflow: overflow,
      textHeightBehavior: const TextHeightBehavior(applyHeightToLastDescent: false),
    );
  }

  static Widget get10w500(
    BuildContext context,
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Color color = Colors.black,
    int? maxLines,
    bool softWrap = true,
    TextOverflow? overflow,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return Text(
      text,
      style: style ?? getBodyMediumStyle(context, color, fontWeight),
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
      overflow: overflow,
      textHeightBehavior: const TextHeightBehavior(applyHeightToLastDescent: false),
    );
  }

  static Widget get9w500(
    BuildContext context,
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Color color = Colors.black,
    int? maxLines,
    bool softWrap = true,
    TextOverflow? overflow,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return Text(
      text,
      style: style ?? getBodySmallStyle(context, color, fontWeight),
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
      overflow: overflow,
      textHeightBehavior: const TextHeightBehavior(applyHeightToLastDescent: false),
    );
  }

  /// fontSize = 17
  static TextStyle getTitleLargeStyle(BuildContext context, Color color, FontWeight fontWeight) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(color: color, fontWeight: fontWeight);
  }

  /// fontSize = 14
  static TextStyle getTitleMediumStyle(BuildContext context, Color color, FontWeight fontWeight) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(color: color, fontWeight: fontWeight);
  }

  /// fontSize = 12
  static TextStyle getTitleSmallStyle(BuildContext context, Color color, FontWeight fontWeight) {
    return Theme.of(context).textTheme.titleSmall!.copyWith(color: color, fontWeight: fontWeight);
  }

  /// fontSize = 12
  static TextStyle getBodyLargeStyle(BuildContext context, Color color, FontWeight fontWeight) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(color: color, fontWeight: fontWeight);
  }

  /// fontSize = 10
  static TextStyle getBodyMediumStyle(BuildContext context, Color color, FontWeight fontWeight) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(color: color, fontWeight: fontWeight);
  }

  /// fontSize = 9
  static TextStyle getBodySmallStyle(BuildContext context, Color color, FontWeight fontWeight) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(color: color, fontWeight: fontWeight);
  }

  static TextTheme setTextTheme() {
    return const TextTheme(
      titleLarge: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.05,
        color: Colors.black,
        height: 1.1,
      ),
      titleMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.05,
        color: Colors.black,
        height: 1.1,
      ),
      titleSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.black,
        letterSpacing: -0.05,
        height: 1.1,
      ),
      bodyLarge: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.black,
        letterSpacing: -0.05,
        height: 1.1,
      ),
      bodyMedium: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: Colors.black,
        letterSpacing: -0.05,
        height: 1.1,
      ),
      bodySmall: TextStyle(
        fontSize: 9,
        fontWeight: FontWeight.w500,
        color: Colors.black,
        letterSpacing: -0.05,
        height: 1.1,
      ),
    );
  }
}
