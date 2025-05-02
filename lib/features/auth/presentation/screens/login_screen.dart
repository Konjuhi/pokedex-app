import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex_app/core/theme/tokens_provider.dart';
import 'package:pokedex_app/features/auth/presentation/widgets/login_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: Stack(
          children: [
            _buildBackgroundAnimation(),
            const Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: LoginWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBackgroundAnimation() {
    return Positioned.fill(
      child: Opacity(
        opacity: 0.07,
        child: FittedBox(
          fit: BoxFit.cover,
          child: Lottie.asset(
            'assets/animations/pokemon_login.json',
            repeat: true,
            animate: true,
          ),
        ),
      ),
    );
  }
}