import 'package:animate_do/animate_do.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/features/session/data/bloc/content%20state%20controller/content_state_controller_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class AudioPlayButton extends StatefulWidget {
  final String primaryCategoryId;
  final String secondaryCategoryId;
  final bool? isAudioPlaying;
  final String contentAudio;
  const AudioPlayButton({
    super.key,
    required this.primaryCategoryId,
    required this.secondaryCategoryId,
    required this.isAudioPlaying,
    required this.contentAudio,
  });

  @override
  State<AudioPlayButton> createState() => _AudioPlayButtonState();
}

class _AudioPlayButtonState extends State<AudioPlayButton>
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
    context.read<ContentStateControllerBloc>().add(
      PlayAudio(
        primaryCategoryId: widget.primaryCategoryId,
        secondaryCategoryId: widget.secondaryCategoryId,
      ),
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

        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,

            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: Offset(3, 2),
                    color: AppColors.kOrange.withAlpha(100),
                  ),
                ],
                color: AppColors.kOrange,
                shape: BoxShape.circle,
              ),
              height: 70,
              width: 70,
              child:
                  widget.isAudioPlaying == true
                      ? FadeIn(
                        key: GlobalObjectKey(widget.contentAudio),
                        child: Lottie.asset(
                          errorBuilder:
                              (context, error, stackTrace) => Icon(
                                CupertinoIcons.speaker_3,
                                color: AppColors.kWhite,
                              ),
                          "assets/json/paying audio.json",
                        ),
                      )
                      : FadeIn(
                        key: GlobalObjectKey(widget.contentAudio),
                        child: Icon(
                          CupertinoIcons.speaker_3,
                          color: AppColors.kWhite,
                        ),
                      ),
            ),
          );
        },
      ),
    );
  }
}
