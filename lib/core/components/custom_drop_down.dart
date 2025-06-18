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
  final String? lebelText;

  const CustomDropDown({
    super.key,
    this.title,
    required this.items,
    required this.onChanged,
    this.value,
    this.selectedValue,
    this.lebelText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveHelper.wp * .85,
      child: Column(
        children: [
          title != null ? Text(title!) : SizedBox.shrink(),
          DropdownButtonFormField(
            items:
                items
                    .map(
                      (e) => DropdownMenuItem(
                        value: e['value'],
                        child: Text(e['title']),
                      ),
                    )
                    .toList(),
            hint:
                selectedValue != null
                    ? Text(selectedValue!, style: AppStyle.normalStyle())
                    : null,
            value: value,
            onChanged: onChanged,
            dropdownColor: AppColors.kWhite,
            borderRadius: BorderRadius.circular(
              ResponsiveHelper.borderRadiusMedium,
            ),
            style: AppStyle.normalStyle(),
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.arrow_drop_down, color: AppColors.kGrey),
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
