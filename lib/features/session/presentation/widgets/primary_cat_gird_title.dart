import 'package:bashasagar/core/components/app_network_image.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/features/session/data/bloc/primary%20controller/primary_category_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PrimaryCatGirdTitle extends StatefulWidget {
  final String language;
  final String primaryCategoryId;
  final String primaryCategoryImage;
  final String languageId;
  final String primaryCategoryName;
  final int index;
  final bool isSelected;
  const PrimaryCatGirdTitle({
    super.key,
    required this.index,
    required this.isSelected,
    required this.language,
    required this.primaryCategoryId,
    required this.primaryCategoryImage,
    required this.languageId,
    required this.primaryCategoryName,
  });

  @override
  State<PrimaryCatGirdTitle> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PrimaryCatGirdTitle>
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
    context.read<PrimaryCategoryControllerCubit>().onChangeTab(widget.index);
    context.push(
      secondaryCategoryScreen,
      extra: {
        "primaryCategory": widget.primaryCategoryName,
        "languageId": widget.languageId,
        "primaryCategoryId": widget.primaryCategoryId,
        "language": widget.language,
      },
    );
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        widget.isSelected
                            ? AppColors.kPrimaryColor
                            : AppColors.kGrey,
                    width: widget.isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.borderRadiusLarge,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      child: AppNetworkImage(
                        imageFile: widget.primaryCategoryImage,
                      ),
                    ),
                    AppSpacer(hp: .02),
                    Text(widget.primaryCategoryName),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
