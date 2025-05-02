import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/constants/app_sizes.dart';

class EmptySearchAnimation extends HookWidget {
  const EmptySearchAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    final iconController = useAnimationController(
      duration: const Duration(seconds: 1),
    );

    final textController = useAnimationController(
      duration: const Duration(milliseconds: 800),
    );

    final subtitleController = useAnimationController(
      duration: const Duration(milliseconds: 800),
    );

    useEffect(() {
      iconController.forward();

      Future.delayed(const Duration(milliseconds: 200), () {
        if (textController.isDismissed) {
          textController.forward();
        }
      });

      Future.delayed(const Duration(milliseconds: 500), () {
        if (subtitleController.isDismissed) {
          subtitleController.forward();
        }
      });

      return null;
    }, []);

    final iconScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: iconController, curve: Curves.elasticOut),
    );

    final iconRotation = Tween<double>(begin: -0.2, end: 0.0).animate(
      CurvedAnimation(parent: iconController, curve: Curves.elasticOut),
    );

    final textOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: textController, curve: Curves.easeOut));

    final textOffset = Tween<double>(
      begin: 20.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: textController, curve: Curves.easeOut));

    final subtitleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: subtitleController, curve: Curves.easeOut),
    );

    final subtitleOffset = Tween<double>(begin: 20.0, end: 0.0).animate(
      CurvedAnimation(parent: subtitleController, curve: Curves.easeOut),
    );

    return Center(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: iconController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: iconScale.value,
                    child: Transform.rotate(
                      angle: iconRotation.value,
                      child: const Icon(
                        Icons.catching_pokemon,
                        size: 100,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              ),
              gapW24,
              AnimatedBuilder(
                animation: textController,
                builder: (context, child) {
                  return Opacity(
                    opacity: textOpacity.value,
                    child: Transform.translate(
                      offset: Offset(0, textOffset.value),
                      child: const Text(
                        'Search to find your favorite Pokémon!',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
              gapW24,
              AnimatedBuilder(
                animation: subtitleController,
                builder: (context, child) {
                  return Opacity(
                    opacity: subtitleOpacity.value,
                    child: Transform.translate(
                      offset: Offset(0, subtitleOffset.value),
                      child: const Text(
                        'Try typing a Pokémon ability like "blaze" or press "Surprise Me!"',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
