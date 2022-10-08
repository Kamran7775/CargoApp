import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safe_express_cargo_app/screens/auth/splash_screen_page_view.dart';
import 'core/utils/themes/theme.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const NewProject());
}

class NewProject extends StatefulWidget {
  const NewProject({Key? key}) : super(key: key);

  @override
  State<NewProject> createState() => _NewProjectState();
}

class _NewProjectState extends State<NewProject> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Themes.scaffoldBackgroundColor,
          appBarTheme: const AppBarTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
            ),
            elevation: 0,
            centerTitle: true,
            color: Themes.sliderColor,
            titleTextStyle: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
            iconTheme: IconThemeData(
              color: Colors.white,
              size: 32,
            ),
          ),
          fontFamily: 'Poppins',
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen());
  }
}
