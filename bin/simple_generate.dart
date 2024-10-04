// ignore_for_file: avoid_print

import 'dart:io';

void main() {
  createRoutePage();
  createModel();
  createUtil();
  createWidgets();
  createDialog();
  createBottomSheet();
  createViewModel();
  createApi();
  createController();
}

void createRoutePage() {
  createFile("lib/route_page.dart", routePage);
}

void createModel() {
  createDirectory("lib/model");
  createFile("lib/model/pair.dart", pair);
  createFile("lib/model/screen_model.dart", screenModel);
  createFile("lib/model/base_model.dart", baseModel);
  createFile("lib/model/pagination_model.dart", paginationModel);
  createFile("lib/model/error_model.dart", errorModel);
}

void createUtil() {
  createDirectory("lib/util");
  createFile("lib/util/asset_path.dart", assetPath);
  createFile("lib/util/launch_url_util.dart", launchUrl);
  createFile("lib/util/my_color.dart", myColor);
  createFile("lib/util/text_util.dart", textUtil);
  createFile("lib/util/custom_scroll_behavior.dart", customScrollBehavior);
  createFile("lib/util/my_validation.dart.dart", myValidation);
  createFile("lib/util/date_util.dart", dateUtil);
  createFile("lib/util/error_util.dart", errorUtil);
  createFile("lib/util/keyboard_util.dart", keyboardUtil);
  createFile("lib/util/loading.dart", loading);
  createFile("lib/util/logging.dart", logging);
}

void createWidgets() {
  createDirectory("lib/widgets");
  createFile("lib/widgets/custom_keyboard_listener.dart", customKeyboardListener);
  createFile("lib/widgets/custom_text_button.dart", customTextButton);
  createFile("lib/widgets/custom_text_form_field.dart", customTextFormField);
  createFile("lib/widgets/screen_layout_builder.dart", screenLayoutBuilder);
  createFile("lib/widgets/custom_constraints.dart", customConstraints);
  createFile("lib/widgets/custom_dropdown_button.dart", customDropdownButton);
  createFile("lib/widgets/custom_gradient_text.dart", customGradientText);
  createFile("lib/widgets/my_divider.dart", myDivider);
  createFile("lib/widgets/image_widget.dart", imageWidget);
}

void createDialog() {
  createDirectory("lib/dialog");
  createFile("lib/dialog/ok_dialog.dart", okDialog);
}

void createBottomSheet() {
  createDirectory("lib/bottom_sheet");
  createFile("lib/bottom_sheet/ok_bottom_sheet.dart", okBottomSheet);
}

void createViewModel() {
  createDirectory("lib/view_model");
  createFile("lib/view_model/home_view_model.dart", homeViewModel);
}

void createApi() {
  createDirectory("lib/api");
  createFile("lib/api/base_api.dart", baseApi);
  createFile("lib/api/common_api.dart", commonApi);
}

void createController() {
  createDirectory("lib/controller");
  createFile("lib/controller/common_controller.dart", commonController);
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
  /// 페이지 이동
  static void move(
    BuildContext context,
    String pageName, {
    dynamic arguments,
    Function(dynamic value)? callback,
  }) {
    Navigator.of(context).pushNamed(pageName, arguments: arguments).then((value) {
      callback?.call(value);
    });
  }

  /// 현재 페이지를 새로운 페이지로 교환
  static void moveAndReplace(
    BuildContext context,
    String pageName, {
    dynamic arguments,
    Function(dynamic value)? callback,
  }) {
    Navigator.of(context).pushReplacementNamed(pageName, arguments: arguments).then((value) {
      callback?.call(value);
    });
  }

  /// 특정 페이지까지 되돌아가기
  static void popUntil(BuildContext context, String pageName) {
    Navigator.of(context).popUntil(
      (route) => route.settings.name.toString() == pageName,
    );
  }

  static const splash = '/splash';

  static Map<String, WidgetBuilder> routeList = {
    RoutePage.splash: (_) => const Scaffold(),
  };
}
''';

var baseModel = '''
import 'pagination_model.dart';

class BaseModel {
  Map<String, dynamic> data;
  List<dynamic> dataList;
  PaginationModel paginationModel;

  BaseModel(this.data, this.dataList, this.paginationModel);

  factory BaseModel.fromJson(Map<String, dynamic> data) {
    var tempData = <String, dynamic>{};
    var tempDataList = [];
    if (data["data"] is Map<String, dynamic>) {
      tempData = data["data"];
    } else if(data["data"] is Iterable){
      tempDataList = data["data"];
    }
    return BaseModel(
      tempData,
      tempDataList,
      data["pagination"] == null
          ? PaginationModel.zero()
          : PaginationModel.fromJson(data["pagination"]),
    );
  }

  @override
  String toString() {
    return 'BaseModel{data: \$data, dataList: \$dataList, paginationModel: \$paginationModel}';
  }
}
''';

var paginationModel = '''
class PaginationModel {
  int totalCount;
  int totalPageNumber;
  int currentPageNumber;

  PaginationModel(this.totalCount, this.totalPageNumber, this.currentPageNumber);

  PaginationModel.zero({
    this.totalCount = 0,
    this.totalPageNumber = 0,
    this.currentPageNumber = 0,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> data) {
    return PaginationModel(
      data["totalCount"] ?? 0,
      data["totalPageNumber"] ?? 0,
      data["currentPageNumber"] ?? 0,
    );
  }

  @override
  String toString() {
    return 'PaginationModel{totalCount: \$totalCount, totalPageNumber: \$totalPageNumber, currentPageNumber: \$currentPageNumber}';
  }
}
''';

var errorModel = '''
class ErrorModel {
  final String method;
  final int statusCode;
  final String title;
  final String message;
  final String url;
  final dynamic error;

  ErrorModel({
    this.method = "",
    this.statusCode = 0,
    this.title = "",
    this.message = "",
    this.url = "",
    this.error = "",
  });

  factory ErrorModel.fromMap(Map<String, dynamic> data) {
    return ErrorModel(
      title: data["title"],
      error: data,
      message: data["message"],
      url: data["url"],
      method: data["method"],
      statusCode: data["statusCode"],
    );
  }

  Map<String, dynamic> toMap() => {
        "method": method,
        "statusCode": statusCode,
        "title": title,
        "message": message,
        "url": url,
        "error": error,
      };

  @override
  String toString() {
    return 'ErrorModel{method: \$method, statusCode: \$statusCode, title: \$title, message: \$message, url: \$url, error: \$error}';
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

var okBottomSheet = '''
import 'package:flutter/material.dart';

class OkBottomSheet {
  static void show({
    required BuildContext context,
    required String message,
    required String buttonText,
    required VoidCallback onClick,
    VoidCallback? then,
    VoidCallback? closed,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: Container(
            color: Colors.white,
            width: double.infinity,
            height: 266,
            child: const SizedBox(),
          ),
        );
      },
    ).then((value) {
      then?.call();
      Future.delayed(
        const Duration(milliseconds: 200),
        () {
          closed?.call();
        },
      );
    });
  }
}
''';

var dateUtil = '''
import 'package:intl/intl.dart';

class DateUtil{

  static DateTime changeFromEpochToDateTime(int time) {
    return DateTime.fromMillisecondsSinceEpoch(time);
  }


  /// yyyy.MM.dd 형태로 파싱
  static String yyyyMMddDateFromDateTime(DateTime time) {
    return DateFormat('yyyy.MM.dd').format(time);
  }

  /// yyyy.MM.dd 형태로 파싱
  static String yyyyMMddDateFromMilliSec(int time) {
    return DateFormat('yyyy.MM.dd').format(changeFromEpochToDateTime(time));
  }

  /// yyyy.MM.dd HH:mm 형태로 파싱
  static String fullDateFromMilliSec(int time) {
    return DateFormat('yyyy.MM.dd HH:mm').format(changeFromEpochToDateTime(time));
  }

  static String changeLocalDate(DateTime dateTime){
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(dateTime);
  }

  static int getDueDateFromNow(DateTime endDate){
    DateTime now = DateTime.now();
    Duration difference = endDate.difference(now);
    int dDay = difference.inDays;
    return dDay;
  }

  /// 2024-07-26T18:08:15.458552 이러한 형태를 DateTime으로 변경
  static DateTime parseDateTime(String time) {
    return DateTime.parse(time);
  }
}
''';

var errorUtil = '''
import 'package:fluttertoast/fluttertoast.dart';

class ErrorUtil {
  static const String errorMessage = "오류가 발생했습니다. 잠시 후 다시 시도해주세요";
  static const String noAccount = "존재하지 않는 계정입니다";

  static void errorToast({String message = ErrorUtil.errorMessage}) {
    Fluttertoast.showToast(msg: message);
  }

  static void throwError(Map<String, dynamic> e) {
    throw {
      "method": e["method"],
      "statusCode": e["statusCode"],
      "title": e["title"],
      "message": e["message"],
      "url": e["url"],
      "error": e["error"],
    };
  }
}

''';

var keyboardUtil = '''
import 'package:flutter/material.dart';

class KeyboardUtil {
  static bool open(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }
}
''';


var loading = '''
import 'package:flutter/material.dart';

class Loading {
  static BuildContext? _context;

  static open({required BuildContext context, int finishSec = 5}) async {
    if (_context != null) return;
    _context = context;
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) {
        return Material(
          color: Colors.black.withOpacity(0.6),
          elevation: 0,
          child: widget(),
        );
      },
    ).timeout(Duration(seconds: finishSec), onTimeout: () async => close());
  }

  static widget() {
    return const Center(
      child: SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          strokeWidth: 4,
          color: Colors.orange,
        ),
      ),
    );
  }

  static close() {
    if (_context == null) return;
    if (!_context!.mounted) {
      _context = null;
      return;
    }
    Navigator.of(_context!).pop();
    _context = null;
  }

  static animationLoading({
    required bool loading,
    required bool initial,
    required Widget child,
  }) {
    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedOpacity(
            opacity: initial && loading ? 0 : 1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
            child: child,
          ),
        ),
        if (loading) Loading.widget(),
      ],
    );
  }
}
''';

var myDivider = '''
import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({this.needOverflow = true, super.key});

  final bool needOverflow;

  @override
  Widget build(BuildContext context) {
    if (needOverflow) {
      return SizedBox(
        width: double.infinity,
        height: 1,
        child: OverflowBox(
          alignment: Alignment.center,
          minHeight: 1,
          maxWidth: MediaQuery.of(context).size.width,
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey,
          ), // 자식 위젯
        ),
      );
    }
    return Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey,
    );
  }
}
''';

var homeViewModel = '''
import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {
  static final HomeViewModel _singleton = HomeViewModel._();

  factory HomeViewModel() {
    return _singleton;
  }

  HomeViewModel._();

  void update() => notifyListeners();

  bool isDirty = false;
}
''';

var baseApi = '''
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../util/logging.dart';

abstract class BaseApi {
  late final Dio _dio;

  BaseApi(this._dio);

  final pageSize = 30;

  String getHeaderToken() {
    return _dio.options.headers["authorization"];
  }

  /// 헤더 토큰 리셋
  void resetHeader() {
    _dio.options.headers = null;
  }

  Map<String, dynamic> getHeader() {
    return _dio.options.headers;
  }

  String getHeaderAuthorization() {
    return _dio.options.headers["authorization"];
  }

  ///dio get
  Future<Response> dioGet(String url, {Map<String, dynamic>? query}) async {
    try {
      Logging.logApi(
        method: "GET",
        header: _dio.options.headers,
        url: url,
        query: query,
        body: "",
        data: "",
        statusCode: "",
      );

      Response response;
      if (query == null) {
        response = await _dio.get(url);
      } else {
        response = await _dio.get(url, queryParameters: query);
      }

      Logging.logApi(
        method: "GET",
        header: _dio.options.headers,
        url: response.realUri,
        query: query,
        body: "",
        data: response.data,
        statusCode: response.statusCode,
      );
      if (response.data == null &&
          (response.statusCode == null ||
              (response.statusCode! < 200 && response.statusCode! >= 300))) {
        throw Exception("data null");
      }

      return response;
    } on DioException catch (e) {
      throw {
        "method": "GET",
        "statusCode": e.response?.statusCode,
        "title": "오류",
        "message": e.response == null
            ? "네트워크 연결을 확인해주세요 "
            : e.response?.data["message"],
        "url": url,
        "error": e.error,
      };
    }
  }

  ///dio post
  Future<Response> dioPost(String url, {required dynamic data}) async {
    try {
      Logging.logApi(
        method: "POST",
        header: _dio.options.headers,
        url: url,
        query: null,
        body: data,
        data: "",
        statusCode: "",
      );
      Response response = await _dio.post(url, data: data);

      Logging.logApi(
        method: "POST",
        header: _dio.options.headers,
        url: response.realUri,
        query: null,
        body: data,
        data: response.data,
        statusCode: response.statusCode,
      );

      if (response.data == null &&
          (response.statusCode == null ||
              (response.statusCode! < 200 && response.statusCode! >= 300))) {
        throw Exception("data null");
      }
      return response;
    } on DioException catch (e) {
      throw {
        "method": "POST",
        "statusCode": e.response?.statusCode,
        "title": "오류",
        "message": e.response == null
            ? "네트워크 연결을 확인해주세요 "
            : e.response?.data["message"],
        "url": url,
        "error": e.error,
      };
    }
  }

  ///dio patch
  Future<Response> dioPatch(String url, {dynamic data}) async {
    try {
      debugPrint("dioPatch url : \$url, data : \$data");

      Response response;
      if (data == null) {
        response = await _dio.patch(url);
      } else {
        response = await _dio.patch(url, data: data);
      }

      Logging.logApi(
        method: "PATCH",
        header: _dio.options.headers,
        url: response.realUri,
        query: null,
        body: "",
        data: response.data,
        statusCode: response.statusCode,
      );

      if (response.data == null &&
          (response.statusCode == null ||
              (response.statusCode! < 200 && response.statusCode! >= 300))) {
        throw Exception("data null");
      }

      return response;
    } on DioException catch (e) {
      throw {
        "method": "PATCH",
        "statusCode": e.response?.statusCode,
        "title": "오류",
        "message": e.response == null
            ? "네트워크 연결을 확인해주세요 "
            : e.response?.data["message"],
        "url": url,
        "error": e.error,
      };
    }
  }

  ///dio put
  Future<Response> dioPut(String url, {dynamic data}) async {
    try {
      debugPrint("dioPut url : \$url, data : \$data");

      Response response;
      if (data == null) {
        response = await _dio.put(url);
      } else {
        response = await _dio.put(url, data: data);
      }

      Logging.logApi(
        method: "PUT",
        header: _dio.options.headers,
        url: response.realUri,
        query: null,
        body: data,
        data: response.data,
        statusCode: response.statusCode,
      );

      if (response.data == null &&
          (response.statusCode == null ||
              (response.statusCode! < 200 && response.statusCode! >= 300))) {
        throw Exception("data null");
      }

      return response;
    } on DioException catch (e) {
      throw {
        "method": "PUT",
        "statusCode": e.response?.statusCode,
        "title": "오류",
        "message": e.response == null
            ? "네트워크 연결을 확인해주세요 "
            : e.response?.data["message"],
        "url": url,
        "error": e.error,
      };
    }
  }

  ///dio delete
  Future<Response> dioDelete(String url, {Map<String, dynamic>? query}) async {
    try {
      Response response;
      if (query == null) {
        response = await _dio.delete(url);
      } else {
        response = await _dio.delete(url, queryParameters: query);
      }

      Logging.logApi(
        method: "DELETE",
        header: _dio.options.headers,
        url: '\${_dio.options.baseUrl}\$url',
        query: null,
        body: "",
        data: response.data,
        statusCode: response.statusCode,
      );

      if (response.data == null &&
          (response.statusCode == null ||
              (response.statusCode! < 200 && response.statusCode! >= 300))) {
        throw Exception("data null");
      }

      return response;
    } on DioException catch (e) {
      throw {
        "method": "DELETE",
        "statusCode": e.response?.statusCode,
        "title": "오류",
        "message": e.response == null ? "네트워크 연결을 확인해주세요 " : e.response?.data,
        "url": url,
        "error": e.error,
      };
    }
  }

  Future<void> dioDownload({
    required String downloadUrl,
    required String downloadDirectory,
    required Function(int count, int total) progress,
  }) async {
    try {
      debugPrint(
          "dioDownload downloadUrl : \$downloadUrl, downloadDirectory : \$downloadDirectory");

      await _dio.download(downloadUrl, downloadDirectory,
          onReceiveProgress: (count, total) {
        progress(count, total);
      },
          options: Options(
              sendTimeout: const Duration(seconds: 5),
              receiveTimeout: const Duration(seconds: 5)));
    } on DioException catch (e) {
      throw {
        "method": "GET DOWNLOAD",
        "statusCode": e.response?.statusCode,
        "title": "오류",
        "message": e.response == null ? "네트워크 연결을 확인해주세요 " : e.response?.data,
        "url": downloadUrl,
        "error": e.error,
      };
    }
  }
}
''';

var commonApi = '''
import 'base_api.dart';

class CommonApi extends BaseApi {
  CommonApi(super.dio);
}
''';

var commonController = '''
import 'package:dio/dio.dart';

import '../api/common_api.dart';

class CommonController {
  static final CommonController _singleton = CommonController._();

  factory CommonController({Dio? dio}) {
    if (dio != null) {
      _commonApi = CommonApi(dio);
    }
    return _singleton;
  }

  CommonController._();

  static late CommonApi _commonApi;
}
''';

var logging = '''
import 'package:flutter/foundation.dart';

class Logging {
  static log(dynamic message) {
    if (!kReleaseMode) {
      debugPrint(message);
    }
  }

  static logApi({
    required dynamic method,
    required dynamic url,
    required dynamic query,
    required dynamic body,
    required dynamic data,
    required dynamic statusCode,
    required dynamic header,
  }) {
    var message =
        '\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
        '\nmethod : \$method'
        '\nurl : \$url'
        '\nquery : \$query'
        '\nbody : \$body'
        '\nresponse : \$data'
        '\nstatusCode : \$statusCode'
        '\nheader : \$header'
        '\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n';
    if (!kReleaseMode) {
      debugPrint(message);
    }
  }
}

''';

var imageWidget = '''
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum ImageHolderType { white, grey, loading, transparent }

class ImageWidget {
  
  static Widget placeHolderGrey() => Container(color: Colors.grey.shade50);

  static const Duration shortDuration = Duration(milliseconds: 50);

  static const Duration middleDuration = Duration(milliseconds: 300);

  static const Duration longDuration = Duration(milliseconds: 600);

  ///투명한 배경 placeHolder
  static Widget placeHolderTransparent() =>
      Container(color: Colors.transparent);

  ///하얀색 배경 placeHolder
  static Widget placeHolderWhite() => Container(color: Colors.white);

  ///로딩 placeHolder
  static Widget placeHolderLoading() {
    return const SizedBox(
      width: 20,
      height: 20,
      child: Center(child: CircularProgressIndicator()),
    );
  }

  static Widget getImagePlaceHolder(ImageHolderType imageHolderType) {
    switch (imageHolderType) {
      case ImageHolderType.grey:
        return placeHolderGrey();
      case ImageHolderType.white:
        return placeHolderWhite();
      case ImageHolderType.loading:
        return placeHolderLoading();
      case ImageHolderType.transparent:
        return placeHolderTransparent();
    }
  }

  static Widget setNetworkAndFile(String url) {
    if (url.isEmpty) return const SizedBox();
    if (url.contains("https")) return imageNetwork(url: url);
    return Image.file(File(url), fit: BoxFit.cover);
  }

  static Widget imageNetwork({
    required String url,
    BoxFit fit = BoxFit.cover,
    Duration duration = middleDuration,
    Duration fadeOutDuration = middleDuration,
    FilterQuality filterQuality = FilterQuality.medium,
    ImageHolderType imageHolderType = ImageHolderType.white,
  }) {
    if (url == "null" || url.isEmpty) {
      return const SizedBox();
    }
    return _mainNetworkImage(
      url: url,
      fit: fit,
      duration: duration,
      fadeOutDuration: fadeOutDuration,
      filterQuality: filterQuality,
      imageHolderType: imageHolderType,
    );
  }

  static Widget _mainNetworkImage({
    required String url,
    required BoxFit fit,
    required Duration duration,
    required Duration fadeOutDuration,
    required FilterQuality filterQuality,
    required ImageHolderType imageHolderType,
  }) {
    return CachedNetworkImage(
        fit: fit,
        imageUrl: url,
        fadeInCurve: Curves.ease,
        fadeInDuration: duration,
        fadeOutDuration: fadeOutDuration,
        placeholder: (context, url) =>
            Center(child: getImagePlaceHolder(imageHolderType)),
        filterQuality: filterQuality,
        errorWidget: (context, url, error) {
          return Image.network(url, fit: fit, filterQuality: filterQuality,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(url, fit: fit, filterQuality: filterQuality,
                    errorBuilder: (context, error, stackTrace) {
                      return Container();
                    });
              });
        });
  }

  static ImageProvider imageNetworkProvider({required String url}) {
    return CachedNetworkImageProvider(
      url,
      errorListener: (error) => CachedNetworkImageProvider(
        url,
        errorListener: (error) => Container(),
      ),
    );
  }
}
''';