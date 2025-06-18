import 'package:bashasagar/core/components/app_loading.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String? imageFile;
  final Widget? errorIcon;
  final String? imageVersion;

  final String? userName;
  final double? iconSize;
  final double? nameSize;
  final BoxFit? fit;
  final Color? userNameColor;
  const AppNetworkImage({
    super.key,
    required this.imageFile,
    this.errorIcon,
    this.imageVersion,
    this.iconSize,
    this.userName,
    this.nameSize,
    this.userNameColor,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        fit: fit,
        imageUrl: "${imageFile}?v=$imageVersion",
        placeholder: (context, url) => AppLoading(),
        errorListener: (value) {},
        errorWidget: (context, url, error) =>
            (userName != null && userName!.isNotEmpty)
                ? Center(
                    child: Text(
                      userName![0],
                      style: AppStyle.boldStyle(
                        fontSize: nameSize ?? ResponsiveHelper.fontMedium,
                        fontWeight: FontWeight.bold,
                        color: userNameColor ?? AppColors.kWhite,
                      ),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      errorIcon ??
                          Icon(
                            size: iconSize,
                            Icons.broken_image_rounded,
                            color: AppColors.kGrey,
                          ),
                      Text(
                        "Image not found!",
                        style: AppStyle.boldStyle(
                            color: AppColors.kGrey),
                      )
                    ],
                  ));
  }
}
