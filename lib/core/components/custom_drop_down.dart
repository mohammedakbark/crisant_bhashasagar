import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final String? title;
  final List<Map<String, dynamic>> items;
  final void Function(dynamic)? onChanged;
  final dynamic value;
  final String? selectedValue;
  final String? labelText;
  final String? hintText;
  final double? width;
  final bool enableTextLetter;
  final Widget? prefix;

  const CustomDropDown({
    super.key,
    this.title,
    required this.items,
    required this.onChanged,
    this.value,
    this.selectedValue,
    this.labelText,
    this.enableTextLetter = false,
    this.width,
    this.prefix,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? ResponsiveHelper.wp * .85,
      child: Column(
        children: [
          title != null ? Text(title!) : SizedBox.shrink(),
            DropdownButtonFormField<Map<String, dynamic>>(
            items:
                items.map((item) {
                  final value = item['value'];
                  final title = item['title'] as String;
                  return DropdownMenuItem(
                    value: item,
                    child: Row(
                      children: [
                        enableTextLetter
                            ? Container(
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.kGrey,
                                borderRadius: BorderRadius.circular(
                                  ResponsiveHelper.borderRadiusXSmall,
                                ),
                              ),
                              child: Text(
                                title[0].toUpperCase(),
                                style: AppStyle.largeStyle(
                                  color: AppColors.kWhite,
                                ),
                              ),
                            )
                            : SizedBox.shrink(),
                        Text(
                          title,
                          style: AppStyle.normalStyle(color: AppColors.kBlack),
                        ),
                      ],
                    ),
                  );
                }).toList(),
            hint:
                selectedValue != null
                    ? Text(
                      selectedValue!,
                      style: AppStyle.normalStyle(color: AppColors.kBlack),
                    )
                    : hintText != null
                    ? Text(
                      hintText!,
                      style: AppStyle.normalStyle(color: AppColors.kGrey),
                    )
                    : null,
            value: value,
            onChanged: onChanged,
            dropdownColor: AppColors.kWhite,
            borderRadius: BorderRadius.circular(
              ResponsiveHelper.borderRadiusMedium,
            ),
            style: AppStyle.normalStyle(color: AppColors.kBlack),

            decoration: InputDecoration(
              prefixIcon: prefix,
              suffixIcon: Icon(Icons.arrow_drop_down, color: AppColors.kGrey),
              labelText: labelText,
              labelStyle: AppStyle.normalStyle(
                color: AppColors.kGrey,
                fontSize: ResponsiveHelper.fontSmall,
              ),
              floatingLabelStyle: AppStyle.normalStyle(color: AppColors.kGrey),
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
