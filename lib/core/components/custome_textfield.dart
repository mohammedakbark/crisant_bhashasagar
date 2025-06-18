import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class CustomeTextField extends StatelessWidget {
  final String? title;
  final String? lebelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? sufix;
  final Widget? prefix;
  final bool? isObsecure;
  final TextInputAction? textInputAction;
  final TextInputType ?keyboardType;
  const CustomeTextField({
    super.key,
    this.title,
    required this.controller,
    this.validator,
    this.lebelText,
    this.sufix,
    this.prefix,
    this.isObsecure,
    this.textInputAction,
    this.keyboardType
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveHelper.wp * .85,
      child: Column(
        children: [
          title != null ? Text(title!) : SizedBox.shrink(),
          TextFormField(
            keyboardType: keyboardType,
            textInputAction: textInputAction ?? TextInputAction.done,
            controller: controller,
            validator: validator,
            style: AppStyle.normalStyle(),
            obscureText: isObsecure ?? false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              suffixIconConstraints: BoxConstraints(
                minWidth: ResponsiveHelper.wp * .1,
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: ResponsiveHelper.wp * .1,
              ),
              suffixIcon: sufix,
              prefixIcon: prefix,
              prefixIconColor: AppColors.kGrey,
              suffixIconColor: AppColors.kGrey,
              labelText: lebelText,
              labelStyle: AppStyle.normalStyle(color: AppColors.kGrey),
              enabledBorder: border(),
              focusedBorder: border(),
              errorBorder: border(color: AppColors.kRed),
              focusedErrorBorder: border(color: AppColors.kRed),
            ),
          ),
        ],
      ),
    );
  }

  InputBorder border({Color? color}) => OutlineInputBorder(
    borderSide: BorderSide(width: .6, color: color ?? AppColors.kGrey),
    borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadiusSmall),
  );
}
