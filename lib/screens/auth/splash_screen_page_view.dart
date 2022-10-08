import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/image/image.dart';
import '../../core/utils/services/size_config.dart';
import '../../core/utils/themes/theme.dart';
import 'login_view_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String _text = '#ÇatdılmaSizinləGözəl';
  double opasity = 0;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginViewPage()));
    });
    Future.microtask(() {
      setState(() {
        opasity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Themes.primaryColor,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(AppImage.logo_top),
            ),
            AnimatedOpacity(
              opacity: opasity,
              duration: DurationItem.lowDuration,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      child: Image.asset(AppImage.logo),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedOpacity(
              opacity: opasity,
              duration: DurationItem.lowDuration,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        bottom: AppSize.calculateHeight(context, 43)),
                    alignment: Alignment.center,
                    child: Text(
                      _text,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Image.asset(AppImage.logo_bottom),
            ),
          ],
        ),
      ),
    );
  }
}

class DurationItem {
  static Duration lowDuration = const Duration(seconds: 1);
}
