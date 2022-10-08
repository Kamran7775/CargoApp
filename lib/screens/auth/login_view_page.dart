import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../core/image/image.dart';
import '../../core/text/text.dart';
import '../../core/utils/services/network_util.dart';
import '../../core/utils/services/size_config.dart';
import '../../core/utils/themes/theme.dart';
import '../../core/widgets/button.dart';
import '../../model/login_request_model.dart';
import '../base_view_page.dart';

class LoginViewPage extends StatefulWidget {
  const LoginViewPage({Key? key}) : super(key: key);

  @override
  State<LoginViewPage> createState() => _LoginViewPageState();
}

class _LoginViewPageState extends State<LoginViewPage> {
  TextEditingController userNameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  bool _validateUserName = false;
  bool _validatePassword = false;
  bool _isLoading = false;
  bool _isObcuse = true;
  final String _text1 = 'Operator Girişi';
  final String _text2 = 'Daxil olmaq üçün email ve şifrənizi qeyd edin';
  final String _email = 'Email';
  final String _password = 'Şifrə';
  double opacity = 0;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      setState(() {
        opacity = 1;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    userNameEditingController.dispose();
    passwordEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Themes.primaryColor,
        body: Stack(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(AppImage.logo_top),
                ),
                AnimatedOpacity(
                  opacity: opacity,
                  duration: const Duration(seconds: 2),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: AppSize.calculateHeight(context, 170),
                        ),
                        alignment: Alignment.center,
                        child: Image.asset(
                          AppImage.logo,
                          width: 275,
                          height: 66,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  height: AppSize.calculateHeight(context, 409),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: AppSize.calculateWidth(context, 28),
                        right: AppSize.calculateWidth(context, 28),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: AppSize.calculateHeight(context, 84),
                          ),
                          Text(
                            _text1,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Themes.textColor,
                            ),
                          ),
                          Text(
                            _text2,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Themes.textColor,
                            ),
                          ),
                          SizedBox(
                            height: AppSize.calculateHeight(context, 15),
                          ),
                          SizedBox(
                            height: AppSize.calculateHeight(context, 50),
                            width: AppSize.calculateWidth(context, 319),
                            child: CustomTextFieldWidget(
                                labelText: _email,
                                prefix: const Icon(
                                  Icons.person,
                                ),
                                textEditingController:
                                    userNameEditingController,
                                validate: _validateUserName,
                                errorText: AppText.errorText),
                          ),
                          SizedBox(
                            height: AppSize.calculateHeight(context, 16),
                          ),
                          SizedBox(
                            height: AppSize.calculateHeight(context, 50),
                            width: AppSize.calculateWidth(context, 319),
                            child: CustomTextFieldWidget(
                                obscureText: _isObcuse,
                                suffix: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isObcuse = !_isObcuse;
                                      });
                                    },
                                    icon: (_isObcuse == true)
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off)),
                                labelText: _password,
                                prefix: const Icon(
                                  Icons.vpn_key,
                                ),
                                textEditingController:
                                    passwordEditingController,
                                validate: _validatePassword,
                                errorText: AppText.errorText),
                          ),
                          SizedBox(
                            height: AppSize.calculateHeight(context, 28),
                          ),
                          (_isLoading == false)
                              ? SizedBox(
                                  height: AppSize.calculateHeight(context, 55),
                                  width: AppSize.calculateWidth(context, 319),
                                  child: CustomButtom(
                                      textButton: AppText.login,
                                      click: () {
                                        setState(() {
                                          userNameEditingController.text.isEmpty
                                              ? _validateUserName = true
                                              : _validateUserName = false;
                                          passwordEditingController.text.isEmpty
                                              ? _validatePassword = true
                                              : _validatePassword = false;
                                          if (_validateUserName == false &&
                                              _validatePassword == false) {
                                            login();
                                          }
                                        });
                                      }),
                                )
                              : const SpinKitFadingCircle(
                                  color: Themes.buttonColor,
                                )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  login() async {
    setState(() {
      _isLoading = true;
    });
    LoginRequestModel loginRequestModel = LoginRequestModel(
        username: userNameEditingController.text,
        password: passwordEditingController.text);
    var response = await WebService.singIn(loginRequestModel);
    if (response == true) {
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const BaseViewPage()));
    } else {
      setState(() {
        _isLoading = false;
      });
      showTopSnackBar(
          context, const CustomSnackBar.error(message: 'Şifre yanlışdır'));
    }
  }
}
