import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/constants/app_sizes.dart';

class EmptyPokedexAnimation extends HookWidget {
  const EmptyPokedexAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    final iconController = useAnimationController(
      duration: const Duration(milliseconds: 1500),
    );
    
    final titleController = useAnimationController(
      duration: const Duration(milliseconds: 800),
    );
    
    final subtitleController = useAnimationController(
      duration: const Duration(milliseconds: 800),
    );

    useEffect(() {
      iconController.forward();
      
      Future.delayed(const Duration(milliseconds: 400), () {
        titleController.forward();
      });
      
      Future.delayed(const Duration(milliseconds: 800), () {
        subtitleController.forward();
      });
      
      return null;
    }, []);

    final iconScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: iconController, curve: Curves.elasticOut),
    );
    
    final iconRotation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: iconController, curve: Curves.elasticOut),
    );
    
    final titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: titleController, curve: Curves.easeOut),
    );
    
    final titleOffset = Tween<double>(begin: 20.0, end: 0.0).animate(
      CurvedAnimation(parent: titleController, curve: Curves.easeOut),
    );
    
    final subtitleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: subtitleController, curve: Curves.easeIn),
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
                        size: 80, 
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              ),
              gapW16,
              AnimatedBuilder(
                animation: titleController,
                builder: (context, child) {
                  return Opacity(
                    opacity: titleOpacity.value,
                    child: Transform.translate(
                      offset: Offset(0, titleOffset.value),
                      child: const Text(
                        'Your Pokédex is empty',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              AnimatedBuilder(
                animation: subtitleController,
                builder: (context, child) {
                  return Opacity(
                    opacity: subtitleOpacity.value,
                    child: Transform.translate(
                      offset: Offset(0, subtitleOffset.value),
                      child: const Text(
                        'Search for Pokémon to add them here',
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
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