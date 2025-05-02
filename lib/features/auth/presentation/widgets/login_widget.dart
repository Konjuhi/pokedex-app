import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../domain/auth_controller.dart';

class LoginWidget extends HookConsumerWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isLoading = useState(false);
    final errorMessage = useState<String?>(null);

    final iconController = useAnimationController(
      duration: const Duration(milliseconds: 1200),
    );
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
      iconController.forward();
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

    final iconScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: iconController, curve: Curves.elasticOut),
    );
    final iconRotation = Tween<double>(begin: 0.5, end: 0.0).animate(
      CurvedAnimation(parent: iconController, curve: Curves.elasticOut),
    );
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
        errorMessage.value = 'Username and password cannot be empty';
        return;
      }

      isLoading.value = true;
      errorMessage.value = null;

      final success = await ref
          .read(authControllerProvider.notifier)
          .login(usernameController.text, passwordController.text);

      isLoading.value = false;
      if (!success) errorMessage.value = 'Invalid username or password';
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: iconController,
          builder:
              (_, __) => Transform.scale(
                scale: iconScale.value,
                child: Transform.rotate(
                  angle: iconRotation.value,
                  child: const Icon(
                    Icons.catching_pokemon,
                    size: 80,
                    color: Colors.red,
                  ),
                ),
              ),
        ),
        gapW48,
        AnimatedBuilder(
          animation: titleController,
          builder:
              (_, __) => Opacity(
                opacity: titleOpacity.value,
                child: Transform.translate(
                  offset: Offset(0, titleOffset.value),
                  child: const Text(
                    'Pokédex Login',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (errorMessage.value != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            errorMessage.value!,
                            style: const TextStyle(color: Colors.red),
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
                        padding: const EdgeInsets.all(16),
                      ),
                      child:
                          isLoading.value
                              ? const CircularProgressIndicator()
                              : const Text('Login'),
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
                child: const Text(
                  'Default login: user / password',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
        ),
      ],
    );
  }
}
