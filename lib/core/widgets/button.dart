import 'package:flutter/material.dart';

import '../utils/services/size_config.dart';
import '../utils/themes/theme.dart';

class CustomButtom extends StatelessWidget {
  const CustomButtom({
    Key? key,
    required this.textButton,
    required this.click,
  }) : super(key: key);

  final String textButton;
  final Function click;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: TextButton(
        child: Text(
          textButton,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        onPressed: () {
          click();
        },
      ),
      decoration: BoxDecoration(
          color: const Color(0xff039BE5),
          borderRadius: BorderRadius.circular(16)),
    );
  }
}

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    Key? key,
    required this.textEditingController,
    required bool validate,
    this.errorText,
    this.hintText,
    this.obscureText = false,
    this.labelText,
    this.maxLength,
    this.suffix,
    this.textInputType,
    this.prefix,
  })  : _validate = validate,
        super(key: key);

  final TextEditingController textEditingController;
  final bool _validate;
  final String? errorText;
  final String? hintText;
  final bool obscureText;
  final int? maxLength;
  final Widget? suffix;
  final String? labelText;
  final TextInputType? textInputType;
  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.next,
      keyboardType: textInputType,
      controller: textEditingController,
      obscureText: obscureText,
      maxLength: maxLength,
      decoration: InputDecoration(
        fillColor: const Color(0xffF1F1F1),
        hoverColor: const Color(0xffF1F1F1),
        filled: true,
        prefixIcon: prefix,
        labelText: labelText,
        labelStyle: const TextStyle(
            color: Themes.textColor, fontSize: 14, fontWeight: FontWeight.w400),
        suffixIcon: suffix,
        errorText: _validate ? errorText : null,
        hintText: hintText,
        hintStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w400, color: Themes.textColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color(0xFFDEDEDE),
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Themes.primaryColor,
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Themes.errorColor,
            width: 1.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color(0xFFDEDEDE),
            width: 1.0,
          ),
        ),
      ),
    );
  }
}

class CustomBotton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;
  final Color buttonBorderSideColor;
  final Function onPressed;

  final double buttonRadius;
  const CustomBotton({
    Key? key,
    required this.buttonText,
    this.buttonColor = Themes.primaryColor,
    this.buttonTextColor = Colors.white,
    this.buttonBorderSideColor = Themes.primaryColor,
    required this.onPressed,
    this.buttonRadius = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          buttonColor,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
            side: BorderSide(color: buttonBorderSideColor),
          ),
        ),
      ),
      onPressed: () {
        onPressed();
      },
      child: SizedBox(
        width: AppSize.calculateWidth(context, 180),
        height: AppSize.calculateHeight(context, 40),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                color: buttonTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
