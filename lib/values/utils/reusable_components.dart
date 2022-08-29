import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:smartpointer/app/modules/expenses/controllers/expenses_controller.dart';

class AppWidgets {
  static PreferredSizeWidget appbar(
      BuildContext context, String? title, Function()? onPressed) {
    return AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(93, 122, 196, 1.0),
        centerTitle: true,
        leading: Obx(() => Get.find<ExpensesController>().isShowBackButton.value
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                  color: Colors.white,
                ),
                onPressed: onPressed,
              )
            : const SizedBox()),
        title: Obx(
          () => Text(
            Get.find<ExpensesController>().appBarTitle.value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontFamily: 'montserrat_medium',
                fontWeight: FontWeight.w700),
          ),
        ));
  }

  static PreferredSizeWidget appbar1(
      BuildContext context, String? title, Function()? onPressed) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color.fromRGBO(93, 122, 196, 1.0),
      centerTitle: true,
      title: Text(
        title!,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontFamily: 'montserrat_medium',
            fontWeight: FontWeight.w700),
      ),
    );
  }

  static Widget buildText(
      {required String? text,
      BuildContext? context,
      TextAlign? textAlign,
      double? fontSize,
      FontWeight? fontWeight,
      Color? color,
      String? fontFamily,
      int? maxline}) {
    return Text(
      text ?? '',
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxline ?? 20,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color ?? Colors.black,
          fontSize: fontSize ?? 16,
          fontFamily: fontFamily ?? 'montserrat_medium',
          fontWeight: fontWeight ?? FontWeight.w700),
    );
  }
}

class Button extends StatelessWidget {
  final Widget? child;
  final Function()? onPressed;
  final Color? colors;

  const Button(
      {Key? key,
      @required this.onPressed,
      @required this.child,
      @required this.colors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      splashColor: Colors.black12,
      padding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Ink(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colors,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Container(
            constraints: const BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: child),
      ),
    );
  }
}

class InternetConnectionError extends StatelessWidget {
  const InternetConnectionError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: 100.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 3.h,
          ),
          const CircleAvatar(
            radius: 120.0,
            backgroundImage: AssetImage(
              'assets/images/nointernet.gif',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          SizedBox(
            width: 100.w,
            child: AppWidgets.buildText(
              context: context,
              text: "Oops!",
              fontSize: 14,
              textAlign: TextAlign.center,
              fontFamily: 'gotham_medium',
            ),
          ),
          SizedBox(
            width: 100.w,
            child: AppWidgets.buildText(
              context: context,
              text:
                  "Slow or no internet connection. Please check your internet connection.",
              fontSize: 14,
              textAlign: TextAlign.center,
              fontFamily: 'gotham_medium',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class ErrorMessage extends StatelessWidget {
  ErrorMessage({Key? key, this.errorMessage, this.onPressed}) : super(key: key);

  String? errorMessage;
  Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
            child: SizedBox(
              height: 160,
              width: double.infinity,
              child: Image.asset(
                'assets/images/error_img.png.webp',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color(0xff2c0453),
                border: Border.all(color: const Color(0xff2c0453)),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: const Radius.circular(8.0))),
          )
        ],
      ),
      Positioned(
        bottom: 20,
        child: SizedBox(
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppWidgets.buildText(
                  context: context,
                  text: '${errorMessage} !!',
                  color: Colors.white,
                  fontFamily: 'gotham_medium'),
              const SizedBox(
                height: 5,
              ),
              TextButton(
                  onPressed: onPressed,
                  child: Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(4.0)),
                    child: Center(
                      child:
                          AppWidgets.buildText(context: context, text: 'Retry'),
                    ),
                  ))
            ],
          ),
        ),
      )
    ]);
  }
}

class ListViewSkeletonLoader extends StatelessWidget {
  ListViewSkeletonLoader({Key? key, this.itemCount}) : super(key: key);

  int? itemCount;

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      builder: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: <Widget>[
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 12,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      items: itemCount ?? 6,
      period: const Duration(seconds: 2),
      highlightColor: const Color.fromRGBO(93, 122, 196, 1.0),
      direction: SkeletonDirection.ltr,
    );
  }
}

class GridViewSkeletonLoader extends StatelessWidget {
  GridViewSkeletonLoader(
      {Key? key, this.itemCount, this.itemsPerRow, this.childAspectRatio})
      : super(key: key);

  int? itemCount;
  int? itemsPerRow;
  double? childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return SkeletonGridLoader(
      builder: Card(
        color: Colors.transparent,
        child: GridTile(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 50,
                height: 10,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              Container(
                width: 70,
                height: 10,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
      items: itemCount ?? 12,
      itemsPerRow: itemsPerRow ?? 2,
      period: const Duration(seconds: 2),
      highlightColor: const Color.fromRGBO(93, 122, 196, 1.0),
      direction: SkeletonDirection.ltr,
      childAspectRatio: childAspectRatio ?? 1.0,
    );
  }
}

class Debouncer {
  final int? milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds!), action);
  }
}
