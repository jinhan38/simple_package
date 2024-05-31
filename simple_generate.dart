// ignore_for_file: avoid_print

import 'dart:io';

void main() {
  createRoutePage();
  createModel();
  createUtil();
  createWidgets();
  createDialog();
}

void createRoutePage() {
  createFile("lib/route_page.dart", routePage);
}

void createModel() {
  createDirectory("lib/model");
  createFile("lib/model/pair.dart", pair);
  createFile("lib/model/screen_model.dart", screenModel);
}

void createUtil() {
  createDirectory("lib/util");
  createFile("lib/util/asset_path.dart", assetPath);
  createFile("lib/util/launch_url_util.dart", launchUrl);
  createFile("lib/util/my_color.dart", myColor);
  createFile("lib/util/text_util.dart", textUtil);
  createFile("lib/util/custom_scroll_behavior.dart", customScrollBehavior);
  createFile("lib/util/my_validation.dart", myValidation);
}

void createWidgets() {
  createDirectory("lib/widgets");
  createFile(
      "lib/widgets/custom_keyboard_listener.dart", customKeyboardListener);
  createFile("lib/widgets/custom_text_button.dart", customTextButton);
  createFile("lib/widgets/custom_text_form_field.dart", customTextFormField);
  createFile("lib/widgets/screen_layout_builder.dart", screenLayoutBuilder);
  createFile("lib/widgets/custom_constraints.dart", customConstraints);
  createFile("lib/widgets/custom_dropdown_button.dart", customDropdownButton);
  createFile("lib/widgets/custom_gradient_text.dart", customGradientText);
}

void createDialog() {
  createDirectory("lib/dialog");
  createFile("lib/dialog/ok_dialog.dart", okDialog);
}

void createDirectory(String path) {
  var dir = Directory(path);
  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
    print('$path 폴더 생성: ${dir.path}');
  } else {
    print('$path 폴더가 이미 존재합니다: ${dir.path}');
  }
}

void createFile(String path, String code) {
  final file = File(path);
  if (!file.existsSync()) {
    file.writeAsStringSync(code);
    print('$path 파일 생성: ${file.path}');
  } else {
    print('$path 파일이 이미 존재합니다: ${file.path}');
  }
}

var routePage = '''
import 'package:flutter/material.dart';

class RoutePage {
  static const intro = '/';

  static movePage(BuildContext context, String routeName, {dynamic data}) {
  }

  static backPage(BuildContext context, {dynamic data}) {
  }
}
''';

var pair = '''
class Pair<T, S> {
  T first;
  S second;

  Pair(this.first, this.second);
}

class Temp {
  Pair<int, String> pair = Pair(1, "second");

  List<Pair<int, bool>> pairList = [
    Pair(0, true),
    Pair(1, false),
    Pair(2, true),
  ];
}
''';

var screenModel = '''
class ScreenModel {
  bool web;
  bool tablet;
  bool mobile;

  ScreenModel(this.web, this.tablet, this.mobile);

  @override
  String toString() {
    return 'ScreenModel{web: \$web, tablet: \$tablet, mobile: \$mobile}';
  }
}
''';

var assetPath = '''
class AssetPath {
  static const sample = "";

  static const List<String> imageList = [];
}
''';

var launchUrl = '''
import 'dart:html' as html;

class LaunchUrlUtil {
  static void openNewTab(String url) {
    html.window.open(url, '');
  }
}
''';

var myColor = '''
import 'package:flutter/material.dart';

class MyColor {
  static const gray5 = Color(0xffFAFAFC);
}
''';

var textUtil = '''
import 'package:flutter/material.dart';

class TextUtil {
  static Widget text(
    String text, {
    required TextStyle style,
    TextAlign? textAlign,
  }) {
    return Text(text, style: style, textAlign: textAlign);
  }

  /// fontSize = 11
  static TextStyle get11(BuildContext context, Color color) {
    return Theme.of(context).textTheme.labelSmall!.copyWith(color: color);
  }

  static TextTheme setTextTheme() {
    return const TextTheme(
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}
''';

var customScrollBehavior = '''
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// 마우스로 드래그 안 될 때
class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
''';

var myValidation = '''
class MyValidation {
  static bool isEmail(String text) {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}\$',
    );
    return emailRegExp.hasMatch(text);
  }
}
''';

var customKeyboardListener = '''
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class CustomKeyboardListener extends StatefulWidget {
  const CustomKeyboardListener({
    required this.child,
    required this.scrollController,
    super.key,
  });

  final Widget child;
  final ScrollController scrollController;

  @override
  State<CustomKeyboardListener> createState() => _CustomKeyboardListenerState();
}

class _CustomKeyboardListenerState extends State<CustomKeyboardListener> {
  ScrollController get scrollController => widget.scrollController;
  final focusNode = FocusNode();
  final duration = const Duration(milliseconds: 200);
  double offset = 300;

  @override
  void dispose() {
    focusNode
      ..unfocus()
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    offset = MediaQuery.of(context).size.height;
    return KeyboardListener(
      focusNode: focusNode,
      autofocus: true,
      child: widget.child,
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.pageUp) {
            move(true);
          } else if (event.logicalKey == LogicalKeyboardKey.pageDown) {
            move(false);
          } else if (event.logicalKey == LogicalKeyboardKey.home) {
            home();
          } else if (event.logicalKey == LogicalKeyboardKey.end) {
            end();
          }
        }
      },
    );
  }

  void move(bool up) {
    final moveOffset = up
        ? scrollController.offset - offset
        : scrollController.offset + offset;
    scrollController.animateTo(moveOffset,
        duration: duration, curve: Curves.easeInOut);
  }

  void home() {
    scrollController.animateTo(0, duration: duration, curve: Curves.easeInOut);
  }

  void end() {
    scrollController.animateTo(scrollController.position.extentTotal,
        duration: duration, curve: Curves.easeInOut);
  }
}
''';

var customTextButton = '''
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    required this.text,
    required this.fontSize,
    required this.size,
    required this.onPressed,
    this.fontWeight = FontWeight.normal,
    this.foregroundColor = Colors.grey,
    this.backgroundColor,
    this.disabledForegroundColor,
    this.disabledBackgroundColor,
    this.focusNode,
    this.radius = 0,
    this.padding = EdgeInsets.zero,
    this.textColor = Colors.black,
    this.alignment = Alignment.center,
    this.textAlign,
    super.key,
  });

  final String text;
  final double fontSize;
  final VoidCallback? onPressed;
  final FontWeight fontWeight;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? disabledForegroundColor;
  final Color? disabledBackgroundColor;
  final Size size;
  final FocusNode? focusNode;
  final double radius;
  final EdgeInsets padding;
  final Color textColor;
  final Alignment alignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      focusNode: focusNode,
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        disabledForegroundColor: disabledForegroundColor,
        disabledBackgroundColor: disabledBackgroundColor,
        minimumSize: size,
        maximumSize: size,
        fixedSize: size,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),

      onPressed: onPressed,
      child: Align(
        alignment: alignment,
        child: Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
''';

var customTextFormField = '''
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.controller,
    required this.hint,
    required this.keyboardType,
    this.textInputAction,
    this.autofocus = false,
    this.onFieldSubmitted,
    this.errorText,
    this.focusNode,
    this.verticalPadding = 10,
    this.fontSize = 15,
    this.textColor = Colors.black,
    this.hintColor = Colors.grey,
    this.maxLine = 1,
    this.letterSpacing = 1,
    this.textHeight = 1,
    super.key,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final Function(String value)? onFieldSubmitted;
  final String? Function(String value)? errorText;
  final FocusNode? focusNode;
  final double verticalPadding;
  final double fontSize;
  final Color textColor;
  final Color hintColor;
  final int maxLine;
  final double letterSpacing;
  final double textHeight;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      maxLines: maxLine,
      autofocus: autofocus,
      controller: controller,
      keyboardType: maxLine > 1 ? TextInputType.multiline : keyboardType,
      textInputAction: maxLine > 1
          ? TextInputAction.newline
          : textInputAction ?? TextInputAction.next,
      inputFormatters: <TextInputFormatter>[
        if (maxLine == 1) FilteringTextInputFormatter.singleLineFormatter,
      ],
      textAlignVertical: TextAlignVertical.center,
      cursorHeight: fontSize * textHeight,
      style: TextStyle(
        fontSize: fontSize,
        height: textHeight,
        color: textColor,
        letterSpacing: letterSpacing,
        fontWeight: FontWeight.w500,
      ),
      cursorColor: Colors.black,
      onFieldSubmitted: (value) {
        onFieldSubmitted?.call(value);
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
            left: 20, right: 20, top: verticalPadding, bottom: verticalPadding),
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          height: textHeight,
          color: hintColor,
          letterSpacing: letterSpacing,
        ),
        enabledBorder: _customBorder(),
        focusedBorder: _customBorder(),
      ),
    );
  }

  InputBorder _customBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(
        width: 1,
        color: Color(0xffD8DBE2),
      ),
    );
  }
}
''';

var screenLayoutBuilder = '''
import 'package:flutter/cupertino.dart';

import '../model/screen_model.dart';

const double _webWidth = 1920;
const double _tabletWidth = 1024;
const double _mobileWidth = 768;

typedef MyBuilder = Widget Function(
    BuildContext context,
    BoxConstraints constraints,
    bool web,
    bool tablet,
    bool mobile,
    ScreenModel screenModel,
    double webWidth,
    double tabletWidth,
    double mobileWidth);

class ScreenLayoutBuilder extends StatelessWidget {
  const ScreenLayoutBuilder({
    super.key,
    required this.myBuilder,
  });

  final MyBuilder myBuilder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool web = false;
        bool tablet = false;
        bool mobile = false;
        if (constraints.maxWidth <= _mobileWidth) {
          mobile = true;
        } else if (constraints.maxWidth <= _tabletWidth) {
          tablet = true;
        } else {
          web = true;
        }
        return myBuilder(
            context,
            constraints,
            web,
            tablet,
            mobile,
            ScreenModel(web, tablet, mobile),
            _webWidth,
            _tabletWidth,
            _mobileWidth);
      },
    );
  }
}
''';

var customConstraints = '''
import 'package:flutter/material.dart';

class CustomConstrains extends StatelessWidget {
  const CustomConstrains({
    required this.backgroundColor,
    required this.maxWidth,
    required this.child,
    super.key,
  });

  final Color backgroundColor;
  final double maxWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      ),
    );
  }
}
''';

var customDropdownButton = '''
import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    required this.labelList,
    required this.selectedIndex,
    required this.onSelected,
    required this.height,
    super.key,
  });

  final List<String> labelList;
  final int selectedIndex;
  final double height;
  final Function(int index) onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: DropdownButton<int>(
              autofocus: false,
              elevation: 12,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemHeight: height,
              dropdownColor: Colors.white,
              underline: const SizedBox(),
              borderRadius: BorderRadius.circular(0),
              iconSize: 24,
              icon: const Visibility(
                visible: false,
                child: Icon(
                  size: 24,
                  Icons.keyboard_arrow_down_rounded,
                ),
              ),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800),
              value: selectedIndex,
              items: List.generate(labelList.length, (index) {
                return DropdownMenuItem<int>(
                  value: index,
                  child: Text(labelList[index]),
                );
              }),
              onChanged: (value) {
                onSelected(value!);
              },
            ),
          ),
          const Positioned(
            right: 10,
            top: 0,
            bottom: 0,
            child: Icon(
              size: 24,
              Icons.keyboard_arrow_down_rounded,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
''';

var customGradientText = '''
import 'package:flutter/material.dart';

class CustomGradientText extends StatelessWidget {
  const CustomGradientText(
    this.text, {
    required this.gradient,
    required this.style,
     this.textAlign,
    super.key,
  });

  final String text;
  final TextStyle style;
  final Gradient gradient;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style.copyWith(color: Colors.white),
        textAlign: textAlign,
      ),
    );
  }
}
''';

var okDialog = '''
import 'package:flutter/material.dart';

class OkDialog {
  static void show({
    required BuildContext context,
    required String label,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  label,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                TextButton(onPressed: () {}, child: Text("")),
              ],
            ),
          ),
        );
      },
    );
  }
}
''';
