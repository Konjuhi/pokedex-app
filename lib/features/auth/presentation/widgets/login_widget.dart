import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex_app/core/constants/app_sizes.dart';
import 'package:pokedex_app/core/localization/string_hardcoded.dart';
import 'package:pokedex_app/core/theme/tokens_provider.dart';
import 'package:pokedex_app/features/auth/domain/auth_controller.dart';

class LoginWidget extends HookConsumerWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isLoading = useState(false);
    final errorMessage = useState<String?>(null);

    final titleController = useAnimationController(
      duration: const Duration(milliseconds: 800),
    );
    final formController = useAnimationController(
      duration: const Duration(milliseconds: 1000),
    );
    final buttonController = useAnimationController(
      duration: const Duration(milliseconds: 800),
    );

    useEffect(() {
      Future.delayed(
        const Duration(milliseconds: 300),
        () => titleController.forward(),
      );
      Future.delayed(
        const Duration(milliseconds: 600),
        () => formController.forward(),
      );
      Future.delayed(
        const Duration(milliseconds: 900),
        () => buttonController.forward(),
      );
      return null;
    }, []);

    final titleOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: titleController, curve: Curves.easeOut));
    final titleOffset = Tween<double>(
      begin: 20.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: titleController, curve: Curves.easeOut));
    final formOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: formController, curve: Curves.easeIn));
    final formOffset = Tween<double>(
      begin: 30.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: formController, curve: Curves.easeOut));
    final buttonScale = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: buttonController, curve: Curves.easeOut));
    final buttonOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: buttonController, curve: Curves.easeIn));

    Future<void> login() async {
      if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
        errorMessage.value = 'Username and password cannot be empty'.hardcoded;
        return;
      }

      isLoading.value = true;
      errorMessage.value = null;

      final success = await ref
          .read(authControllerProvider.notifier)
          .login(usernameController.text, passwordController.text);

      isLoading.value = false;
      if (!success) {
        errorMessage.value = 'Invalid username or password'.hardcoded;
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLogoAnimation(context),
        gapW48,
        AnimatedBuilder(
          animation: titleController,
          builder:
              (_, __) => Opacity(
                opacity: titleOpacity.value,
                child: Transform.translate(
                  offset: Offset(0, titleOffset.value),
                  child: Text(
                    'Pokédex Login'.hardcoded,
                    style: context.textStyles.headlineMedium,
                  ),
                ),
              ),
        ),
        gapW48,
        AnimatedBuilder(
          animation: formController,
          builder:
              (_, __) => Opacity(
                opacity: formOpacity.value,
                child: Transform.translate(
                  offset: Offset(0, formOffset.value),
                  child: Column(
                    children: [
                      gapH16,
                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username'.hardcoded,
                          prefixIcon: Icon(
                            Icons.person,
                            color: context.colors.secondary,
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password'.hardcoded,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: context.colors.secondary,
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (errorMessage.value != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            errorMessage.value!,
                            style: TextStyle(color: context.colors.error),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
        ),
        gapW16,
        AnimatedBuilder(
          animation: buttonController,
          builder:
              (_, __) => Opacity(
                opacity: buttonOpacity.value,
                child: Transform.scale(
                  scale: buttonScale.value,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading.value ? null : login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colors.primary,
                        foregroundColor: context.colors.textLight,
                        padding: const EdgeInsets.all(16),
                      ),
                      child:
                          isLoading.value
                              ? CircularProgressIndicator(
                                color: context.colors.textLight,
                              )
                              : Text('Login'.hardcoded),
                    ),
                  ),
                ),
              ),
        ),
        gapW16,
        AnimatedBuilder(
          animation: buttonController,
          builder:
              (_, __) => Opacity(
                opacity: buttonOpacity.value,
                child: Text(
                  'Default login: user / password'.hardcoded,
                  style: TextStyle(color: context.colors.textSecondary),
                ),
              ),
        ),
      ],
    );
  }

  Widget _buildLogoAnimation(BuildContext context) {
    try {
      return Lottie.asset(
        'assets/animations/pokemon_login.json',
        width: 150,
        height: 150,
        repeat: true,
        animate: true,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallbackAnimation(context);
        },
      );
    } catch (e) {
      return _buildFallbackAnimation(context);
    }
  }

  Widget _buildFallbackAnimation(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: context.colors.surface,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          Icons.catching_pokemon,
          size: 80,
          color: context.colors.primary,
        ),
      ),
    );
  }
}
