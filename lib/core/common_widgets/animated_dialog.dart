import 'package:flutter/material.dart';

class AnimatedDialog extends StatelessWidget {
  const AnimatedDialog({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderRadius = 16.0,
    this.elevation = 4.0,
    this.insetPadding = const EdgeInsets.symmetric(
      horizontal: 40.0,
      vertical: 24.0,
    ),
    this.clipBehavior = Clip.antiAlias,
  });

  final Widget child;

  final Color? backgroundColor;

  final double borderRadius;

  final double elevation;

  final EdgeInsets insetPadding;

  final Clip clipBehavior;

  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool barrierDismissible = true,
    Duration transitionDuration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: transitionDuration,
      pageBuilder: (context, _, __) => builder(context),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(curvedAnimation),
          child: FadeTransition(
            opacity: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(curvedAnimation),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      backgroundColor: backgroundColor ?? theme.dialogTheme.backgroundColor,
      elevation: elevation,
      insetPadding: insetPadding,
      clipBehavior: clipBehavior,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
