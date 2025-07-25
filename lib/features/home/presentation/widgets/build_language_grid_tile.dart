import 'package:bashasagar/core/components/app_network_image.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/features/home/data/models/dashboard_progress_model.dart';
import 'package:bashasagar/features/settings/data/get_ui_language.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BuildLanguageGridTile extends StatefulWidget {
  final int index;
  final DashboardLanguageProgressModel displayLangues;
  final String uiLanguageOfLesson;

  const BuildLanguageGridTile({
    super.key,
    required this.index,
    required this.uiLanguageOfLesson,
    required this.displayLangues,
  });

  @override
  State<BuildLanguageGridTile> createState() => _BuildLanguageGridTileState();
}

class _BuildLanguageGridTileState extends State<BuildLanguageGridTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _animationController.reverse();
    context
        .push(
          primaryCategoryScreen,
          extra: {
            "langaugeId": widget.displayLangues.languageId,
            "language": widget.displayLangues.details.languageName,
          },
        )
        .then((value) async {
          await GetUiLanguage.create("DASHBOARD");
        });
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor =
        widget.index.isEven ? AppColors.kSecondary : AppColors.kPrimaryLight;
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder:
            (context, child) => Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: ResponsiveHelper.paddingLarge,
                  horizontal: ResponsiveHelper.paddingXLarge,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: bgColor),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 1,
                      color: bgColor.withAlpha(120),
                    ),
                  ],
                  color: bgColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.borderRadiusXLarge,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              widget.displayLangues.details.languageName,
                              style: AppStyle.boldStyle(
                                fontSize: ResponsiveHelper.fontRegular,
                              ),
                            ),
                            Text(
                              "${widget.displayLangues.status.totalSecondaryCategories} ${widget.uiLanguageOfLesson}",
                              style: AppStyle.smallStyle(
                                // fontSize: ResponsiveHelper.fontRegular,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: AppNetworkImage(
                            imageFile:
                                widget.displayLangues.details.lanuageImageDark,
                          ),
                        ),
                      ],
                    ),
                    AppSpacer(hp: .02),

                    LinearProgressIndicator(
                      value: widget.displayLangues.status.percentage / 100,
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.kPrimaryDark,
                      backgroundColor: AppColors.kPrimaryDark.withAlpha(120),
                    ),
                    AppSpacer(hp: .005),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "${widget.displayLangues.status.percentage}%",
                        style: AppStyle.smallStyle(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
