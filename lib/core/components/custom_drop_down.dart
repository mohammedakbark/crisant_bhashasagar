import 'package:bashasagar/core/components/custom_network_img.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final String? title;
  final List<Map<String, dynamic>> items;
  final void Function(dynamic)? onChanged;
  // final dynamic value;
  final Map<String, dynamic>? selectedValue;
  final String? labelText;
  final String? hintText;
  final double? width;

  final Widget? prefix;

  const CustomDropDown({
    super.key,
    this.title,
    required this.items,
    required this.onChanged,
    // this.value,
    required this.selectedValue,
    this.labelText,

    this.width,
    this.prefix,
    this.hintText,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? ResponsiveHelper.wp * .85,
      child: Column(
        children: [
          widget.title != null ? Text(widget.title!) : SizedBox.shrink(),
          DropdownButtonFormField<Map<String, dynamic>>(
            value:
                widget.selectedValue != null
                    ? widget.items.firstWhere(
                      (item) => item['value'] == widget.selectedValue!['value'],
                    )
                    : null,
            items:
                widget.items.map((item) {
                  final value = item['value'];
                  final title = item['title'] as String;
                  final langIcon = item['icon'] as String?;
                  return DropdownMenuItem(
                    value: item,
                    child: Row(
                      children: [
                        langIcon != null
                            ? Container(
                              height: 30,
                              width: 30,
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
                              child: CustomNetworkImg(path: langIcon),
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
                // selectedValue != null
                //     ? Text(
                //       selectedValue!,
                //       style: AppStyle.normalStyle(color: AppColors.kBlack),
                //     )
                widget.hintText != null
                    ? Text(
                      widget.hintText!,
                      style: AppStyle.normalStyle(color: AppColors.kGrey),
                    )
                    : null,
            onChanged: widget.onChanged,
            dropdownColor: AppColors.kWhite,
            borderRadius: BorderRadius.circular(
              ResponsiveHelper.borderRadiusMedium,
            ),
            style: AppStyle.normalStyle(color: AppColors.kBlack),

            decoration: InputDecoration(
              prefixIcon: widget.prefix,
              suffixIcon: Icon(Icons.arrow_drop_down, color: AppColors.kGrey),
              labelText: widget.labelText,
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
