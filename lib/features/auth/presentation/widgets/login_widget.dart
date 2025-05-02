import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex_app/core/common_widgets/staggered_animation.dart';
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
    final passwordFocusNode = useFocusNode();

    final animationControllers = useStaggeredControllers(
      configs: [
        const StaggeredAnimConfig(
          delay: Duration(milliseconds: 300),
          duration: Duration(milliseconds: 800),
        ),
        // Form animation
        const StaggeredAnimConfig(
          delay: Duration(milliseconds: 600),
          duration: Duration(milliseconds: 1000),
          curve: Curves.easeIn,
        ),
        // Button animation
        const StaggeredAnimConfig(
          delay: Duration(milliseconds: 900),
          duration: Duration(milliseconds: 800),
        ),
      ],
    );

    final titleController = animationControllers[0];
    final formController = animationControllers[1];
    final buttonController = animationControllers[2];

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

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLogoAnimation(context),
          gapW48,
          FadeSlideTransition(
            controller: titleController,
            child: Text(
              'Pokédex Login'.hardcoded,
              style: context.textStyles.headlineLarge,
            ),
          ),
          gapW48,
          FadeSlideTransition(
            controller: formController,
            offset: 30.0,
            child: Column(
              children: [
                gapH16,
                TextField(
                  controller: usernameController,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    passwordFocusNode.requestFocus();
                  },
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
                  focusNode: passwordFocusNode,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: login,
                  decoration: InputDecoration(
                    labelText: 'Password'.hardcoded,
                    prefixIcon: Icon(Icons.lock, color: context.colors.secondary),
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
          gapW16,
          FadeScaleTransition(
            controller: buttonController,
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
          gapW16,
          FadeScaleTransition(
            controller: buttonController,
            child: Text(
              'Default login: user / password'.hardcoded,
              style: TextStyle(color: context.colors.textSecondary),
            ),
          ),
        ],
      ),
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
