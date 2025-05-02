import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex_app/features/auth/presentation/widgets/login_widget.dart';


class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Pokédex Login')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: LoginWidget(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}