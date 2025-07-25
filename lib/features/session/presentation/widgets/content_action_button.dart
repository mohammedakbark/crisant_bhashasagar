import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class ContentActionButton extends StatefulWidget {
  final void Function()? onPressed;
  final String title;
  final bool isForward;
  final bool isEnabled;
  ContentActionButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.isForward,
    required this.isEnabled,
  });

  @override
  State<ContentActionButton> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ContentActionButton>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _animationController.forward();
  }

  void onTap() {
    setState(() => _isPressed = false);
    _animationController.reverse();
    if (widget.onPressed != null&&widget.isEnabled) widget.onPressed!();
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onTapCancel: _onTapCancel,
      onTapDown: _onTapDown,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder:
            (context, child) => Transform.scale(
              scale: _scaleAnimation.value,

              child: Container(
                width: ResponsiveHelper.wp * .325,

                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color:
                      !widget.isEnabled
                          ? AppColors.kBgColor
                          : AppColors.kPrimaryColor,
                ),
                // style: ElevatedButton.styleFrom(
                //   elevation: widget.isEnabled ? null : 0,
                //   backgroundColor:
                //       !widget.isEnabled
                //           ? AppColors.kBgColor
                //           : AppColors.kPrimaryColor,
                // ),
                // onPressed: widget.isEnabled ? widget.onPressed : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!widget.isForward) ...[
                      Icon(
                        Icons.arrow_back_ios_sharp,
                        color:
                            widget.isEnabled
                                ? AppColors.kWhite
                                : AppColors.kGrey,
                        size: 15,
                      ),
                      AppSpacer(wp: .005),
                    ],

                    Flexible(
                      flex: 3,
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        widget.title,
                        style: AppStyle.mediumStyle(
                          color:
                              widget.isEnabled
                                  ? AppColors.kWhite
                                  : AppColors.kGrey,
                        ),
                      ),
                    ),
                    if (widget.isForward) ...[
                      AppSpacer(wp: .005),
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        color:
                            widget.isEnabled
                                ? AppColors.kWhite
                                : AppColors.kGrey,
                        size: 15,
                      ),
                    ],
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
