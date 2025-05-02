import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StaggeredAnimConfig {
  const StaggeredAnimConfig({
    required this.delay,
    required this.duration,
    this.curve = Curves.easeOut,
  });
  
  final Duration delay;
  final Duration duration;
  final Curve curve;
}

List<AnimationController> useStaggeredControllers({
  required List<StaggeredAnimConfig> configs,
}) {
  final controllers = <AnimationController>[];
  
  for (final config in configs) {
    controllers.add(
      useAnimationController(duration: config.duration),
    );
  }
  
  useEffect(() {
    for (int i = 0; i < controllers.length; i++) {
      Future.delayed(
        configs[i].delay,
        () => controllers[i].forward(),
      );
    }
    return null;
  }, []);
  
  return controllers;
}

class FadeSlideTransition extends HookWidget {
  const FadeSlideTransition({
    super.key,
    required this.controller,
    required this.child,
    this.offset = 20.0,
    this.curve = Curves.easeOut,
  });

  final AnimationController controller;
  final Widget child;
  final double offset;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final opacityAnim = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: curve));
    
    final offsetAnim = Tween<double>(
      begin: offset,
      end: 0.0,
    ).animate(CurvedAnimation(parent: controller, curve: curve));

    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) => Opacity(
        opacity: opacityAnim.value,
        child: Transform.translate(
          offset: Offset(0, offsetAnim.value),
          child: child,
        ),
      ),
    );
  }
}

class FadeScaleTransition extends HookWidget {
  const FadeScaleTransition({
    super.key,
    required this.controller,
    required this.child,
    this.beginScale = 0.8,
    this.curve = Curves.easeOut,
  });

  final AnimationController controller;
  final Widget child;
  final double beginScale;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final opacityAnim = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: curve));
    
    final scaleAnim = Tween<double>(
      begin: beginScale,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: curve));

    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) => Opacity(
        opacity: opacityAnim.value,
        child: Transform.scale(
          scale: scaleAnim.value,
          child: child,
        ),
      ),
    );
  }
} 